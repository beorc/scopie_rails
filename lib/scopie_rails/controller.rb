# frozen_string_literal: true
module ScopieRails::Controller
  extend ActiveSupport::Concern

  def default_scopie
    @default_scopie ||= find_scopie_class.new(self)
  end

  def apply_scopes(target, scopie: default_scopie, hash: params)
    Scopie.apply_scopes(target, hash, method: hash[:action], scopie: scopie)
  end

  def current_scopes(scopie: default_scopie, hash: params)
    Scopie.current_scopes(hash, method: hash[:action], scopie: scopie)
  end

  included do
    class_attribute :scopie_class

    def self.find_scopie_class(class_name = nil)
      return scopie_class if scopie_class

      class_name ||= name

      ary = class_name.split(ScopieRails::CLASS_NAME_DELIMETER)
      controller_class_name = ary.pop
      base_class_name = controller_class_name.split(ScopieRails::CONTROLLER_DELIMETER).first
      ary << ScopieRails::SCOPIE_PREFIX
      ary << base_class_name + ScopieRails::SCOPIE_SUFFIX
      scopie_class = ary.join(ScopieRails::CLASS_NAME_DELIMETER).constantize

      scopie_class
    end

    delegate :find_scopie_class, to: :class
  end
end
