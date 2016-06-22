# frozen_string_literal: true
require 'bundler/gem_tasks'

task :console do
  require 'pry'
  lib = File.expand_path('lib')
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
  require 'scopie_rails'
  ARGV.clear
  Pry.start
end
