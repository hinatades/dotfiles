"----------------------------------------------------------------------------------------------
"                                        _
"                                 _   __(_)___ ___  __________
"                                | | / / / __ `__ \/ ___/ ___/
"                                | |/ / / / / / / / /  / /__
"                                |___/_/_/ /_/ /_/_/   \___/
"
"                                 github.com/hinatades/dotfiles
"
"----------------------------------------------------------------------------------------------


" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 全角文字専用の設定
set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu
" 文字コード
set encoding=UTF-8

"----------------------------------------
" 検索
"----------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch

" カッコの自動補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D

" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" Windowsでパスの区切り文字をスラッシュで扱う
set shellslash
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの履歴を10000件保存する
set history=10000
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=4
" タブキー押下時に挿入される文字幅を指定
set softtabstop=4
" ファイル内にあるタブ文字の表示幅
set tabstop=4
" ツールバーを非表示にする
set guioptions-=T
" yでコピーした時にクリップボードに入る
set guioptions+=a
" メニューバーを非表示にする
set guioptions-=m
" 右スクロールバーを非表示
set guioptions+=R
" フォントの設定
set guifont=RictyDiscordForPowerline\ Nerd\ Font:h14
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" スワップファイルを作成しない
set noswapfile
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" タイトルを表示
set title
" 行番号の表示
set number
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect
" すべての数を10進数として扱う
set nrformats=
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" バッファスクロール

" Quickfix
autocmd QuickFixCmdPost *grep* cwindow

"" let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
" `:Rg` でカレントディレクトリ以下のgrep (ripgrep)、プレビュー付き

" https://github.com/junegunn/fzf.vim/issues/456
set rtp+=~/.fzf

nnoremap <silent><C-e> :NERDTreeToggle<CR>
" Switch between different windows by their direction`
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

" 行番号の色を設定
autocmd ColorScheme * highlight LineNr ctermfg=240
" Vimの背景色をターミナルの背景色と揃える
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

" Cursor
"SI = INSERT mode
"SR = REPLACE mode
"EI = NORMAL mode (ELSE)

" Other options (replace the number after \e[):
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).
" let &t_SI = "\e[5 q"
" let &t_EI = "\e[3 q"

syntax on
colorscheme onedark

" 行を強調表示
set cursorline
highlight CursorLine ctermbg=233
" 列を強調表示
set cursorcolumn
highlight CursorColumn ctermbg=233

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

" C++
function! Atcoder()
  return setline('.', [
              \ '#include <cmath>',
              \ '#include <iomanip>',
              \ '#include <iostream>',
              \ '#include <map>',
              \ '#include <regex>',
              \ '#include <set>', 
              \ '#include <string>',
              \ '#include <vector>',
              \ '#define rep(i, n) for (int i = 0; i < (n); i++)',
              \ 'using namespace std;',
              \ 'using ll = long long;',
              \ 'using dl = long double;',
              \ 'using P = pair<int, int>;',
              \ 'const int MOD = 1e9 + 7;',
              \ '',
              \ 'int main() {',
              \ '  int n;',
              \ '  cin >> n;',
              \ '}'
              \ ])
endfunction
command Atcoder :call Atcoder()
command! Hello echo 'Hello, world!'

function! FormatWithBlack()
    let l:current_view = winsaveview()
    execute '%!black -q -'
    call winrestview(l:current_view)
endfunction
command! Black call FormatWithBlack()
autocmd BufWritePre *.py call FormatWithBlack()

" Golang
let g:go_null_module_warning = 0
let g:go_fmt_command = "goimports"
"" Check GoLint、GoVet、GoErrCheck
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']

let g:lsp_async_completion = 1
let g:asyncomplete_auto_popup = 1

" Terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" Markdown
let g:previm_open_cmd = 'open -a Google\ Chrome'
" <ctrl>-p Preview
nnoremap <silent> <C-p> :PrevimOpen<CR>
let g:previm_enable_realtime = 1

" Re:VIEW
let g:vim_review#include_filetypes = ['python']

"Protobuf
let g:clang_format#auto_format=0
let g:clang_format#style_options = {
            \ "AlignConsecutiveAssignments": "true",
            \ "AlignTrailingComments": "true"}

" PlantUML
let g:plantuml_executable_script="~/dotfiles/plantuml.sh"

" Ag
" Remove file names form the search results
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" coc.nvim
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" coc-explorer
nmap <space>d :CocCommand explorer <CR>
" :Prettier to format current buffer.
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"What is autocmd?
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx


" https://qiita.com/rild/items/ccbf7c7ac9cecd1fc32d
noremap! <C-?> <C-h>

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'joshdick/onedark.vim', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" C++
Plug 'rhysd/vim-clang-format'

" Rust
Plug 'rust-lang/rust.vim'

" Typescript, tsx, React
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'mattn/vim-goimports'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Terraform
Plug 'hashivim/vim-terraform'

" GraphQL
Plug 'jparise/vim-graphql'

" PlantUML
Plug 'aklt/plantuml-syntax'

Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'rust-lang/rust.vim'

Plug 'previm/previm'

call plug#end()
