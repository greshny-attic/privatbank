require 'minitest_helper'
require 'privatbank/p24/exchange_rates'

class TestExchangeRates < MiniTest::Unit::TestCase

  def test_cash_exchange
    VCR.insert_cassette 'cash_exchange'
    assert_equal 3, Privatbank::P24::ExchangeRates.cash.count
    VCR.eject_cassette 'cash_exchange'
  end

  def test_card_exchange
    VCR.insert_cassette 'card_exchange'
    assert_equal 3, Privatbank::P24::ExchangeRates.card.count
    VCR.eject_cassette 'card_exchange'
  end

  def test_nbu_exchange
    VCR.insert_cassette 'nbu_exchange'
    assert_equal 3, Privatbank::P24::ExchangeRates.nbu.count
    VCR.eject_cassette 'nbu_exchange'
  end

end
