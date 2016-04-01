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

  def test_send_money_pb
    VCR.insert_cassette 'send_money_pb'

    receiver          = '1111222233334444'
    payment_id        = '12345'
    amount            = 100
    details           = 'some-details'    

    assert_equal true, Privatbank::P24.send_money_pb(receiver, payment_id, amount, details) != ''

    VCR.eject_cassette 'send_money_pb'
  end

  def test_send_money_visa
    VCR.insert_cassette 'send_money_visa'

    receiver          = '1111222233334444'
    full_name          = 'Some Full Name'
    payment_id        = '12345'
    amount            = 100
    details           = 'some-details'    

    assert_equal true, Privatbank::P24.send_money_visa(receiver, full_name, payment_id, amount, details) != ''

    VCR.eject_cassette 'send_money_visa'
  end

  def test_info
    VCR.insert_cassette 'info'

    card_number       = '1111222233334444'

    assert_equal true, Privatbank::P24.info(card_number) != ''

    VCR.eject_cassette 'info'
  end


  def test_payment_info
    VCR.insert_cassette 'payment_status'

    payment_id        = 'some-id'
    ref               = 'P123451234512341'

    assert_equal true, Privatbank::P24.payment_status(payment_id, ref) != ''

    VCR.eject_cassette 'payment_status'
  end
end
