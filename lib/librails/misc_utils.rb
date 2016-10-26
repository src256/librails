module Librails
  class MiscUtils
    def self.rescue_mysql2_error(e)
      if e.message =~ /Incorrect string value:/
        # utf8mb4にすればいいのだ…。とりあえずそのばしのぎ。
        puts e.message
      else
        puts e.message
        puts e.backtrace
      end
    end
  end
end