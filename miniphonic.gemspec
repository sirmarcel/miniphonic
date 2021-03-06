# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'miniphonic/version'

Gem::Specification.new do |spec|
  spec.name          = "miniphonic"
  spec.version       = Miniphonic::VERSION
  spec.authors       = ["sirmarcel"]
  spec.email         = ["me@lumenlog.com"]
  spec.description   = %q{Miniphonic is a wrapper for the Auphonic.com API}
  spec.summary       = %q{Wraps the Auphonic API in delicious Ruby, for audio processing bliss.}
  spec.homepage      = "https://github.com/sirmarcel/miniphonic"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "vcr"
  spec.add_runtime_dependency "multi_json"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "mime-types"
end
