require 'hashie'

module Privatbank
  module P24

    module Items
      class Transaction < Hashie::Dash
        property :transaction_id
        property :date
        property :time
        property :amount
        property :card_amount
        property :rest
        property :description
      end
    end

  end
end
