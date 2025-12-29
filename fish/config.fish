# PATH設定
fish_add_path /usr/local/bin
fish_add_path /usr/local/opt/llvm/bin
fish_add_path $HOME/.nodebrew/current/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/mysql-client/bin
fish_add_path /usr/local/opt/libpq/bin
fish_add_path $HOME/.lmstudio/bin

# Golang
set -x GOENV_ROOT $HOME/.goenv
fish_add_path $GOENV_ROOT/bin
set -x GOENV_DISABLE_GOPATH 1
status --is-interactive; and goenv init - | source
set -x GOPATH $HOME/.go
fish_add_path $GOPATH/bin

# Python
set -x PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/shims
status --is-interactive; and pyenv init - | source

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

# Starship prompt
starship init fish | source

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
if type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\e\[
    fzf_configure_bindings --git_status=\e]
    fzf_configure_bindings --history=\cT
end
