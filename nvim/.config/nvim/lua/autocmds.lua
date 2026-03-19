require "nvchad.autocmds"

-- Minimal: set NvChad theme once on UI start based on macOS appearance
-- Pick themes that exist in base46:
local LIGHT, DARK = "vim_default_light", "vim_default"

local function mac_is_dark()
  local out = vim.fn.system [[osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode']]
  return type(out) == "string" and out:match "true" ~= nil
end

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    local is_dark = mac_is_dark()
    vim.o.background = is_dark and "dark" or "light"
    vim.g.nvchad_theme = is_dark and DARK or LIGHT
    pcall(function()
      require("base46").load_all_highlights()
    end)
  end,
})

-- Keep nvim-tree in sync with Neovim's cwd
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    local ok, api = pcall(require, "nvim-tree.api")
    if ok then
      api.tree.change_root(vim.loop.cwd())
    end
  end,
})

-- Open Oil directory view when launching nvim with a directory arg
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 1 and not vim.g.started_by_firenvim then
      local arg = vim.fn.argv(0)
      if vim.fn.isdirectory(arg) == 1 then
        vim.cmd("Oil " .. vim.fn.fnameescape(arg))
      end
    end
  end,
})
