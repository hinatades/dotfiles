return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline_popup", -- 標準のコマンドラインをポップアップに変更
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%", -- 画面の中央 (縦)
          col = "50%", -- 画面の中央 (横)
        },
        size = {
          width = "50%", -- フォームの横幅
          height = "auto", -- 高さは自動
        },
        border = {
          style = "rounded", -- ボーダーの形状 ('none', 'single', 'double', 'rounded' など)
          padding = { 1, 2 }, -- ボーダー内の余白
        },
      },
    },
    presets = {
      command_palette = true, -- コマンドパレット風にする
    },
  },
}
