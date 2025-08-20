require("mason").setup({
    ui = {
      check_outdated_packages_on_open = true,
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "emmet_ls",
    "cssls",
    "cssmodules_ls",
    "html"
  },
  automatic_installation = true,
})

-- Настройки LSP
local lspconfig = require("lspconfig")

-- CSS/Sass/SCSS/Less
lspconfig.cssls.setup({
  filetypes = { "css", "scss", "sass", "less" },
})

lspconfig.cssmodules_ls.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
 })



-- Emmet
lspconfig.emmet_ls.setup({
  filetypes = {
    "html", "css", "javascriptreact", "typescriptreact",
    "sass", "scss", "less", "svelte", "vue", "astro"
  },
})

-- Typescript
lspconfig.ts_ls.setup({})
