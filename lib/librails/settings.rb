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
      settings = get(key)
      return nil unless settings
      value = normalize_value(settings.value)
      value
    end

    def self.get_int(key)
      settings = get(key)
      return nil unless settings
      # Rails::Settings::Cachedが先頭に"-- "を付けているのでそれを除去する。互換性のための処理
      value = normalize_value(settings.value)
      value.to_i
    end

    def self.get_time(key)
      settings = get(key)
      return nil unless settings
      value = normalize_value(settings.value)
      Time.zone.parse(value)
    end

    def self.normalize_value(value)
      value.sub(/^--- /, '')
    end

    def self.get(key)
      Settings.find_by(var: key)
    end

    def self.set(key, value)
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