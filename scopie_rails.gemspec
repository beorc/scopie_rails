# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'scopie_rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'scopie_rails'
  s.version     = ScopieRails::VERSION
  s.authors     = ['Yury Kotov']
  s.email       = ['non.gi.suong@ya.ru']
  s.homepage    = 'https://github.com/beorc/scopie_rails'
  s.summary     = 'scopie for rails'
  s.description = 'scopie_rails provides integration between scopie and rails'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'README.md']

  s.add_runtime_dependency 'scopie', '~> 0'
  s.add_runtime_dependency 'actionpack', '>= 3.2', '< 5.1'
  s.add_runtime_dependency 'activesupport', '>= 3.2', '< 5.1'
end
