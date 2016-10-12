require 'test_helper'

class LibrailsTest < ActiveSupport::TestCase
#  test "truth" do
#    assert_kind_of Module, Librails
  #  end
  include Librails::ViewHelper

  def test_hello
    assert_equal('Hello World!2', hello_method2)
  end  
end
