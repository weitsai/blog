# Rails 新手上路 - 以 Blog 為例
這是自己練習 rails 的作業
1. 寫一個簡單的 Blog，有標題，文章內容，時間
2. 為這個 Blog 系統加上分類與留言功能
3. 為這個 Blog 系統加上使用者登入功能 (用 Devise 實作）

## 何謂 MVC ？

## 建立一個 Rilas Project
```
rails new blog
```

```
rails server
```

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
> 原來是 rails 的 model 預設就有 id 這個 primary_key 囉!! 如果想知道修改這樣預設的 id 可以參考這篇([如何修改 model 預設的 id](notes/change_model_deafault_id.md)).

## rails console 介紹
如果你有學過 Ruby 應該會知道有 `irb` 這樣的指令, 他提供互動模式讓我們可以在裡面寫 Ruby, 雖然作者都拿他來當計算機而已, 不過 Rails 也提供他專屬的 `irb`, 使用  `rails console` 這個指令就可以進入囉!!

* 一般模式 - 他可以將使用 model 來建立資料, 並且真的存到資料庫之中.
```
rails console
```

* 沙箱模式 - 如果你希望接下來做的測試都不要被存起來那就得用下面這個指令.
```
rails console --sandbox
```

> 講個小秘訣：</br>
> 想偷懶一點也可以打 `rails c` 唷!</br>
> rails t 就是 rails console 的縮寫啦!


## CRUD
CRUD 是 Create, Read, Update and Delete 的縮寫, 絕大多數軟體只要有用到資料庫, 基本上就一定會用到這四大基本操作, 因此接下來我們透過剛剛學到的 rails console 來學習 CRUD 吧~

* Create
  * 第一種方式
  ```ruby
  rails c

  2.1.5 :001 > post = Post.new
   => #<Post id: nil, title: nil, content: nil, created_at: nil, updated_at: nil>
  2.1.5 :002 > post.title = '測試文章標題'
   => "測試文章標題"
  2.1.5 :003 > post.content = '測試文章內容'
   => "測試文章內容"
  2.1.5 :004 > post.save
     (0.1ms)  SAVEPOINT active_record_1
    SQL (1.8ms)  INSERT INTO "posts" ("title", "content", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "測試文章標題"], ["content", "測試文章內容"], ["created_at", "2015-01-06 02:51:10.331218"], ["updated_at", "2015-01-06 02:51:10.331218"]]
     (0.1ms)  RELEASE SAVEPOINT active_record_1
   => true
  2.1.5 :005 > post.title # 取出 post 的 title
   => "測試文章標題"
  ```

  * 第二種方式
  ```ruby
  rails c

  2.1.5 :001 > post2 = Post.new( :title => "測試文章標題", :content => "測試文章內容").save
   => #<Post id: nil, title: "測試文章標題", content: "測試文章標題", created_at: nil, updated_at: nil>
  ```

* Rrad
  * 尋找標題是 "測試文章標題" 的文章
    * 第一種方式
    ```ruby
    rails c

    2.1.5 :001 > Post.where( :title == "測試文章標題" ) # 找出標題是「測試文章標題」的
      Post Load (3.2ms)  SELECT "posts".* FROM "posts"
     => #<ActiveRecord::Relation [#<Post id: 1, title: "測試文章標題", content: "測試文章內容, created_at: "2015-01-06 02:59:36", updated_at: "2015-01-06 02:59:36">]>
    ```

    * 第二種方式
    ```ruby
    rails c

    Post.where( title:"測試文章標題")
    ```

  * 尋找日期大於等於 2014 的文章
  ```ruby
  rails c

  2.1.5 :001 >   Post.where("created_at >= ?", Time.mktime(2014)) # 這樣的方式會把 Time.mktime 帶入 ? 之中
  Post Load (0.2ms)  SELECT "posts".* FROM "posts" WHERE (created_at >= '2013-12-31 16:00:00.000000')
 => #<ActiveRecord::Relation [#<Post id: 1, title: "123", content: "456", created_at: "2015-01-06 02:59:36", updated_at: "2015-01-06 02:59:36">]>
  ```

* Update
  * 找出 id = 2 的資料並且更改他的標題
  ```ruby
  rails c

  2.1.5 :001 > p = Post.find(2) # 找出 id = 2 的資料
  Post Load (0.2ms)  SELECT  "posts".* FROM "posts" WHERE "posts"."id" = ? LIMIT 1  [["id", 2]]
 => #<Post id: 2, title: "測試文章標題", content: "測試文章內容", created_at: "2015-01-07 11:20:54", updated_at: "2015-01-07 11:20:54">
  2.1.5 :002 > p.title
   => "測試文章標題"
  2.1.5 :003 > p.update(:title => 'update title test') # 更改 title 為 update title test
     (0.2ms)  begin transaction
    SQL (0.4ms)  UPDATE "posts" SET "title" = ?, "updated_at" = ? WHERE "posts"."id" = ?  [["title", "update title test"], ["updated_at", "2015-01-07 11:35:36.475763"], ["id", 2]]
     (0.8ms)  commit transaction
   => true
  2.1.5 :004 > p.title
   => "update title test"
  ```

* Delete
  * 刪除第一筆資料

  ```ruby
  rails c

  post = Post.find(1)
  post.destroy
  ```



## 參考資料
* [表(一) - Migration 轉 MySQL 的轉換表及長度說明](https://www.packtpub.com/books/content/working-rails-%E2%80%93-activerecord-migrations-models-scaffolding-and-database-completion)
* [CRUD](https://ihower.tw/rails4/basic.html)
