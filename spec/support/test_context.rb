# frozen_string_literal: true
module Admin
  class HomeController

    include ScopieRails::Controller

    def params
      { controller: 'admin/home' }
    end

  end

  class HomeScopie < ScopieRails::Base
  end
end
