-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-j>", ":bprev<CR>", { silent = true, noremap = true, desc = "前のバッファ" })
vim.keymap.set("n", "<C-k>", ":bnext<CR>", { silent = true, noremap = true, desc = "次のバッファ" })
