return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
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
    },

    indent = { enable = true },
  },
}
