return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.python = { "ruff_format" }
    opts.formatters_by_ft.json = { "prettier" }
    opts.formatters_by_ft.jsonc = { "prettier" }
    return opts
  end,
}
