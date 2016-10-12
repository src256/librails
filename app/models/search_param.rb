# coding: utf-8
class SearchParam
  def initialize(id, label = nil, value = nil)
    # 基本はIDとlabel。valueは特別な値を紐付けたい場合にのみ使用する。
    @id = id
    @label = label
    if @label.nil?
      @label = @id
    end
    @value = value
  end
  attr_accessor :id, :label, :value
end
