# frozen_string_literal: true

class ScopieRails::Base < Scopie::Base

  attr_reader :controller

  def initialize(controller)
    super()
    @controller = controller
  end

end
