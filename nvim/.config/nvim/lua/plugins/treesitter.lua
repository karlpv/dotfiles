return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "vimdoc",
      "html",
      "css",
      "bash",
      "markdown",
      "markdown_inline",
      "c",
      "python",
      "java",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = { enable = true },
  },
}
