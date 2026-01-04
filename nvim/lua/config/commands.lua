-- Custom commands migrated from .vimrc

-- Atcoder C++ template
vim.api.nvim_create_user_command("Atcoder", function()
  local lines = {
    "#include <cmath>",
    "#include <iomanip>",
    "#include <iostream>",
    "#include <map>",
    "#include <regex>",
    "#include <set>",
    "#include <string>",
    "#include <vector>",
    "#define rep(i, n) for (int i = 0; i < (n); i++)",
    "using namespace std;",
    "using ll = long long;",
    "using dl = long double;",
    "using P = pair<int, int>;",
    "const int MOD = 1e9 + 7;",
    "",
    "int main() {",
    "  int n;",
    "  cin >> n;",
    "}",
  }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

-- Ruff Python formatter
vim.api.nvim_create_user_command("Ruff", function()
  local ok, conform = pcall(require, "conform")
  if not ok then
    vim.notify("conform.nvim is not installed", vim.log.levels.ERROR)
    return
  end
  conform.format({ bufnr = vim.api.nvim_get_current_buf() })
end, {})

-- TSX filetype detection (migrated from .vimrc autocmd)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tsx",
  callback = function()
    vim.bo.filetype = "typescript.tsx"
  end,
})

-- Quickfix autocmd (migrated from .vimrc)
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  command = "cwindow",
})

-- Rg command for Telescope live_grep using ripgrep with fzf scoring
-- Usage: :Rg [search_term]
-- If no argument, opens interactive live grep
-- If argument provided, pre-fills the search with fuzzy matching
vim.api.nvim_create_user_command("Rg", function(opts)
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    vim.notify("Telescope is not installed", vim.log.levels.ERROR)
    return
  end

  -- Get fzf-native sorter for better scoring
  local telescope = require("telescope")
  local fzf_ok, fzf_sorter = pcall(function()
    return telescope.extensions.fzf.native_fzf_sorter()
  end)

  local search_term = opts.args
  local live_grep_opts = {
    default_text = search_term ~= "" and search_term or nil,
  }

  -- Apply fzf-native sorter if available
  if fzf_ok and fzf_sorter then
    live_grep_opts.sorter = fzf_sorter
  end

  builtin.live_grep(live_grep_opts)
end, { nargs = "?" })

-- Alias: :RG (uppercase)
vim.api.nvim_create_user_command("RG", function(opts)
  vim.cmd("Rg " .. opts.args)
end, { nargs = "?" })

-- Fzf command for Telescope find_files
-- Usage: :Fzf [search_term]
-- If no argument, opens interactive file finder
-- If argument provided, searches for files matching that term
vim.api.nvim_create_user_command("Fzf", function(opts)
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    vim.notify("Telescope is not installed", vim.log.levels.ERROR)
    return
  end

  local search_term = opts.args
  if search_term == "" then
    builtin.find_files()
  else
    builtin.find_files({ default_text = search_term })
  end
end, { nargs = "?" })

-- Alias: :FZF (uppercase)
vim.api.nvim_create_user_command("FZF", function(opts)
  vim.cmd("Fzf " .. opts.args)
end, { nargs = "?" })
