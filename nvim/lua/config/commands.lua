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

-- Black Python formatter
vim.api.nvim_create_user_command("Black", function()
  local current_view = vim.fn.winsaveview()
  vim.cmd("%!black -q -")
  vim.fn.winrestview(current_view)
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

-- Ag command for Telescope live_grep (like vim-ag)
-- Usage: :Ag [search_term]
-- If no argument, opens interactive live grep
-- If argument provided, searches for that term
vim.api.nvim_create_user_command("Ag", function(opts)
  local search_term = opts.args
  if search_term == "" then
    require("telescope.builtin").live_grep()
  else
    require("telescope.builtin").grep_string({ search = search_term })
  end
end, { nargs = "?" })
