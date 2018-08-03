librails
==============

- 個人用Railsプロジェクトで使用するためのRails用共通ライブラリ
- 作成方法に関しては [Wiki](https://srcw.net/wiki/?cmd=read&page=Rails%2F%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3)

## 実行環境

- Rails 5.1
- Ruby 2.5.1


## 

## インストール方法

- Gemfileに追加。
```rb
# 安定版を使用する
gem 'librails' 
# 開発版を使用する
gem 'librails', :git => 'https://github.com/src256/librails.git'
```

## 使用方法

- view_helperを使用する場合ApplicationControllerに以下を追加。
```rb
class ApplicationController < ActionController::Base
 helper Librails::ApplicationHelper
end 
```
- ユーティリティ系のメソッドは直接使用する
```rb
Librails::ModelUtils.order
...
```

## ライセンス

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)
