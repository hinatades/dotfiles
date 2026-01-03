return {
  -- Telescope - Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    -- Remove cmd lazy loading to ensure fzf-native is loaded properly
    event = "VeryLazy",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Use ripgrep with optimized arguments
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case", -- smart case matching
            "--hidden", -- search hidden files
            "--glob=!.git/", -- exclude .git
          },
          -- Path display settings
          path_display = { "smart" }, -- Smart path truncation
          -- Layout settings
          layout_config = {
            horizontal = {
              preview_width = 0.5, -- Preview and results split 50/50
            },
            width = 0.85, -- Use 85% of screen width
            height = 0.85, -- Use 85% of screen height
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<esc>"] = actions.close,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.lock$",
            "lazy%-lock%.json",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- smart_case, ignore_case, respect_case
          },
        },
      })

      -- Load fzf extension for better scoring algorithm
      pcall(telescope.load_extension, "fzf")

      -- Apply fzf-native sorter to live_grep explicitly
      -- This ensures fzf scoring works for content search
      local fzf_sorter = telescope.extensions.fzf.native_fzf_sorter()
      require("telescope.config").values.generic_sorter = function()
        return fzf_sorter
      end
    end,
  },
}
