---@type Base46Table
local M = {}

M.base_30 = {
  white = "#ffffff",
  black = "#333333",
  darker_black = "#2b2b2b",
  black2 = "#3b3b3b",
  one_bg = "#404040",
  one_bg2 = "#474747",
  one_bg3 = "#505050",
  grey = "#7f7f7f",
  grey_fg = "#8c8c8c",
  grey_fg2 = "#9a9a9a",
  light_grey = "#b5b5b5",
  red = "#d75f5f",
  baby_pink = "#ff8787",
  pink = "#ff5f87",
  line = "#4a4a4a",
  green = "#87af87",
  vibrant_green = "#afd787",
  nord_blue = "#87afd7",
  blue = "#87afaf",
  seablue = "#5f8787",
  yellow = "#ffd787",
  sun = "#ffaf5f",
  purple = "#af87d7",
  dark_purple = "#875faf",
  teal = "#5fafaf",
  orange = "#ffaf5f",
  cyan = "#87d7d7",
  statusline_bg = "#3b3b3b",
  lightbg = "#474747",
  pmenu_bg = "#87af87",
  folder_bg = "#87afd7",
}

M.base_16 = {
  base00 = "#333333",
  base01 = "#3b3b3b",
  base02 = "#474747",
  base03 = "#6c6c6c",
  base04 = "#8c8c8c",
  base05 = "#d7d7af",
  base06 = "#e4e4be",
  base07 = "#ffffff",
  base08 = "#d75f5f",
  base09 = "#ffaf5f",
  base0A = "#ffd787",
  base0B = "#87af87",
  base0C = "#87d7d7",
  base0D = "#87afd7",
  base0E = "#af87d7",
  base0F = "#ff8787",
}

M.type = "dark"

M = require("base46").override_theme(M, "vim_desert")

return M
