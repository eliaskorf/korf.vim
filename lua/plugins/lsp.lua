-- ~/.config/nvim/lua/plugins/lsp.lua

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- Пример маппинга: "K" — показать документацию
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
end

-- Setup language servers.
local lspconfig = require('lspconfig')

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
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact", "svelte", "vue" },
})

lspconfig.pyright.setup {}
lspconfig.ts_ls.setup {}

