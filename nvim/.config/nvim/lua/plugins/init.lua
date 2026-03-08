-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Core UI/quality plugins
  { import = "plugins.blink" },
  { import = "plugins.windsurf" },
  { import = "plugins.treesitter" },
  { import = "plugins.markdown-preview" },
  { import = "plugins.snacks" },
  -- Mason family (loads first; see lua/plugins/mason.lua)
  { import = "plugins.mason" },
  { import = "plugins.typst-preview"},
  { import = "plugins.oil"},
  { import = "plugins.yazi"},
  { import = "plugins.flash"},
  -- {import = "plugins.todo-comments"},

  -- LSP (pin to stable to avoid deprecation warnings)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig" -- your server setups live here
    end,
  },

  -- Formatting (Conform) – uses configs/conform.lua
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.conform",
  },

  -- Linting (nvim-lint) – uses configs/lint.lua (optional but nice)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },

  -- Fun / misc
  {
    "ThePrimeagen/vim-be-good",
    cmd = { "VimBeGood" },
  },

}
