require "nvchad.mappings"
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local snacks = require "snacks"

local function picker(name, picker_opts)
  return function()
    snacks.picker[name](picker_opts or {})
  end
end

local function lsp_picker(name, fallback)
  return function()
    local ok = pcall(function()
      snacks.picker[name]()
    end)
    if not ok and fallback then
      fallback()
    end
  end
end

vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")

map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")
map("t","<ESC>",[[<C-\><C-n>]],opts)

map("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
map("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "þ", "/")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "x", '"_x', opts)
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- AI and LSP toggles
map("n", "<leader>ai", ":Codeium Toggle<CR>", { desc = "Toggle Codeium AI" })

map("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle LSP inlay hints" })

map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
map("n", "<leader>pd", picker "diagnostics", { desc = "Diagnostics picker" })

map("n", "<leader>lr", lsp_picker("lsp_references", vim.lsp.buf.references), { desc = "LSP references" })
map("n", "<leader>li", lsp_picker("lsp_implementations", vim.lsp.buf.implementation), { desc = "LSP implementations" })
map("n", "<leader>lD", lsp_picker("lsp_type_definitions", vim.lsp.buf.type_definition), { desc = "LSP type definitions" })

map("n", "<M-n>", "<cmd>resize +2<CR>", { desc = "Resize window taller" })
map("n", "<M-e>", "<cmd>resize -2<CR>", { desc = "Resize window shorter" })
map("n", "<M-i>", "<cmd>vertical resize +5<CR>", { desc = "Resize window wider" })
map("n", "<M-m>", "<cmd>vertical resize -5<CR>", { desc = "Resize window narrower" })

-- Snacks picker mappings
map("n", "<leader>pf", picker "files", { desc = "Find files (Snacks)" })
map("n", "<leader>pg", picker("grep", { live = true }), { desc = "Live grep (Snacks)" })
map("n", "<leader>pb", picker "buffers", { desc = "Buffers (Snacks)" })
map("n", "<leader>po", picker "recent", { desc = "Recent files (Snacks)" })
map("n", "<leader>pa", picker("files", { hidden = true, git_status = false }), { desc = "All files (Snacks)" })

map(
  "n",
  "<leader>tt",
  ":lua require('base46').toggle_transparency()<CR>",
  { noremap = true, silent = true, desc = "Toggle Background Transparency" }
)
 
map(
  "n", "<leader>cd",function()
    vim.cmd("cd %:p:h")
    print(vim.fn.getcwd())
end,
  { desc = "Change directory to current file" }
)

map({ "n", "t" }, "<leader>uh", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle horizontal terminal" })

map({ "n", "t" }, "<leader>uv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Toggle vertical terminal" })

map({ "n", "t" }, "<leader>uf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })


-- Replace the word cursor is on globally
map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word cursor is on globally" }
)

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

map("n", "<leader><leader>", function()
  local buf_dir = vim.fn.expand "%:p"
  local cwd = buf_dir ~= "" and vim.fn.fnamemodify(buf_dir, ":h") or vim.loop.cwd()
  snacks.picker.files {
    cwd = cwd,
    title = ("Files in %s"):format(cwd),
  }
end, { desc = "Find files in current buffer directory" })

-- Typst preview mappings (only active in .typ files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function(ev)
    local bufnr = ev.buf

    -- Toggle preview
    map("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", { desc = "Typst: Preview toggle", buffer = bufnr })

    -- Sync preview to the current cursor position
    map("n", "<leader>tr", "<cmd>TypstPreviewSyncCursor<CR>", { desc = "Typst: Preview sync cursor", buffer = bufnr })

    -- Stop preview explicitly (if you want it separate from toggle)
    map("n", "<leader>tq", "<cmd>TypstPreviewStop<CR>", { desc = "Typst: Preview stop", buffer = bufnr })

    -- Open another preview frontend if one is already running
    map("n", "<leader>to", "<cmd>TypstPreview<CR>", { desc = "Typst: Open preview", buffer = bufnr })
  end,
})

-- Typst: compile current file to PDF
vim.keymap.set("n", "<leader>tc", function()
  local file = vim.fn.expand "%:p"
  if vim.bo.filetype ~= "typst" then
    vim.notify("Not a Typst file", vim.log.levels.WARN)
    return
  end
  vim.cmd "write"
  vim.fn.jobstart({ "typst", "compile", file }, { detach = true })
  vim.notify("Typst compiled to PDF", vim.log.levels.INFO)
end, { desc = "Typst: compile to PDF" })
