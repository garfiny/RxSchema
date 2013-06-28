# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'RxSchema/version'

Gem::Specification.new do |spec|
  spec.name          = "RxSchema"
  spec.version       = RxSchema::VERSION
  spec.authors       = ["Shuo Zhao"]
  spec.email         = ["shuo.zhao.mx@gmail.com"]
  spec.description   = %q{generate ruby class through xml schema}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "activesupport", "~> 4.0.0.rc2"

  spec.add_runtime_dependency "virtus", "~> 1.0.0.beta0"
end
