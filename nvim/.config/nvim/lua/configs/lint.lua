local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  javascript = { "eslint_d", "eslint" },
  typescript = { "eslint_d", "eslint" },
  javascriptreact = { "eslint_d", "eslint" },
  typescriptreact = { "eslint_d", "eslint" },
  svelte = { "eslint_d", "eslint" },
  sh = { "shellcheck" },
  go = { "golangci_lint" },
  c = { "clangtidy" },
  cpp = { "clangtidy" },
}

-- Auto-run lint on save only (manual lint remains on <leader>l)
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Keymap for manual linting
vim.keymap.set("n", "<leader>l", function()
  require("lint").try_lint()
end, { desc = "Run linter (nvim-lint)" })
