---@type Base46Table
local M = {}

-- Inspired by Vim's "default" colors (16-color-ish), but tuned for:
-- - very dark background (#0b0b0b)
-- - higher contrast
-- - cleaner, less muddy hues

M.base_30 = {
  white = "#e6e6e6",
  black = "#0b0b0b", -- nvim bg
  darker_black = "#060606",
  black2 = "#141414",
  one_bg = "#1c1c1c",
  one_bg2 = "#242424",
  one_bg3 = "#2c2c2c",
  grey = "#3a3a3a",
  grey_fg = "#5c5c5c",
  grey_fg2 = "#7a7a7a",
  light_grey = "#a8a8a8",

  red = "#ff5f5f",
  baby_pink = "#ff87af",
  pink = "#ff5fd7",

  line = "#2c2c2c",

  green = "#5fff87",
  vibrant_green = "#00ff5f",

  nord_blue = "#7aa2ff",
  blue = "#5f87ff",
  seablue = "#00afff",

  yellow = "#ffd75f",
  sun = "#ffff87",

  purple = "#af5fff",
  dark_purple = "#875fff",

  teal = "#00d7ff",
  orange = "#ff875f",
  cyan = "#5fffff",

  statusline_bg = "#101010",
  lightbg = "#1f1f1f",
  pmenu_bg = "#ffd75f",
  folder_bg = "#5f87ff",
}

M.base_16 = {
  base00 = "#0b0b0b",
  base01 = "#151515",
  base02 = "#202020", -- visual selection
  base03 = "#6c6c6c",
  base04 = "#a8a8a8",
  base05 = "#e6e6e6",
  base06 = "#ffffff",
  base07 = "#f2f2f2",

  -- core 16-color-ish accents
  base08 = "#ff5f5f", -- identifiers/variables
  base09 = "#ff5fff", -- numbers/booleans/constants
  base0A = "#5fffff", -- types/preproc
  base0B = "#5fff87", -- strings
  base0C = "#00d7ff", -- specials/regex
  base0D = "#5f87ff", -- functions
  base0E = "#ffd75f", -- keywords
  base0F = "#d0d0d0", -- delimiters
}

-- Theme-local highlight tweaks to keep the "default vim" vibe.
M.polish_hl = {
  defaults = {
    -- Vim's default look often has blue comments; keep them readable on #0b0b0b.
    Comment = { fg = "#5f87af", italic = false },

    -- Classic black-on-yellow search.
    Search = { fg = M.base_30.black, bg = M.base_30.yellow, bold = true },
    IncSearch = { fg = M.base_30.black, bg = M.base_30.orange, bold = true },

    CursorLineNr = { fg = M.base_16.base06, bold = true },
  },

  treesitter = {
    ["@comment"] = { fg = "#5f87af" },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "vim_default_hc")

return M
