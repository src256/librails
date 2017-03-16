require 'test_helper'

class MiscUtilsTest < ActiveSupport::TestCase
  def test_rescue_mysql2_error
    e = RuntimeError.new("Incorrect string value:")
    Librails::MiscUtils.rescue_mysql2_error(e)
  end
end
