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
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
          before_init = function(_, config)
            local root = config.root_dir
            -- .venvを探索（カレント→親ディレクトリ）
            local venv = root .. "/.venv/bin/python"
            local parent_venv = vim.fn.fnamemodify(root, ":h") .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then
              config.settings.python.pythonPath = venv
            elseif vim.fn.executable(parent_venv) == 1 then
              config.settings.python.pythonPath = parent_venv
            -- poetry環境を検出
            elseif vim.fn.filereadable(root .. "/poetry.lock") == 1 then
              local handle = io.popen("cd " .. root .. " && poetry env info --path 2>/dev/null")
              local path = handle and handle:read("*a"):gsub("%s+", "") or ""
              if handle then handle:close() end
              if path ~= "" then
                config.settings.python.pythonPath = path .. "/bin/python"
              end
            end
          end,
        },
      },
    },
  },
}
