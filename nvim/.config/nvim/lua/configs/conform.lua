-- local options = {
--   formatters_by_ft = {
--     lua = { "stylua" },
--     css = { "prettier" },
--     html = { "prettier" },
--     markdown = { "prettier" },
--   },
--
--   format_on_save = {
--     -- These options will be passed to conform.format()
--     timeout_ms = 500,
--     lsp_fallback = true,
--   },
-- }
--
-- return options
--
local conform = require "conform"

conform.setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Use LSP as a last resort only if no formatter is set for this filetype
    return { timeout_ms = 2000, lsp_fallback = true }
  end,

  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    svelte = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },

    -- Python: choose one approach
    -- Ruff-only (fast; opinionated):
    python = { "ruff_fix", "ruff_format" },
    -- Or comment the above and use Black+isort:
    -- python = { "isort", "black" },

    sh = { "shfmt" },

    go = { "gofumpt", "goimports" },

    c = { "clang_format" },
    cpp = { "clang_format" },

    sql = { "sql_formatter" },
    typst = {"typstyle"},
  },

  -- Per-formatter tweaks (optional)
  formatters = {
    shfmt = { prepend_args = { "-i", "2", "-ci" } }, -- 2-space indents
    -- Example: force Prettier print width 100 if not using prettierd
    -- prettier = { prepend_args = { "--print-width", "100" } },
  },
}

-- Keymap: manual format (uses Conform)
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format { async = true, lsp_fallback = true }
end, { desc = "Format buffer/selection (Conform)" })
