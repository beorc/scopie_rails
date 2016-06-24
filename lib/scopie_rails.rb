# frozen_string_literal: true

require 'scopie'
require 'active_support/concern'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'

module ScopieRails

  SCOPIE_SUFFIX = '_scopie'

  require 'scopie_rails/engine' if defined?(Rails)
  require 'scopie_rails/base'
  require 'scopie_rails/controller'

end
