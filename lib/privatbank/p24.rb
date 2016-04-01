require 'privatbank/p24/account_statement'
require 'privatbank/p24/send_money_pb'
require 'privatbank/p24/send_money_visa'
require 'privatbank/p24/payment_status'
require 'privatbank/p24/info'

module Privatbank
  module P24

    def self.account_statement card_number, options
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      AccountStatement.new(card_number, options).request
    end

    def self.send_money_pb receiver, payment_id, amount, details, currency = 'UAH', options = {}
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      SendMoneyPB.new(receiver, payment_id, amount, currency, details, options).request
    end

    def self.send_money_visa receiver, full_name, payment_id, amount, details, currency = 'UAH', options = {}
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      SendMoneyVisa.new(receiver, full_name, payment_id, amount, currency, details, options).request
    end

    def self.info card_number, country = 'UA', options = {}
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      Info.new(card_number, country, options).request
    end

    def self.payment_status payment_id, ref, options = {}
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      PaymentStatus.new(payment_id, ref, options).request
    end

  end
end
