$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'privatbank'

require 'minitest/autorun'
require 'pry'

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
end
