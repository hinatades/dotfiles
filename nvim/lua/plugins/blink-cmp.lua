return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    -- Disable completion sources in specific filetypes
    opts.sources = opts.sources or {}
    opts.sources.per_filetype = opts.sources.per_filetype or {}

    -- Completely disable all completion sources in oil.nvim and Telescope
    opts.sources.per_filetype.oil = {}
    opts.sources.per_filetype.TelescopePrompt = {}

    return opts
  end,
}
