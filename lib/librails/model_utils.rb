module Librails
  # Model related utilities
  class SortItem
    attr_accessor :item
    attr_accessor :id, :array_index
  end

  class ModelUtils
    def self.set_array_index(item, attr_name, index)
      set_disp_order(item, attr_name, index + 1)
    end

    def self.get_array_index(item, attr_name)
      get_disp_order(item, attr_name) - 1
    end

    def self.set_disp_order(item, attr_name, value)
      item.send("#{attr_name}=", value)
    end

    def self.get_disp_order(item, attr_name)
      item.send(attr_name)
    end

    def self.reorder(items, hash, attr_name = 'disp_order', hash_key = 'disp_order')
      #items: ソート対象のオブジェクト(attr_nameで指定された属性で並び替えられている)
      #hash: idと順番のハッシュ(hash_keyで指定された属性に新しい順番が指定されている)
      # hash = {
      #    '10' => {'disp_order' => '1'},
      #    '20' => {'disp_order' => '2'},
      #    '30' => {'disp_order' => '2'},
      #    '40' => {'disp_order' => '1'},
      #}

      # 最初に1からインデックスを振り直す
      items.each_with_index do |item, index|
        set_array_index(item, attr_name, index)
      end

      # 前準備、ソート対象になるオブジェクトをまとめる
      sort_items = []
      hash.keys.each do |idstr|
        disp_order = hash[idstr][hash_key]
        next unless disp_order
        new_index = disp_order.to_i - 1

        # 範囲内に補正
        if new_index < 0
          new_index = 0
        end
        if new_index >= items.size - 1
          new_index = items.size - 1
        end

        # IDでオブジェクトを検索
        id = idstr.to_i
        item = items.find{|s| s.id == id}
        next if get_array_index(item, attr_name) == new_index #変化が無い場合は次へ

        # index=順番に変更があるものはsorted_itemsに記憶
        sort_item = SortItem.new
        sort_item.item = item
        sort_item.id = id
        sort_item.array_index = new_index
        sort_items << sort_item
      end

      # 入れ替える前にソートしておく。ただしい順で番号を入れ直すために必要。
      # 例えば以下のような指定を考える
      # 10
      # 20
      # 30
      # 40 - 2
      # 50 - 1
      # a)2,1の順で入れると以下のようになる
      # 50 - 1
      # 10
      # 40 - 2(3番目になってしまっている)
      # 20
      # 30
      # b)1,2の順で入れると正しい
      # 50 - 1
      # 40 - 2
      # 10
      # 20
      # 30

      sort_items.sort!{|a, b|
        r = a.array_index <=> b.array_index
        if r == 0
          r = a.id <=> b.id
        end
        r
      }
      # 新しい位置に挿入
      sort_items.each do |sort_item|
        item = sort_item.item
        items.delete_at(items.index(item)) #ソートの途中で順番が変わっている可能性があるのでその都度検索する必要あり。deleteはdbが削除されるので使えない
        items[sort_item.array_index, 0] = item
      end
      items.each_with_index do |item, index|
        set_array_index(item, attr_name, index)
#        item.child_index = index + 1
#        print "after #{index} title=#{item.title} #{item.child_index}\n"
      end
    end
  end
end