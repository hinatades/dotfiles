# Fish Shell Configuration

zshからfishへの移行用設定

## セットアップ手順

### 1. fishのインストール

```bash
brew install fish
```

### 2. fishをデフォルトシェルに設定

```bash
# fishのパスを確認
which fish

# /etc/shellsに追加（まだ登録されていない場合）
echo $(which fish) | sudo tee -a /etc/shells

# デフォルトシェルを変更
chsh -s $(which fish)
```

### 3. 設定ファイルのシンボリックリンク作成

```bash
# このリポジトリのルートで実行
ln -sf $(pwd)/fish ~/.config/fish

# Starship設定（シンプルなプロンプトスタイル）
ln -sf $(pwd)/starship.toml ~/.config/starship.toml
```

### 4. Fisher（プラグインマネージャー）のインストール

```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

### 5. 推奨プラグインのインストール

```bash
# fzf統合（最重要）
fisher install PatrickF1/fzf.fish

# z（ディレクトリジャンプ）
fisher install jethrokuan/z

# ghq統合
fisher install decors/fish-ghq
```

## 主な機能

### キーバインド

- `Ctrl+R`: 履歴検索（fzf.fish）
- `Ctrl+[`: ghqリポジトリへcd
- `Ctrl+]`: ghqリポジトリをブラウザで開く
- `Ctrl+Alt+F`: ファイル検索（fzf.fish）

### カスタム関数

- `fvim`: gitファイルをfzfで選択してvim
- `ide`: tmux 3ペイン分割レイアウト

### エイリアス

- `vim` → `nvim`
- `k` → `kubectl`
- `e` → `exit`
- その他競プロ用エイリアス（A, B, C, D, E, F）

## zshとの違い

### 改善点

- **autosuggestions標準搭載**: プラグイン不要
- **強力な補完**: コマンドオプションを自動認識
- **シンプルな文法**: if文、変数展開が直感的
- **起動が高速**: zshより体感で速い

### 注意点

- シェルスクリプトはPOSIX非互換（スクリプトはbash/zshで実行）
- 一部の設定ファイルが`.zshrc`を前提としている可能性あり

## ロールバック方法

```bash
# zshに戻す
chsh -s /bin/zsh

# またはbashに戻す
chsh -s /bin/bash
```
