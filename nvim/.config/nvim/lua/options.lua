require "nvchad.options"

-- add yours here!

local opt = vim.opt

-- virtualedit (mode-aware):
-- - Normal/Visual: `virtualedit=all` for free cursor movement past EOL:
--   - Visual-block inserts across ragged lines (align assignments / params)
--   - Column-precise navigation and edits past end-of-line
--   - Paste/insert at a target column without manual re-indent
--   - Edit "rectangular" regions in configs/tables
-- - Insert: switch to `virtualedit=block` so block/column edits still work, but
--   typing into "virtual space" doesn't create huge whitespace explosions.
opt.virtualedit = "all"
do
  local group = vim.api.nvim_create_augroup("VirtualEditByMode", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function()
      vim.opt.virtualedit = "block"
    end,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function()
      vim.opt.virtualedit = "all"
    end,
  })
end

-- tabs/indent: 4-column indentation width
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- disable swapfiles to avoid SwapExists confirmation prompts
opt.swapfile = false

-- search: incremental + highlighted matches, with smart casing
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- show whitespace (especially tabs) so alignment issues are visible
opt.list = true
opt.listchars = { tab = "> ", trail = ".", extends = ">", precedes = "<", nbsp = "+" }
opt.cursorlineopt = "both" -- to enable cursorline!
opt.number = true
opt.relativenumber = true

-- soft wrap globally + continuation marker
opt.wrap = true
opt.linebreak = true
opt.showbreak = "↪ "
opt.breakindent = true
opt.smartindent = true

opt.guicursor = {
  -- Normal / Command: steady block (confident, not shouty)
  "n-c:block-blinkon1",
  -- Visual: blinking block, slightly faster pulse so it feels “selected”
  "v:block-blinkwait150-blinkon120-blinkoff120",
  -- Insert + Cmdline-Insert: thin blinking I-beam (surgical)
  "i-ci:ver25-blinkwait200-blinkon150-blinkoff150",
  -- Replace / Cmdline-Replace: underline, steady
  "r-cr:hor20",
  -- Operator-pending: thin underline, steady
   "o:hor15",
   }

vim.diagnostic.config {
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = "if_many",
    focusable = false,
  },
}

-- opt.statusline=""
