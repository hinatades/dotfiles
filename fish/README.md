# Fish Shell Configuration

zshからfishへの移行用設定

## セットアップ手順

### 1. fishのインストール

```bash
brew install fish
```

### 2. 設定ファイルのシンボリックリンク作成

```bash
# このリポジトリのルートで実行
ln -sf $(pwd)/fish ~/.config/fish

# Starship設定（oh-my-zsh simple theme replica）
# 緑色のディレクトリパス + 青色のブランチ名 + git状態(✔/✗)
ln -sf $(pwd)/starship.toml ~/.config/starship.toml
```

**注意**:
- WezTermの設定で自動的にfishが起動します（`chsh`不要）
- Starshipのテーマを反映させるには、WezTermを再起動してください

### 3. Fisherとプラグインのインストール

```bash
# Fisherをインストール
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# fish_pluginsから自動インストール
fisher update
```

これで以下のプラグインが自動的にインストールされます：
- `PatrickF1/fzf.fish`: fzf統合（履歴検索など）

## 主な機能

### キーバインド（zshと同じ）

- `Ctrl+@` (Ctrl+Space): 履歴検索（fzf.fish）
- `Ctrl+[` (Esc): ghqリポジトリへcd
- `Ctrl+]`: ghqリポジトリをブラウザで開く

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
