-- mason и mason-lspconfig базовая настройка
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "emmet_ls" },
  automatic_enable = false,  -- отключаем авто включение для избежания ошибок
})

local lspconfig = require("lspconfig")

-- ручная настройка каждого сервера с возможностью кастомизации
lspconfig.lua_ls.setup({})
lspconfig.ts_ls.setup({})
lspconfig.emmet_ls.setup({
  filetypes = { "html", "css", "javascriptreact", "typescriptreact", "sass", "scss", "less", "svelte" },
})

