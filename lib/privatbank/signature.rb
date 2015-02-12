require 'digest/md5'
require 'digest/sha1'

module Privatbank
  module Signature extend self

    def generate data, password
      Digest::SHA1.hexdigest md5_hash(data, password)
    end

    private

    def md5_hash(data, password)
      Digest::MD5.hexdigest(data.strip + password)
    end

  end
end
