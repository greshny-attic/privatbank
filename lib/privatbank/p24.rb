require 'privatbank/p24/account_statement'

module Privatbank
  module P24

    def self.account_statement card_number, options
      options.merge!(merchant_id:       Privatbank.configuration.merchant_id,
                     merchant_password: Privatbank.configuration.merchant_password)
      AccountStatement.new(card_number, options).request
    end

  end
end
