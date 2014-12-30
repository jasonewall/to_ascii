# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ascii_tables/version'

Gem::Specification.new do |spec|
  spec.name          = "ascii_tables"
  spec.version       = ToAscii::VERSION
  spec.authors       = ["Jason Wall"]
  spec.email         = ["javajo@gmail.com"]
  spec.summary       = %q{#to_ascii a collection}
  spec.description   = %q{Adds the #to_ascii method to a number of collection type classes to print out a nicely formatted
  ASCII table of the attributes of each element.}
  spec.homepage      = "http://github.com/thejayvm/to_ascii"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
