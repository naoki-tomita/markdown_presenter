# 12/04
## 1
まずはチュートリアルを見ながらhello worldで試してみる。
hello worldは余裕だった。
* config/route.rbでrailsアプリのURL設定をしている。
  * たとえば、下記のようなコードでルートURLを設定可能
``` ruby
root 'application#hello'
```
ルートURLにアクセスすると`app/cpmtroller/application_controller.rb`のhelloメソッドを実行するという意味になる(っぽい)。<br>
_controllerの部分は勝手に無視してくれるのかな。よく知らんけど。

## 2
次に、ツイッターみたいなのを作る。

# 12/06
## 1
ツイッターのデータモデル
* ユーザー情報

| id | integer |
| name | string |
| mail_address | string |

* ツイート情報

| id | integer |
| tweet | string |
| user_id | integer |

railsではデータモデルはコマンドで作るらしい。
また、ここでIDは指定してないけど、railsはかってにやってくれるっぽい。

``` shell
rails generate scaffold User name:string mail_address:string
```

そしたら、`bundle exec rake db:migrate`でデータベース生成

これで動くようになる
```
rails server -b $IP -p $PORT
```

## 2
では、ファイルを管理できるようなデータベースを作ろう
作ったやつは削除

```
rails destroy model User
```

## 3
filesというフォルダにファイルをおくことにする
ファイルアップロードする機能を作ろう

ファイルアップロード機能の実現方法はいろいろあるっぽい。

* データベースで実現する方法
  * データベースにファイル名とファイルのバイナリを登録する方法
* ファイルをフォルダに保存しておいて、表示の時にアップロード済みのファイルを表示する方法

データベースを使うのはめんどくさそうなので、現物のファイルを使う。
、と思ったのだけど、やり方がのってないので、諦めた。

なので、まずはファイルを管理するやつ
|id|integer|
|filename|string|
|file|binary|

```
rails generate scaffold File filename:string file:binary
```

viewsのindex.htmlは/upload_filesにアクセスした時に表示されるやつ。
他にも、new.htmlとか、show、editなどあるが、それらはデータをいじる時に使用されるページを定義している。
アップロードするんなら、editとか、newのところでファイルアップロードできるようにすると良さそうである。

### アップロードできるようにする
した。これについては後でまとめよう。

### markdownを変換できるようにする
redcarpetというgemを使うことで変換できるようになる。
こいつでhtmlに変換したものをほいっと変換して表示すればいい。
注意点がひとつ。
erbファイルは下記のような記法で出力できる。

``` erb
<%= markdown2html(md_file)%>
```

これをこのまま出力すると、rubyが気を利かせてくれてhtmlタグをエスケープしてくれるため、
そのまま`<h1> hoge </h1>`みたいなのが表示されてしまう。
これを避けるために、
``` erb
markdown2html(md_file).html_safe
```
とする。