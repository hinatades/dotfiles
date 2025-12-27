-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Custom cursor shape
vim.opt.guicursor = "n-v-c-i-ci:hor20,r:hor20,o:hor20"

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

-- Others
vim.opt.autoread = true  -- ファイルが外部で変更されたら自動的に読み込む
vim.opt.foldenable = false
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
