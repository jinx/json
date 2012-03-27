require File.dirname(__FILE__) + '/lib/jinx/json/version'
require 'date'

Gem::Specification.new do |s|
  s.name          = 'jinx-json'
  s.summary       = 'Jinx JSON plug-in.'
  s.version       = Jinx::JSON::VERSION
  s.description   = s.summary + '. See github.com/jinx/json for more information.'
  s.date          = Date.today
  s.author        = 'OHSU'
  s.email         = "jinx.ruby@gmail.com"
  s.homepage      = 'http://github.com/jinx/json'
  s.platform      = Gem::Platform::RUBY
  s.require_path  = 'lib'
  s.bindir        = 'bin'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files test spec`.split("\n")
  s.add_dependency 'bundler'
  s.add_dependency 'jinx'
  s.add_dependency 'json_pure'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 1.3.2'
  s.has_rdoc      = 'yard'
  s.license       = 'MIT'
  s.rubyforge_project = 'jinx'
end
