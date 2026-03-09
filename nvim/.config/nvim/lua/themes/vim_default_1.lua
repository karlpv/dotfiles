---@type Base46Table
local M = {}

M.base_30 = {
  white = "#f2f2f2",
  black = "#0b0b0b",
  darker_black = "#080808",
  black2 = "#121212",
  one_bg = "#171717",
  one_bg2 = "#1d1d1d",
  one_bg3 = "#252525",
  grey = "#5f5f5f",
  grey_fg = "#787878",
  grey_fg2 = "#949494",
  light_grey = "#b8b8b8",
  red = "#ff5f5f",
  baby_pink = "#ff8787",
  pink = "#ff5faf",
  line = "#1f1f1f",
  green = "#87d787",
  vibrant_green = "#afff87",
  nord_blue = "#5fafff",
  blue = "#87d7ff",
  seablue = "#5fd7d7",
  yellow = "#ffd75f",
  sun = "#ffff87",
  purple = "#af87ff",
  dark_purple = "#875fff",
  teal = "#5fd7af",
  orange = "#ffaf5f",
  cyan = "#87ffff",
  statusline_bg = "#131313",
  lightbg = "#1d1d1d",
  pmenu_bg = "#5fafff",
  folder_bg = "#5fafff",
}

M.base_16 = {
  base00 = "#0b0b0b",
  base01 = "#121212",
  base02 = "#171717",
  base03 = "#4f4f4f",
  base04 = "#808080",
  base05 = "#f2f2f2",
  base06 = "#ffffff",
  base07 = "#ffffff",
  base08 = "#ff5f5f",
  base09 = "#ffaf5f",
  base0A = "#ffd75f",
  base0B = "#87d787",
  base0C = "#87ffff",
  base0D = "#5fafff",
  base0E = "#af87ff",
  base0F = "#ff87d7",
}

M.polish_hl = {
  defaults = {
    Normal = { fg = M.base_16.base05, bg = M.base_16.base00 },
    NormalFloat = { fg = M.base_16.base05, bg = M.base_30.black2 },
    FloatBorder = { fg = M.base_30.blue, bg = M.base_30.black2 },
    CursorLine = { bg = M.base_30.one_bg },
    LineNr = { fg = M.base_30.grey },
    CursorLineNr = { fg = M.base_30.yellow, bold = true },
    Visual = { bg = "#2b2b2b" },
    Search = { fg = M.base_16.base00, bg = M.base_30.yellow, bold = true },
    IncSearch = { fg = M.base_16.base00, bg = M.base_30.orange, bold = true },
    Comment = { fg = M.base_30.grey_fg, italic = true },
    DiagnosticError = { fg = M.base_30.red, bold = true },
    DiagnosticWarn = { fg = M.base_30.yellow, bold = true },
    DiagnosticInfo = { fg = M.base_30.blue, bold = true },
    DiagnosticHint = { fg = M.base_30.cyan, bold = true },
  },
}

M.type = "dark"
M = require("base46").override_theme(M, "vim_default")

return M
