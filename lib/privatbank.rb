require 'privatbank/version'
require 'privatbank/configuration'

module Privatbank

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
