-- ~/.config/nvim/lua/plugins/lsp.lua

local lspconfig = require("lspconfig")
-- Убираем: local util = require("lspconfig.util") -- Это вызывало ошибку
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- Пример маппинга: "K" — показать документацию
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
  -- Можно добавить и другие общие LSP-маппинги здесь
end

-- Setup language servers.

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Emmet
lspconfig.emmet_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact", "svelte", "vue" }, -- Убедись, что список полный
  root_dir = lspconfig.util.root_pattern(".git", "package.json") or vim.fn.getcwd(),
  init_options = {
    includeLanguages = {
      javascript = "javascriptreact",
      typescript = "typescriptreact",
    },
    showSuggestionsAsSnippets = true,
    triggerExpansionOnTab = true,
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    syntaxProfiles = {
      html = {
        attr_quotes = "single"
       }
    },
    -- Переменные (пример)
    -- variables = {
    --   lang = "ru",
    --   charset = "UTF-8"
    -- }
  }
})

-- Astro
lspconfig.astro.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "astro" },
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- Javascrip Typescript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
