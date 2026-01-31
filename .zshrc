export PATH=/usr/local/bin:$PATH

# Zsh History Configuration
# History file location (synced via Dropbox)
HISTFILE=$HOME/.zsh_history
# Number of commands to keep in memory
HISTSIZE=10000
# Number of commands to save to file
SAVEHIST=10000
# Share history across all sessions
setopt share_history
# Append to history file incrementally
setopt inc_append_history
# Remove older duplicates first when trimming history
setopt hist_expire_dups_first
# Don't save duplicate commands
setopt hist_ignore_dups
# Don't save commands that start with a space
setopt hist_ignore_space
# Remove extra whitespace from commands before saving
setopt hist_reduce_blanks

# Starship prompt (oh-my-zsh simple theme replica)
eval "$(starship init zsh)"

# Clangd
export PATH="/usr/local/opt/llvm/bin:$PATH"
# Node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH
# Golang
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
GOENV_DISABLE_GOPATH=1
eval "$(goenv init -)"
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init -)"
# Poetry
export PATH="$HOME/.local/bin:$PATH"

# mysql
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Claude
# export AWS_REGION=ap-northeast-1
# export CLAUDE_CODE_USE_BEDROCK=1
# export ANTHROPIC_MODEL='global.anthropic.claude-sonnet-4-5-20250929-v1:0'

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Github CLI
export GITHUB_EDITOR="nvim"

# Kubenetes
autoload -Uz compinit
compinit
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell

# gwq (Git Worktree Manager)
if command -v gwq &> /dev/null; then
    source <(gwq completion zsh)
fi

# zsh-autosuggestions (Homebrew version)
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
fi

alias vim=nvim
alias ls='ls -G'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias tree='tree -C'
alias a="./a.out"
alias A="c++ A.cpp -std=c++17"
alias B="c++ B.cpp -std=c++17"
alias C="c++ C.cpp -std=c++17"
alias D="c++ D.cpp -std=c++17"
alias E="c++ E.cpp -std=c++17"
alias F="c++ F.cpp -std=c++17"
alias k=kubectl
compdef k=kubectl

# fzf history
function fzf-select-history() {
  local history selected

  history=$(history -nr 1 | awk '!a[$0]++')
  [[ -z "$history" ]] && return 0

  selected=$(print -r -- "$history" | fzf --query "$LBUFFER") || return 0
  BUFFER="${selected//\\n/$'\n'}"
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history
bindkey '^@' fzf-select-history


# fzf + ghq
function fzf-src() {
  local list selected_dir

  list=$(ghq list -p)
  [[ -z "$list" ]] && return 0

  selected_dir=$(print -r -- "$list" | fzf --query "$LBUFFER") || return 0
  [[ -n "$selected_dir" ]] && {
    BUFFER="cd ${selected_dir}"
    zle accept-line
  }
  zle clear-screen
}
zle -N fzf-src
bindkey '^[' fzf-src


# fzf + ghq + hub
function fzf-src-hub() {
  local list selected_dir

  list=$(ghq list)
  [[ -z "$list" ]] && return 0

  selected_dir=$(print -r -- "$list" | fzf --query "$LBUFFER" | cut -d "/" -f 2,3) || return 0
  [[ -n "$selected_dir" ]] && {
    BUFFER="gh repo view --web ${selected_dir}"
    zle accept-line
  }
  zle clear-screen
}
zle -N fzf-src-hub
bindkey '^]' fzf-src-hub


# fzf + git branch (ブランチ選択してcheckout)
function fzf-git-branch() {
  local branches selected

  branches=$(git branch --format='%(refname:short)' 2>/dev/null)
  [[ -z "$branches" ]] && return 0

  selected=$(print -r -- "$branches" | fzf --query "$LBUFFER") || return 0
  [[ -n "$selected" ]] && {
    BUFFER="git checkout ${selected}"
    zle accept-line
  }
  zle clear-screen
}
zle -N fzf-git-branch
bindkey '^g' fzf-git-branch


# fzf + git branch delete (ブランチ選択して削除、Tab複数選択可)
function fzf-git-branch-delete() {
  local branches selected

  branches=$(git branch --format='%(refname:short)' 2>/dev/null)
  [[ -z "$branches" ]] && return 0

  selected=$(print -r -- "$branches" | fzf -m --query "$LBUFFER" | tr '\n' ' ') || return 0
  [[ -n "$selected" ]] && {
    BUFFER="git branch -d ${selected}"
    zle accept-line
  }
  zle clear-screen
}
zle -N fzf-git-branch-delete
bindkey '^x' fzf-git-branch-delete


# fzf + gwq (worktree選択してcd)
function fzf-gwq() {
  local list selected

  # パスに/worktrees/が含まれないものがghqで管理している元リポジトリ
  list=$(gwq list --json | jq -r '.[] | (if (.path | contains("/worktrees/")) then "  " else "● " end) + .branch + "\t" + .path')
  [[ -z "$list" ]] && return 0

  selected=$(print -r -- "$list" | fzf --query "$LBUFFER" --with-nth=1 --delimiter='\t') || return 0
  [[ -n "$selected" ]] && {
    local selected_dir=$(echo "$selected" | cut -f2)
    BUFFER="cd ${selected_dir}"
    zle accept-line
  }
  zle clear-screen
}
zle -N fzf-gwq
bindkey '^\' fzf-gwq


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

function ide() {
    tmux send-keys -R
    tmux split-window -v -p 15
    tmux select-pane -U
    tmux split-window -h
    tmux select-pane -R
}
alias ide=ide
alias e=exit

# tmux auto-start disabled
# if [ $SHLVL = 1 ]; then
#   tmux
# fi
export XDG_CONFIG_HOME=$HOME/.config
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# LM Studio CLI
export PATH="$PATH:$HOME/.lmstudio/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hinatades/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hinatades/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hinatades/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hinatades/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
