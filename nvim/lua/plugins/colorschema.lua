return {
  "navarasu/onedark.nvim",
  priority = 1000, -- LazyVimで最優先にロード
  config = function()
    require("onedark").setup({
      style = "cool", -- 'dark' | 'darker' | 'cool' | 'deep' | 'warm' | 'warmer'
      transparent = true,
    })
    require("onedark").load()
  end,
}
