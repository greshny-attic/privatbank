require 'date'
require 'builder'
require 'privatbank/signature'
require 'httparty'

module Privatbank
  module P24
    class Info

      include HTTParty

      base_uri 'https://api.privatbank.ua'

      def initialize card_number, country, options
        @card_number       = card_number
        @country           = country
        @merchant_id       = options[:merchant_id]
        @merchant_password = options[:merchant_password]
      end

      def request
        response = self.class.post('/p24api/balance', body: outgoing_xml)['response']['data']
        response['error'] || response['info']['cardbalance']
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
            d.test(0)
            d.payment(id: '') do |p|
              p.prop(name: 'cardnum',   value: @card_number)
              p.prop(name: 'country',   value: @country)
            end
          end
        end
        builder.target!
      end

      def request_xml_data
        builder = Builder::XmlMarkup.new
        builder.oper('cmt')
        builder.wait(0)
        builder.test(0)
        builder.payment(id: '') do |p|
          p.prop(name: 'cardnum',   value: @card_number)
          p.prop(name: 'country',   value: @country)
        end
        builder.target!
      end

      def signature
        Privatbank::Signature.generate(request_xml_data, @merchant_password)
      end

    end
  end
end
