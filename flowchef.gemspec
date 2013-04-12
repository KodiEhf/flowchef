# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flowchef/version'

Gem::Specification.new do |spec|
  spec.name          = "flowchef"
  spec.version       = Flowchef::VERSION
  spec.authors       = ["Ómar Kjartan Yasin"]
  spec.email         = ["omar@kodi.is"]
  spec.description   = "Send chef run information to a Flowdock channel"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "chef"
  spec.add_dependency "flowdock"
end
