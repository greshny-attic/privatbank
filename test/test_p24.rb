require 'minitest_helper'

Privatbank.configure do |config|
  config.merchant_id       = 'some-id-of-merchant'
  config.merchant_password = 'some-secret-password'
end

require 'privatbank/p24'

class TestP24 < MiniTest::Unit::TestCase

  def test_account_statement
    VCR.insert_cassette 'account_statement'

    card_number = '1111222233334444'
    from_date   = DateTime.parse('2001-01-01')
    till_date   = DateTime.parse('2002-01-01')

    options = { card_number: card_number,
                from_date: from_date,
                till_date: till_date }

    assert_equal true, Privatbank::P24.account_statement(card_number, options) != ''

    VCR.eject_cassette 'account_statement'
  end
end
