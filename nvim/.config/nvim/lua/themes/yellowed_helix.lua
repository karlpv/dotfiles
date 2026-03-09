---@type Base46Table
local M = {}

M.base_30 = {
  white = "#ffffff",
  black = "#101010",
  darker_black = "#0c0c0c",
  black2 = "#141414",
  one_bg = "#181818",
  one_bg2 = "#1f1f1f",
  one_bg3 = "#262626",
  grey = "#565656",
  grey_fg = "#6b6b6b",
  grey_fg2 = "#7a7a7a",
  light_grey = "#9b9b9b",
  red = "#ff0000",
  baby_pink = "#ff5c5c",
  pink = "#ff80f4",
  line = "#1f1f1f",
  green = "#378b1d",
  vibrant_green = "#4bb62c",
  nord_blue = "#3aa3ff",
  blue = "#008dff",
  seablue = "#2a6c9e",
  yellow = "#ffd900",
  sun = "#ffe44d",
  purple = "#994c92",
  dark_purple = "#70386b",
  teal = "#4bb9a7",
  orange = "#ff9c00",
  cyan = "#44c2ff",
  statusline_bg = "#181818",
  lightbg = "#202020",
  pmenu_bg = "#ffd900",
  folder_bg = "#008dff",
}

M.base_16 = {
  base00 = "#101010",
  base01 = "#181818",
  base02 = "#1f1f1f",
  base03 = "#565656",
  base04 = "#6b6b6b",
  base05 = "#ffffff",
  base06 = "#ffffff",
  base07 = "#ffffff",
  base08 = "#ff0000",
  base09 = "#ff9c00",
  base0A = "#ffd900",
  base0B = "#378b1d",
  base0C = "#44c2ff",
  base0D = "#008dff",
  base0E = "#994c92",
  base0F = "#ff80f4",
}

M.polish_hl = {
  defaults = {
    Normal = { fg = M.base_16.base05, bg = M.base_16.base00 },
    NormalFloat = { fg = M.base_16.base05, bg = M.base_30.black2 },
    FloatBorder = { fg = M.base_30.yellow, bg = M.base_30.black2 },
    CursorLine = { bg = M.base_30.one_bg },
    LineNr = { fg = M.base_30.grey },
    CursorLineNr = { fg = M.base_30.yellow, bold = true },
    Visual = { bg = "#303030" },
    Search = { fg = M.base_16.base00, bg = M.base_30.yellow, bold = true },
    IncSearch = { fg = M.base_16.base00, bg = M.base_30.orange, bold = true },
    Comment = { fg = M.base_30.grey_fg, italic = true },
    DiagnosticError = { fg = M.base_30.red, bold = true },
    DiagnosticWarn = { fg = M.base_30.orange, bold = true },
    DiagnosticInfo = { fg = M.base_30.blue, bold = true },
    DiagnosticHint = { fg = M.base_30.cyan, bold = true },
  },
}

M.type = "dark"
M = require("base46").override_theme(M, "yellowed_helix")

return M
