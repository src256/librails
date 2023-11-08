module Librails

  ## Settingテーブルを読み書きするクラス
  #
  # rails-settings-cachedとの互換性のため値を正規化するメソッドを用意している
  #
  # 以下のテーブルを想定
  #
  # テーブル名: settings
  # id(int): 主キー
  # var(varchar(255)): 値のキー
  # value(text): 値


  class Settings < ActiveRecord::Base
    self.table_name = "settings"

    def self.get_str(key)
      get_value(key)
    end

    def self.get_int(key)
      value = get_value(key)
      return nil unless value
      value.to_i
    end

    def self.get_time(key)
      value = get_value(key)
      return nil unless value
      result = nil
      begin
        result = Time.zone.parse(value)
      rescue => e
        puts e.message
      end
      result
    end

    def self.get_array(key)
      value = get_value(key)
      return nil unless value
      values = nil
      if value =~ /^---/
        # Rails Settings Cachedは配列をYAML形式で保存している
        # "---\n- bootstrap\n- chatgpt\n- git\n- github\n- javascript\n
        value = value.sub(/^---\n/, '')
        values = value.split(/\n/).collect {|v| v.sub(/^- /, '').strip}
      else
        # 新方式は単なるtsvとする
        values = value.split(/\t/)
      end
      values
    end

    def self.normalize_value(value)
      value.sub(/^--- /, '').strip
    end

    def self.get_value(key)
      settings = get_record(key)
      value = nil
      if settings
        # Rails::Settings::Cachedが先頭に"-- "を付けているのでそれを除去する。互換性のための処理
        value = normalize_value(settings.value)
      end
      value
    end

    def self.get_record(key)
      Settings.find_by(var: key)
    end

    def self.set_value(key, value)
      settings = get_record(key)
      unless settings
        settings = Settings.new
        settings.key = key
      end
      str = nil
      if value.kind_of?(Array)
        str = value.join("\t") # タブ区切りで保存
      else
        str = value.to_s
      end
      settings.value = str
      settings.save!
    end

  end
end