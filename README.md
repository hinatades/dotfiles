# .emacs.d

僕のemacsの設定です。基本的な設定はで[こちら](http://qiita.com/bussorenre/items/bbe757ef87e16c3d31ff)を参考にさせていただきました。

### macにemacsをインストール

Homebrewを使ってインストールします。
```
$ brew install emacs
```
公式ページ等からダウンロードせずにこの一行だけに留めると、CUIでのみemacsが使えます。

インストール後、ターミナルを再起動し
```
$ emacs --version
GNU Emacs 25.2.1
Copyright (C) 2017 Free Software Foundation, Inc.
GNU Emacs comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of GNU Emacs
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING.
```

と出たら完了です。インストール先は
```
/usr/local/Cellar/emacs/25.3/share/emacs/
```
になります。

次にemacsのパッケージをインストールします。パッケージ管理にはcaskを使います。
以下でパッケージをリフレッシュした後、

```
M-x package-refresh-contents
```

```
$ brew install cask
$ cd ~/.emacs.d
$ cask
```
で完了です。caskコマンドでCaskに書かれたパッケージがインストールされます。

mac以外は

```
$  curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
```
でcaskコマンドをインストールし

```.bashrc

PATH="$HOME/.cask/bin:$PATH"

```

でパスを通します。その後

```
$ source ~/.bashrc
```

でシェルの設定を更新することでcaskコマンドが使えます。


### カラーテーマ

- https://github.com/emacs-jp/replace-colorthemes


### 参考資料

- [突然だがEmacs を始めよう](https://qiita.com/bussorenre/items/bbe757ef87e16c3d31ff)
- [Emacsでもしゃれた画面でプログラミングがしたい！！](https://qiita.com/itome0403/items/05dc50f6bfbdfb04c0cf)
- [Mac 標準terminal、iterm2のEmacsでpowerlineが文字化けするのを修正する](https://joppot.info/2017/04/17/3824)
- [EmacsでTwitter: twittering-modeの設定メモった。](http://fukuyama.co/twittering-mode)
- [Emacs で Rails の開発効率を上げる Projectile Rails まとめ](https://qiita.com/elbowroomer/items/8e3c4b075a181f224591)
- [Emacsでmarkdown-modeを使用する](http://moonstruckdrops.github.io/blog/2013/03/24/markdown-mode/)
- [Macでプログラミング用のフォントRictyを設置した話](https://qiita.com/park-jh/items/3c5b9b4aa5619a3631b3)
