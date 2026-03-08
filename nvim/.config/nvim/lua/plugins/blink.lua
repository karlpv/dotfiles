return {
  "saghen/blink.cmp",
  dependencies = {
    -- Their README shows this dependency block:
    { "Exafunction/codeium.nvim" },
  },
  opts = function(_, opts)
    opts = opts or {}
    opts.sources = opts.sources or {}
    opts.sources.default = { "lsp", "path", "snippets", "buffer", "codeium" }
    opts.sources.providers = vim.tbl_deep_extend("force", opts.sources.providers or {}, {
      -- This module name comes straight from their docs:
      codeium = { name = "Codeium", module = "codeium.blink", async = true },
    })
    return opts
  end,
}
