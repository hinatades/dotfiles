return {
  "navarasu/onedark.nvim",
  priority = 1000, -- LazyVimで最優先にロード
  config = function()
    require("onedark").setup({
      style = "cool", -- 'dark' | 'darker' | 'cool' | 'deep' | 'warm' | 'warmer'
      transparent = true,
      highlights = {
        -- Migrated from .vimrc highlight settings
        LineNr = { fg = "#585858" }, -- ctermfg=240
        CursorLine = { bg = "#121212" }, -- ctermbg=233
        CursorColumn = { bg = "#121212" }, -- ctermbg=233
        Normal = { bg = "NONE" }, -- transparent background
      },
    })
    require("onedark").load()
  end,
}
