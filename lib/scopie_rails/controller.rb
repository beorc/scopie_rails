# frozen_string_literal: true
module ScopieRails::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :scopie_class
  end

  def default_scopie
    @default_scopie ||= find_scopie_class.new(self)
  end

  def apply_scopes(target, scopie: default_scopie, hash: params)
    Scopie.apply_scopes(target, hash, method: hash[:action], scopie: scopie)
  end

  def current_scopes(scopie: default_scopie, hash: params)
    Scopie.current_scopes(hash, method: hash[:action], scopie: scopie)
  end

  def find_scopie_class
    return self.class.scopie_class if self.class.scopie_class

    scopie_name = params[:controller] + ScopieRails::SCOPIE_SUFFIX

    self.class.scopie_class = scopie_name.camelize.constantize

    self.class.scopie_class
  end
end
