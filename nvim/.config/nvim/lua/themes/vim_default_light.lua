---@type Base46Table
local M = {}

M.base_30 = {
  white = "#111111",
  black = "#ffffff",
  darker_black = "#f4f4f4",
  black2 = "#efefef",
  one_bg = "#e8e8e8",
  one_bg2 = "#dfdfdf",
  one_bg3 = "#d6d6d6",
  grey = "#8a8a8a",
  grey_fg = "#6f6f6f",
  grey_fg2 = "#565656",
  light_grey = "#3d3d3d",
  red = "#d70000",
  baby_pink = "#d75f87",
  pink = "#d70087",
  line = "#dddddd",
  green = "#008700",
  vibrant_green = "#005f00",
  nord_blue = "#005fd7",
  blue = "#005faf",
  seablue = "#008787",
  yellow = "#af8700",
  sun = "#875f00",
  purple = "#8700af",
  dark_purple = "#5f00af",
  teal = "#00875f",
  orange = "#d75f00",
  cyan = "#0087af",
  statusline_bg = "#ebebeb",
  lightbg = "#e1e1e1",
  pmenu_bg = "#005faf",
  folder_bg = "#005faf",
}

M.base_16 = {
  base00 = "#ffffff",
  base01 = "#efefef",
  base02 = "#e8e8e8",
  base03 = "#b2b2b2",
  base04 = "#6f6f6f",
  base05 = "#111111",
  base06 = "#000000",
  base07 = "#000000",
  base08 = "#d70000",
  base09 = "#d75f00",
  base0A = "#af8700",
  base0B = "#008700",
  base0C = "#0087af",
  base0D = "#005faf",
  base0E = "#8700af",
  base0F = "#d70087",
}

M.polish_hl = {
  defaults = {
    Normal = { fg = M.base_16.base05, bg = M.base_16.base00 },
    NormalFloat = { fg = M.base_16.base05, bg = M.base_30.black2 },
    FloatBorder = { fg = M.base_30.blue, bg = M.base_30.black2 },
    CursorLine = { bg = M.base_30.one_bg },
    LineNr = { fg = M.base_30.grey },
    CursorLineNr = { fg = M.base_30.orange, bold = true },
    Visual = { bg = "#d7d7d7" },
    Search = { fg = M.base_16.base00, bg = M.base_30.yellow, bold = true },
    IncSearch = { fg = M.base_16.base00, bg = M.base_30.orange, bold = true },
    Comment = { fg = "#005faf", italic = true },
    DiagnosticError = { fg = M.base_30.red, bold = true },
    DiagnosticWarn = { fg = M.base_30.orange, bold = true },
    DiagnosticInfo = { fg = M.base_30.blue, bold = true },
    DiagnosticHint = { fg = M.base_30.cyan, bold = true },
  },
}

M.type = "light"
M = require("base46").override_theme(M, "vim_default_light")

return M
