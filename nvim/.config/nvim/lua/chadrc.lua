-- ~/.config/nvim/lua/chadrc.lua
---@type ChadrcConfig
local M = {}

local LIGHT, DARK = "vim_default_light", "vim_default"
local is_light = (vim.env.THEME == "light")
local chosen = is_light and LIGHT or DARK
M.base46 = {
  theme = chosen,
  theme_toggle = { LIGHT, DARK },
}

M.ui = {
  theme = chosen,
  theme_toggle = { LIGHT, DARK },
  transparency = false,
  -- tabufline = { lazyload = false },
  statusline = {
    enabled = true,
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    order = nil,
    modules = nil,
  },
}

M.nvdash = { load_on_startup = false }

vim.o.background = is_light and "light" or "dark"

return M
