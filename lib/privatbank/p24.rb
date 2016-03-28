require 'privatbank/p24/account_statement'
require 'privatbank/p24/send_money_pb'
require 'privatbank/p24/send_money_visa'

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
  end
end
