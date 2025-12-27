return {
  -- Markdown preview (migrated from previm)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<C-p>", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
    config = function()
      -- Use Chrome for preview (migrated from .vimrc)
      vim.g.mkdp_browser = "Google Chrome"
      vim.g.mkdp_refresh_slow = 0 -- realtime preview
    end,
  },
}
