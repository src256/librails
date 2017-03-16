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
    items.collect{|item| item.id.to_s + '-' + item.disp_order.to_s}.join(',')
  end

  def test_reorder_forward
    # 前方へ入れ替え
    hash = {
        '10' => {'disp_order' => '1'},
        '20' => {'disp_order' => '2'},
        '30' => {'disp_order' => '1'},
        '40' => {'disp_order' => '4'},
    }
    items = create_dummy_items
    Librails::ModelUtils.reorder(items, hash)
    assert_equal('30-1,10-2,20-3,40-4', dummy_items_to_s(items))
  end

  def test_reorder_backward
    # 後方へ入れ替え
    hash = {
        '10' => {'disp_order' => '2'},
        '20' => {'disp_order' => '2'},
        '30' => {'disp_order' => '3'},
        '40' => {'disp_order' => '4'},
    }
    items = create_dummy_items
    Librails::ModelUtils.reorder(items, hash)
    assert_equal('20-1,10-2,30-3,40-4', dummy_items_to_s(items))
  end

  def test_reorder_forward_two
    # 前方へ２つ入れ替え
    hash = {
        '10' => {'disp_order' => '1'},
        '20' => {'disp_order' => '2'},
        '30' => {'disp_order' => '2'},
        '40' => {'disp_order' => '1'},
    }
    items = create_dummy_items
    Librails::ModelUtils.reorder(items, hash)
    assert_equal('40-1,30-2,10-3,20-4', dummy_items_to_s(items))
  end
end
