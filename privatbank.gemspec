# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'privatbank/version'

Gem::Specification.new do |spec|
  spec.name          = 'privatbank'
  spec.version       = Privatbank::VERSION
  spec.authors       = ['Roman Greshny']
  spec.email         = ['greshny@gmail.com']
  spec.summary       = %q{Privat24 API wrapper}
  spec.description   = %q{Privat24 API wrapper}
  spec.homepage      = 'http://github.com/greshny/privatbank'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'hashie'
  spec.add_dependency 'builder'
  spec.add_dependency 'httparty'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 4.7.5'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
