require 'minitest_helper'
require 'privatbank/signature'

class TestSignature < MiniTest::Unit::TestCase

  def test_signature_generate_with_spaces
    password = 'secret'
    data     = ' <xml><data>data</data></xml> '
    assert_equal 'd6cef1996732a32ccecdfd5a22dd56a3ee50afb9',
                 Privatbank::Signature.generate(data, password)
  end

  def test_signature_generate_without_spaces
    password = 'secret'
    data     = '<xml><data>data</data></xml>'
    assert_equal 'd6cef1996732a32ccecdfd5a22dd56a3ee50afb9',
                 Privatbank::Signature.generate(data, password)
  end

end
