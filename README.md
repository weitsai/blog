# Blog 學習筆記

## 何謂 MVC ？
## 建立放文章的 model
我們需要 title 和 conent 兩個欄位, 因此我們透下面指令建立 model 為 post, 欄位有 title 和 content

```
rails generate model post title:string content:text
```

> 講個小秘訣：
> 也可以打 rails g model post title:string content:text 唷！
> rails g 就是 rails generate 的縮寫

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





## 參考資料
* [表(一) - Migration 轉 MySQL 的轉換表及長度說明](https://www.packtpub.com/books/content/working-rails-%E2%80%93-activerecord-migrations-models-scaffolding-and-database-completion)
