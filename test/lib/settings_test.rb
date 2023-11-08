require 'test_helper'

class SettingsTest < ActiveSupport::TestCase
  def setup
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => ENV['RAILS_DATABASE_USERNAME'],
      :password => ENV['RAILS_DATABASE_PASSWORD'],
      :database => "haro_development"
    )
  end

  def test_keywords
    #keywords = Librails::Settings.get_value('keywords')
    #    puts keywords
    #    p keywords
    #values = Librails::Settings.get_array('keywords')
    #p values
    #
    # Librails::Settings.set_value('keywords', ['a', 'b', 'c'])
    # values = Librails::Settings.get_array('keywords')
    # p values
  end
end