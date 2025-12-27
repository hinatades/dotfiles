-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = "n-v-c-i-ci:hor20,r:hor20,o:hor20"

-- Migrated from .vimrc

-- Backup and swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Editing
vim.opt.virtualedit = "block"
vim.opt.backspace = "indent,eol,start"
vim.opt.ambiwidth = "double"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Display
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.list = true
vim.opt.listchars = { tab = "^ ", trail = "~" }
vim.opt.display = "lastline"
vim.opt.title = true
vim.opt.showcmd = true

-- Indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.cinoptions:append(":0")

-- Command line
vim.opt.wildmenu = true
vim.opt.history = 10000
vim.opt.cmdheight = 2

-- Status line
vim.opt.laststatus = 2

-- Clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- Others
vim.opt.errorbells = false
vim.opt.foldenable = false
vim.opt.nrformats = ""
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
