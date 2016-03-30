require 'minitest_helper'
require 'privatbank/p24/payment_status'

class TestP24PaymentStatus < MiniTest::Unit::TestCase

  def test_outgoing_xml
    merchant_id       = 'some-id-of-merchant'
    merchant_password = 'some-secret-password'
    payment_id        = 'some-id'
    ref               = 'P123451234512341'

    options = {
      merchant_id: merchant_id,
      merchant_password: merchant_password,
    }

    as = Privatbank::P24::PaymentStatus.new(payment_id, ref, options)
    assert_equal true, as.outgoing_xml != ''
  end

end
