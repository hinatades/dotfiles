return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright", -- Python LSP server
        "ruff", -- Python linter/formatter
      },
    },
  },
}
