return {
  "folke/snacks.nvim",
  priority = 1000,
  event = "VeryLazy",
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = false,
      preset = {
        header = [[
██╗███╗   ███╗     ██████╗  █████╗ ██╗   ██╗
██║████╗ ████║    ██╔════╝ ██╔══██╗╚██╗ ██╔╝
██║██╔████╔██║    ██║  ███╗███████║ ╚████╔╝ 
██║██║╚██╔╝██║    ██║   ██║██╔══██║  ╚██╔╝  
██║██║ ╚═╝ ██║    ╚██████╔╝██║  ██║   ██║   
╚═╝╚═╝     ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
        ]],
      },
      -- sections = {
        --   { section = "header" },
        --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        --   { section = "startup" },
        -- },
      },

      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      picker = {
        enabled = true,
        focus = "list",
        layout = {
          preset = "telescope",
          preview = "right",
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = "center",
          },
        },
        win = {
          preview = { border = "rounded" },
          list = { border = "rounded" },
          input = { border = "none" },
        },
        keymaps = {
          ["<Up>"] = "focus_prev",
          ["<Down>"] = "focus_next",
          ["<Left>"] = "preview_scroll_up",
          ["<Right>"] = "preview_scroll_down",
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  }
