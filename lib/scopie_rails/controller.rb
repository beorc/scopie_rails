# frozen_string_literal: true
module ScopieRails::Controller
  extend ActiveSupport::Concern

  included do
    class_attribute :scopie_class
  end

  def default_scopie
    @default_scopie ||= find_scopie_class.new(self)
  end

  # Receives an object where scopes will be applied to.
  #
  #   class GraduationsScopie < Scopie::Base
  #     has_scope :featured, type: :boolean
  #     has_scope :by_degree, :by_period
  #   end
  #
  #   class GraduationsController < ApplicationController
  #     include ScopieRails::Controller
  #
  #     def index
  #       @graduations = apply_scopes(Graduation).all
  #     end
  #   end
  #
  def apply_scopes(target, scopie: default_scopie, hash: params)
    Scopie.apply_scopes(target, hash, method: hash[:action], scopie: scopie)
  end

  # Returns the scopes used in this action.
  def current_scopes(scopie: default_scopie, hash: params)
    Scopie.current_scopes(hash, method: hash[:action], scopie: scopie)
  end

  def find_scopie_class
    return scopie_class if scopie_class

    scopie_name = params[:controller] + ScopieRails::SCOPIE_SUFFIX

    self.scopie_class = scopie_name.camelize.constantize
  end
end
