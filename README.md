# Rails 新手上路 - 以 Blog 為例
這是自己練習 rails 的作業
1. 寫一個簡單的 Blog，有標題，文章內容，時間
2. 為這個 Blog 系統加上分類與留言功能
3. 為這個 Blog 系統加上使用者登入功能 (用 Devise 實作）

## 何謂 MVC ？
## 建立放文章的 model
我們需要 title 和 conent 兩個欄位, 因此我們透下面指令建立 model 為 post, 欄位有 title 和 content

```
rails generate model post title:string content:text
```

> 講個小秘訣：</br>
> 想偷懶一點也可以打 `rails g model post title:string content:text` 唷!</br>
> rails g 就是 rails generate 的縮寫啦!

為什麼一個是 string 另外一個要用 text 呢？ 因為 String 這個屬性預設只有 255 個字, 而 text 長度可以是 65536 個, 如想知道更詳細的可以看下表(一).


表(一) - Migration 轉 MySQL 的轉換表及長度說明

| Migration 屬性 | 會轉成的 MySQL 指令                      | 長度                                                                  |
|----------------|------------------------------------------|-----------------------------------------------------------------------|
| :binary        | TINYBLOB, BLOB, MEDIUMBLOB, or LONGBLOB2 | :limit => 1 to 4294967296 (default = 65536)2                          |
| :boolean       | TINYINT(1)                               | -                                                                     |
| :date          | DATE                                     | -                                                                     |
| :datetime      | DATETIME                                 | -                                                                     |
| :decimal       | DECIMAL                                  | :precision => 1 to 63 (default = 10) :scale => 0 to 30 (default = 0)3 |
| :float         | FLOAT                                    | -                                                                     |
| :integer       | INT                                      | :limit => 1 to 11 (default = 11)                                      |
| :primary_key   | INT(11) AUTO_INCREMENT PRIMARY KEY       |                                                                       |
| :string        | VARCHAR                                  | :limit => 1 to 255 (default = 255)                                    |
| :text          | TINYTEXT, TEXT, MEDIUMTEXT, or LONGTEXT2 | :limit => 1 to 4294967296 (default = 65536)2                          |
| :time          | TIME                                     | -                                                                     |
| :timestamp     | DATETIME                                 | -                                                                     |

接著我們就可以透過 `rake db:migrate` 來建立 table 了, Rails 預設是使用 SQLite3, 因此我們可以在 `db/` 下面看到 `development.sqlite3` 這個檔案囉.

> 小叮嚀:</br>
> 作者第一次建立 model 很天真的打了以下的指令：
> ```
> rails g model post id:primary_key title:string content:text
> ```
> 結果在 rake db:migrate 的時候炸掉了!!錯誤訊息如下:</br>
> ```
> StandardError: An error has occurred, this and all later migrations canceled:
> you can't redefine the primary key column 'id'. To define a custom primary key, pass { id: false } to create_table
> ```
> 原來是 rails 的 model 預設就有 id 這個 primary_key 囉!! 如果想知道修改這樣預設的 id 可以參考這篇[如何修改 model 預設的 id]()



## 參考資料
* [表(一) - Migration 轉 MySQL 的轉換表及長度說明](https://www.packtpub.com/books/content/working-rails-%E2%80%93-activerecord-migrations-models-scaffolding-and-database-completion)
