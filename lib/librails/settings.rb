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

    def self.normalize_value(value)
      value.sub(/^--- /, '')
    end

    def self.get_value(key)
      settings = Settings.find_by(var: key)
      value = nil
      if settings
        # Rails::Settings::Cachedが先頭に"-- "を付けているのでそれを除去する。互換性のための処理
        value = normalize_value(settings.value)
      end
      value
    end

    def self.set_value(key, value)
      settings = get(key)
      unless settings
        settings = Settings.new
        settings.key = key
      end
      settings.value = value.to_s
      settings.save!
    end

  end
end