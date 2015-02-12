module Privatbank
  class Configuration

    attr_accessor :merchant_id, :merchant_password

    def [](value)
      self.public_send(value)
    end

  end
end
