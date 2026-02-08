return {
  -- Go
  {
    "ray-x/go.nvim",
    dependencies = {
      {
        "ray-x/guihua.lua",
        build = "cd lua/fzy && make",
      },
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Migrated from .vimrc
        goimports = "goimports",
        gofmt = "goimports",
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
  },

  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    config = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- TypeScript/TSX
  {
    "leafgarland/typescript-vim",
    ft = { "typescript", "typescriptreact" },
  },
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- Terraform
  {
    "hashivim/vim-terraform",
    ft = "terraform",
    config = function()
      -- Migrated from .vimrc
      vim.g.terraform_align = 1
      vim.g.terraform_fold_sections = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  -- GraphQL
  {
    "jparise/vim-graphql",
    ft = "graphql",
  },

  -- C++ formatting
  {
    "rhysd/vim-clang-format",
    ft = { "c", "cpp" },
    config = function()
      -- Migrated from .vimrc
      vim.g["clang_format#auto_format"] = 0
      vim.g["clang_format#style_options"] = {
        AlignConsecutiveAssignments = "true",
        AlignTrailingComments = "true",
      }
    end,
  },

}
