# PATH設定（Homebrewを最優先）
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path $HOME/.nodebrew/current/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/mysql-client/bin
fish_add_path /usr/local/opt/libpq/bin
fish_add_path $HOME/.lmstudio/bin

# Golang（goenvがインストールされている場合のみ）
set -x GOENV_ROOT $HOME/.goenv
if test -d $GOENV_ROOT/bin
    fish_add_path $GOENV_ROOT/bin
    set -x GOENV_DISABLE_GOPATH 1
    if status --is-interactive; and command -v goenv > /dev/null
        goenv init - | source
    end
end
set -x GOPATH $HOME/.go
fish_add_path $GOPATH/bin

# Python（pyenvがインストールされている場合のみ）
set -x PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT/shims
    fish_add_path $PYENV_ROOT/shims
    if status --is-interactive; and command -v pyenv > /dev/null
        pyenv init - | source
    end
end

# Claude
set -x AWS_REGION ap-northeast-1
set -x CLAUDE_CODE_USE_BEDROCK 1
set -x ANTHROPIC_MODEL 'global.anthropic.claude-sonnet-4-5-20250929-v1:0'

# Editor
set -x EDITOR nvim
set -x VISUAL nvim
set -x GITHUB_EDITOR nvim

# XDG
set -x XDG_CONFIG_HOME $HOME/.config

# fzf設定
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--height 40% --reverse --border'

# Starship prompt（starshipがインストールされている場合のみ）
if command -v starship > /dev/null
    starship init fish | source
end

# kubectl補完
if command -v kubectl > /dev/null
    kubectl completion fish | source
end

# Google Cloud SDK
if test -f $HOME/google-cloud-sdk/path.fish.inc
    source $HOME/google-cloud-sdk/path.fish.inc
end

# Aliases
alias vim=nvim
alias a="./a.out"
alias A="c++ A.cpp -std=c++17"
alias B="c++ B.cpp -std=c++17"
alias C="c++ C.cpp -std=c++17"
alias D="c++ D.cpp -std=c++17"
alias E="c++ E.cpp -std=c++17"
alias F="c++ F.cpp -std=c++17"
alias k=kubectl
alias e=exit

# fzf.fish設定 (プラグインがインストールされている場合)
# zshと同じキーバインドに設定
if type -q fzf_configure_bindings
    # Ctrl+@（Ctrl+Space）: 履歴検索（zshと同じ）
    fzf_configure_bindings --history=\c@
    # その他の機能は無効化（カスタム関数を使用）
    fzf_configure_bindings --directory=
    fzf_configure_bindings --git_log=
    fzf_configure_bindings --git_status=
    fzf_configure_bindings --processes=
    fzf_configure_bindings --variables=
end
