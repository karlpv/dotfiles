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

-- Common on_attach for enabling inlay hints
local function on_attach_with_hints(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
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
        hint = {
          enable = true,
          setType = true,
          paramType = true,
          paramName = "All",
          semicolon = "SameLine",
          arrayIndex = "Enable",
        },
      },
    },
    on_attach = on_attach_with_hints,
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".git" },
  },
  pyright = {
    on_attach = on_attach_with_hints,
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
    on_attach = on_attach_with_hints,
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  clangd = {
    cmd = clangd_cmd,
    on_attach = on_attach_with_hints,
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  },
  jdtls = {
    on_attach = on_attach_with_hints,
    root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", ".git" },
    settings = {
      java = {
        inlayHints = {
          parameterNames = { enabled = "all" },
        },
      },
    },
  },
  tinymist = {
    on_attach = on_attach_with_hints,
    root_markers = { ".git" },
    settings = {
      exportPdf = "onSave",
      formatterMode = "typstyle",
    },
  },
  html = {
    on_attach = on_attach_with_hints,
    root_markers = { ".git" },
  },
  cssls = {
    on_attach = on_attach_with_hints,
    root_markers = { ".git" },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))
