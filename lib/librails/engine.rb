module Librails
  class Engine < ::Rails::Engine
    isolate_namespace Librails
    initializer "librails.view_helper" do |app|
      ActiveSupport.on_load :action_view do
        require 'librails/view_helper'
        include Librails::ViewHelper
      end
    end
  end
end
