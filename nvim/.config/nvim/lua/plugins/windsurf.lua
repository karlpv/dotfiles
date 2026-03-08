return {
  "Exafunction/windsurf.nvim",
  event = "InsertEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("codeium").setup({
      virtual_text = {
        enabled = true,
        manual = false,
        idle_delay = 75,
        virtual_text_priority = 65535,
        map_keys = true,
        accept_fallback = nil, -- keep nil; Blink handles popup accepts
        key_bindings = {
          accept = "<C-L>",   -- ✅ safe with Blink
          accept_word = false,
          accept_line = false,
          clear = false,
          next = "<C-.>",     -- Alt-]
          prev = "<C-,>",     -- Alt-[
        },
      },
    })
    vim.api.nvim_set_hl(0, "CodeiumSuggestion", { fg = "#5c6370", italic = true })
  end,
}
