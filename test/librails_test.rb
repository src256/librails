require 'test_helper'

class LibrailsTest < ActiveSupport::TestCase
  include Librails::ViewHelpers::ActionView
  
  test "truth" do
    assert_kind_of Module, Librails
  end

  def test_hello
    assert_equal('Hello World!', hello_method)
  end
end

