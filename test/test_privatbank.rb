require 'minitest_helper'

class TestPrivatbank < MiniTest::Unit::TestCase

  def test_that_it_has_a_version_number
    refute_nil ::Privatbank::VERSION
  end

  def test_configure_block
    Privatbank.configure do |config|
      config.merchant_id = 'merchant_identifier'
      config.merchant_password = 'secret'
    end

    assert_equal 'merchant_identifier', Privatbank.configuration.merchant_id
    assert_equal 'secret',              Privatbank.configuration.merchant_password

    assert_equal 'merchant_identifier', Privatbank.configuration[:merchant_id]
    assert_equal 'secret',              Privatbank.configuration[:merchant_password]
  end

  def test_configure_set_not_exists_attribute
    assert_raises NoMethodError do
      Privatbank.configure do |config|
        config.unknown_attribute = 'something'
      end
    end
  end

  def test_configure_get_not_exists_attribute
    assert_raises NoMethodError do
      Privatbank.configuration.unknown_attribute
    end
  end

end
