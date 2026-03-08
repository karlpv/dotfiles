-- ~/.config/nvim/lua/plugins/mason.lua
-- ~/.config/nvim/lua/plugins/mason.lua
return {
  -- 1) Mason core
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- 2) Bridge Mason <-> LSPConfig (auto-install LSP servers)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Core LSP servers
        "lua_ls",           -- Lua
        "pyright",          -- Python
        "ts_ls",            -- TypeScript/JavaScript
        "clangd",           -- C/C++
        "jdtls",            -- Java
        "tinymist",         -- Typst (better than typst_lsp)
        
        -- Web dev
        "html",
        "cssls",
        
        -- Note: HLS (Haskell) usually better via ghcup
        -- but Mason can install it too if needed
        -- "hls",
      },
      automatic_installation = true, -- Auto-install on first file open
    },
  },

  -- 3) Auto-install formatters & linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters (used by conform.nvim)
        "stylua",           -- Lua
        "prettier",         -- JS/TS/JSON/YAML/MD
        "prettierd",        -- Faster prettier
        "clang-format",     -- C/C++
        "shfmt",            -- Shell scripts
        "black",            -- Python (alternative)
        "ruff",             -- Python linting + formatting
        "typstyle",         -- Typst (you have this in conform)
        
        -- Linters (used by nvim-lint)
        "eslint_d",         -- JavaScript/TypeScript
        "shellcheck",       -- Shell scripts
        "markdownlint",     -- Markdown
        "ruff",             -- Python (also lints)
        
        -- Optional but useful
        "sql-formatter",    -- SQL (you have this in conform)
      },
      auto_update = false,
      run_on_start = false,
      start_delay = 3000, -- Wait 3s after startup
      debounce_hours = 24, -- Check once per day
    },
  },
}
