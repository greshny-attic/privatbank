require 'date'
require 'builder'
require 'privatbank/signature'
require 'httparty'

module Privatbank
  module P24
    class PaymentStatus

      include HTTParty

      base_uri 'https://api.privatbank.ua'

      def initialize payment_id, ref, options={}
        @payment_id        = payment_id
        @ref               = ref
        @merchant_id       = options[:merchant_id]
        @merchant_password = options[:merchant_password]
      end

      def request
        response = self.class.post('/p24api/check_pay', body: outgoing_xml)
        return 'error' if response.fetch('error', nil)
        response['response']['data']
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
            d.payment(id: @payment_id) do |p|
              p.prop(name: 'id',   value: @payment_id)
              p.prop(name: 'ref',   value: @ref)
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
        builder.payment(id: @payment_id) do |p|
          p.prop(name: 'id',   value: @payment_id)
          p.prop(name: 'ref',   value: @ref)
        end
        builder.target!
      end

      def signature
        Privatbank::Signature.generate(request_xml_data, @merchant_password)
      end

    end
  end
end
