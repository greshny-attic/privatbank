require 'date'
require 'builder'
require 'privatbank/p24/items/transaction'
require 'privatbank/signature'
require 'httparty'

module Privatbank
  module P24
    class AccountStatement

      include HTTParty

      base_uri 'https://api.privatbank.ua'

      def initialize card_number, options={}
        @card_number       = card_number
        @from_date         = options[:from_date]
        @till_date         = options[:till_date]
        @merchant_id       = options[:merchant_id]
        @merchant_password = options[:merchant_password]
      end

      def request
        response = self.class.post('/p24api/rest_fiz', body: outgoing_xml)
        return [] if response.fetch('error', nil)
        statements = response['response']['data']['info']['statements']['statement']
        statements = [statements] if statements.is_a?(Hash)
        statements.map do |operation|
          Items::Transaction.new( date:           operation['trandate'],
                                  time:           operation['trantime'],
                                  amount:         operation['amount'],
                                  card_amount:    operation['cardamount'],
                                  rest:           operation['rest'],
                                  description:    operation['terminal'],
                                  transaction_id: operation['appcode'])
        end
      end

      def outgoing_xml
        builder = Builder::XmlMarkup.new
        builder.instruct!
        builder.request(version: '1.0') do |req|
          req.merchant do |merch|
            merch.id(@merchant_id)
            merch.signature(signature)
          end
          req.data do |d|
            d.oper('cmt')
            d.wait(0)
            d.payment(id: '') do |p|
              p.prop(name: 'sd',   value: from_date)
              p.prop(name: 'ed',   value: till_date)
              p.prop(name: 'card', value: @card_number)
            end
          end
        end
        builder.target!
      end

      def request_xml_data
        builder = Builder::XmlMarkup.new
        builder.oper('cmt')
        builder.wait(0)
        builder.payment(id: '') do |p|
          p.prop(name: 'sd',   value: from_date)
          p.prop(name: 'ed',   value: till_date)
          p.prop(name: 'card', value: @card_number)
        end
        builder.target!
      end

      def signature
        Privatbank::Signature.generate(request_xml_data, @merchant_password)
      end


      def from_date
        @from_date.strftime('%d.%m.%Y')
      end

      def till_date
        @till_date.strftime('%d.%m.%Y')
      end

    end
  end
end
