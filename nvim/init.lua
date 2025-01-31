-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic Vim options
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.title = true
vim.opt.wildmenu = true
vim.opt.list = true
vim.opt.listchars = { tab = "^ ", trail = "~" }
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.virtualedit = "block"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.history = 10000
vim.opt.scrolloff = 8

vim.opt.guicursor = table.concat({
  "n:hor20",           -- ノーマルモード: アンダーバー（横線カーソル、高さ20%）
  "v:block",           -- ビジュアルモード: ブロックカーソル
  "i:ver25",           -- 挿入モード: 縦線カーソル（幅25%）
  "c:hor20",           -- コマンドモード: ブロックカーソル
  "a:blinkwait700-blinkoff400-blinkon250", -- 全モード共通: 点滅速度
}, ",")

-- Highlight for cursor
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 233 })
vim.api.nvim_set_hl(0, "CursorColumn", { ctermbg = 233 })
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 240 })
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none" })

-- Key mappings
vim.keymap.set("n", "<C-e>", ":NERDTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
