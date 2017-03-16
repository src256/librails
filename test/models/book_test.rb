require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def test_book
    book = books(:one)
    assert_equal('One', book.title)
  end
end