# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'full_dup/version'

Gem::Specification.new do |spec|
  spec.name          = "full_dup"
  spec.version       = FullDup::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.description   = "A (safe/no exceptions) dup variant that performs a deep, recursive copy."
  spec.summary       = "A dup variant that performs a deep copy."
  spec.homepage      = "https://github.com/PeterCamilleri/full_dup"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'minitest', "~> 5.7"
  spec.add_development_dependency 'minitest_visible', "~> 0.1"
end
