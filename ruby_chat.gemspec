# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_chat/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_chat"
  spec.version       = RubyChat::VERSION
  spec.authors       = ["Dan Bickford"]
  spec.email         = ["danbickford007@yahoo.com"]
  spec.summary       = %q{Chat for ruby and rails developers to communicate and share ideas and help.}
  spec.description   = %q{Enter the chat to create topics, watch conversations, chime in on conversations and look at past discussions.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency 'colorize'
  spec.add_dependency 'json'
end
