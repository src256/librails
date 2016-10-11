module Librails
  class Railtie < ::Rails::Railtie
    initializer "librails.configure_view_controller" do |app|
      ActiveSupport.on_load :action_view do
        require 'librails/view_helpers/action_view'
        include Librails::ViewHelpers::ActionView
      end
    end
  end
end
