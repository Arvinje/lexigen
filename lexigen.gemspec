# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lexigen/version'

Gem::Specification.new do |spec|
  spec.name          = "lexigen"
  spec.version       = Lexigen::VERSION
  spec.authors       = ["Arvin Jenabi"]
  spec.email         = ["Arvinje@gmail.com"]

  spec.summary       = %q{A lexer generator in Ruby.}
  spec.description   = %q{A simple lexer generator that converts the existing state machine to a working lexer.}
  spec.homepage      = "https://github.com/Arvinje/lexigen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.6.4"
  spec.add_development_dependency "terminal-notifier-guard", "~> 1.6.4"
end
