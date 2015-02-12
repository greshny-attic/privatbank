require 'httparty'
require 'privatbank/p24/items/exchanges'

module Privatbank
  module P24
    class ExchangeRates
      include HTTParty

      base_uri 'https://api.privatbank.ua/p24api/'

      class << self
        def cash
          parse get('/pubinfo?exchange&coursid=5')
        end

        def card
          parse get('/pubinfo?cardExchange')
        end

        def nbu
          parse get('/pubinfo?exchange&coursid=3')
        end

        private

        def parse resp
          resp.parsed_response['exchangerates']['row'].map do |rate|
            Items::Exchanges.new rate['exchangerate']
          end
        end
      end

    end
  end
end
