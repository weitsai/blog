# 如何修改/使用 model 預設的 id
先前使用 `rails g model post id:primary_key title:string content:text` 這個指令的時候發生了錯誤, 因而找到了幾個下面的解法來跟大家分享, 這篇純屬研究性質, 如果再真的開發 Rails 專案的時候不要這樣搞喔!! 不然被掛在天花板上不要來找作者!!

## 如何指定 primary_key 的名稱而不要用預設的 id 呢？
我們在 `db/migrate` 中找到 `[create time]_create_[Model Name].rb`, 接著讓我們來把預設的 id 改成 `urKeyId` 吧：

```ruby
create_table( :posts, :primary_key => 'urKeyID') do |t|
  t.integer :urKeyID, :null => false
  t.string :title
  t.text :content

  t.timestamps
end
```

這樣一來我們的 primary_key 就變 urKeyID 囉!!

## 改了預設的 id 我就被前罵了, 有沒有辦法不改 id 名稱, 但我卻能用別名來使用？
首先我們到 `app/model/[Model Name].rb`, 接著我們來設定別名吧！

```ruby
class SomeModel < ActiveRecord::Base
  alias_method :id, :uuid
end
```

這樣我們就可以使用 uuid 來操作 id 這個欄位了！！

## 那..我很白木就是不想要有 primary_key 怎麼辦呢？
那你就得打開 `[create time]_create_[Model Name].rb`, 把 id 設定為 false 囉!

```ruby
create_table :global_feeds, :id => false do |t|
  t.string :guid
  t.text :title
  t.text :subtitle
  t.timestamps
end
```

## 參考資料
* [設定 model primary key 預設名稱](http://stackoverflow.com/questions/6402189/specify-custom-primary-key-in-migration)

## 感謝指導
* [raphahsu](https://www.facebook.com/rapha.hsu?fref=ts)
* [eddie](https://www.facebook.com/adz.624?fref=ts)
* [eddiekao](https://www.facebook.com/eddiekao?fref=ufi)
