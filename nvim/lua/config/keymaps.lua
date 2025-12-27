-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Migrated from .vimrc

-- Window navigation (override default buffer navigation)
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Move to window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Move to window left" })

-- Delete without yanking
vim.keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete char without yank" })
vim.keymap.set("n", "d", '"_d', { noremap = true, desc = "Delete without yank" })
vim.keymap.set("n", "D", '"_D', { noremap = true, desc = "Delete to end without yank" })

-- Auto-close brackets with newline
vim.keymap.set("i", "{<CR>", "{}<Left><CR><ESC><S-o>", { noremap = true })
vim.keymap.set("i", "[<CR>", "[]<Left><CR><ESC><S-o>", { noremap = true })
vim.keymap.set("i", "(<CR>", "()<Left><CR><ESC><S-o>", { noremap = true })

-- Map Ctrl+? to Ctrl+h
vim.keymap.set({ "i", "c" }, "<C-?>", "<C-h>", { noremap = true })
