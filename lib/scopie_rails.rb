# frozen_string_literal: true

require 'scopie'
require 'active_support/concern'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string/inflections'

module ScopieRails

  SCOPIE_PREFIX = 'Scopies'
  SCOPIE_SUFFIX = 'Scopie'
  CLASS_NAME_DELIMETER = '::'
  CONTROLLER_DELIMETER = 'Controller'

  require 'scopie_rails/base'
  require 'scopie_rails/controller'

end
