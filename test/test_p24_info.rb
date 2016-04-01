require 'minitest_helper'
require 'privatbank/p24/info'

class TestP24Info < MiniTest::Unit::TestCase

  def test_outgoing_xml
    merchant_id       = 'some-id-of-merchant'
    merchant_password = 'some-secret-password'
    card_number       = '1111222233334444'
    country           = 'UA'

    options = {
      merchant_id: merchant_id,
      merchant_password: merchant_password,
    }

    as = Privatbank::P24::Info.new(card_number, country, options)
    assert_equal true, as.outgoing_xml != ''
  end

end
