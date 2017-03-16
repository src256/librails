require 'test_helper'

class ModelUtilsTest < ActiveSupport::TestCase
  class DummyItem
    attr_accessor :id, :disp_order
  end

  def create_dummy_items
    i1 = DummyItem.new
    i1.id = 10
    i2 = DummyItem.new
    i2.id = 20
    i3 = DummyItem.new
    i3.id = 30
    i4 = DummyItem.new
    i4.id = 40
    [i1, i2, i3, i4]
  end

  def dummy_items_to_s(items)
    items.collect{|item| item.id.to_s + '-' + item.child_index.to_s}.join(',')
  end

  def test_reorder_forward
    Librails::Test.hello()
    # 前方へ入れ替え
    hash = {
        '10' => {'disp_order' => '1'},
        '20' => {'disp_order' => '2'},
        '30' => {'disp_order' => '1'},
        '40' => {'disp_order' => '4'},
    }
    items = create_dummy_items

#    Librails::MiscUtils.rescue_mysql2_error(nil)
#    Librails::ModelUtils.reorder(items, hash)
    assert_equal('30-1,10-2,20-3,40-4', dummy_items_to_s(items))
  end
end
