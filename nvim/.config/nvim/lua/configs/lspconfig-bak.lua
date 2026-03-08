local lsp_defaults = require "nvchad.configs.lspconfig"

lsp_defaults.defaults()

local lua_workspace = {
  vim.fn.expand "$VIMRUNTIME/lua",
  vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
  vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
  "${3rd}/luv/library",
}

local clangd_cmd = {
  "clangd",
  "--background-index",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
}

if vim.fn.executable "clang-tidy" == 1 then
  table.insert(clangd_cmd, 3, "--clang-tidy")
end

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = lua_workspace,
        },
        telemetry = { enable = false },
      },
    },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".git" },
  },

  hls = {
    cmd = { vim.fn.expand "~/.ghcup/bin/haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell", "cabal" },
    root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", ".git" },
    on_attach = function(client,bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true,bufnr)
      end
    end,
    settings = {
      haskell = {
        formattingProvider = "fourmolu",
        plugin = {
          hlint = { globalOn = true },
          ghcide = { maxCompletions = 40 },

        },
      },
    },
  },

  pyright = {
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },

  ts_ls = {
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
        },
      },
    },
  },

  clangd = {
    cmd = clangd_cmd,
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  },

  jdtls = {
    root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
  },

  tinymist = {
    root_markers = { ".git" },
    settings = {
      exportPdf = "onSave",
      formatterMode = "typstyle",
    },
  },

  html = {
    root_markers = { ".git" },
  },

  cssls = {
    root_markers = { ".git" },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))
