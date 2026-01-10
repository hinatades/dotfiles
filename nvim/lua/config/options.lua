-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Custom cursor shape (horizontal bar cursor)
-- tmux-compatible cursor settings
vim.opt.guicursor = "n-v-c:hor20,i-ci-ve:hor20,r-cr:hor20,o:hor20"

-- Ensure cursor shape is restored when switching between tmux panes
if vim.env.TMUX then
  vim.cmd([[
    autocmd VimEnter,VimResume * set guicursor=n-v-c:hor20,i-ci-ve:hor20,r-cr:hor20,o:hor20
    autocmd VimLeave,VimSuspend * set guicursor=a:hor20
  ]])
end

-- Display
vim.opt.relativenumber = false  -- 相対行番号を無効化（通常の行番号のみ表示）
vim.opt.cursorcolumn = true
vim.opt.matchtime = 1
vim.opt.listchars = { tab = "^ ", trail = "~" }

-- Indent (LazyVim default is 2, override to 4)
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.cinoptions:append(":0")

-- Command line
vim.opt.cmdheight = 2

-- Spell check (disable for Japanese)
vim.opt.spell = false  -- スペルチェックを無効化
vim.opt.spelllang = { "en" }  -- 英語のみ

-- Others
vim.opt.autoread = true  -- ファイルが外部で変更されたら自動的に読み込む
vim.opt.foldenable = false
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"

-- Horizontal scrolling
vim.opt.sidescrolloff = 0  -- カーソル移動時の横スクロール追随を無効化

-- Disable conceal for Markdown (show raw syntax)
vim.opt.conceallevel = 0  -- Markdownのconceal機能を無効化（構文を常に表示）
