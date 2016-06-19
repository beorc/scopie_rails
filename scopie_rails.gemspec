$:.push File.expand_path('../lib', __FILE__)

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
  s.description = 'scopie provides integration between
    scopie and rails'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'README.md']
end
