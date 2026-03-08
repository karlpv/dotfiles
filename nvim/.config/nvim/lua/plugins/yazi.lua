-- ~/.config/nvim/lua/plugins/yazi.lua
return {
  ---@type LazySpec
  "mikavilpas/yazi.nvim",
  version = "*", -- latest stable
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = false,

    -- ✅ When you close yazi, Neovim's cwd becomes yazi's current directory.
    -- This makes nvim-tree open at the same directory next time.
    change_neovim_cwd_on_close = true,

    keymaps = {
      show_help = "<f1>",
      change_working_directory = "<c-p>",
    },
    integrations = {
      grep_in_directory = "snacks.picker",
      grep_in_selected_files = "snacks.picker",
    },
  },
  init = function()
    -- Prevent netrw from loading (recommended when open_for_directories=true)
    vim.g.loaded_netrwPlugin = 1
  end,
}
