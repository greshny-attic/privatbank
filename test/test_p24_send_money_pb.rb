require 'minitest_helper'
require 'privatbank/p24/send_money_pb'

class TestP24SendMoneyPB < MiniTest::Unit::TestCase

  def test_outgoing_xml
    merchant_id       = 'some-id-of-merchant'
    merchant_password = 'some-secret-password'
    receiver          = '1111222233334444'
    payment_id        = '12345'
    amount            = 100
    currency          = 'UAH'
    details           = 'some-details'    

    options = {
      merchant_id: merchant_id,
      merchant_password: merchant_password,
    }

    as = Privatbank::P24::SendMoneyPB.new(receiver, payment_id, amount, currency, details, options)
    assert_equal true, as.outgoing_xml != ''
  end

end
