require 'minitest_helper'
require 'privatbank/p24/account_statement'

class TestP24AccountStatement < MiniTest::Unit::TestCase

  def test_outgoing_xml
    merchant_id       = 'some-id-of-merchant'
    merchant_password = 'some-secret-password'
    card_number       = '1111222233334444'
    from_date         = DateTime.parse('2001-01-01')
    till_date         = DateTime.parse('2002-01-01')

    options = {
      merchant_id: merchant_id,
      merchant_password: merchant_password,
      card_number: card_number,
      from_date: from_date,
      till_date: till_date
    }

    as = Privatbank::P24::AccountStatement.new(card_number, options)
    assert_equal true, as.outgoing_xml != ''
  end

end
