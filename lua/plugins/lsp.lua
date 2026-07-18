-- ~/.config/nvim/lua/plugins/lsp.lua
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
end

-- Глобальные настройки
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Конкретные серверы
vim.lsp.config('cssls', {
  filetypes = {
    "css",
    "scss",
    "sass",
    "less",
    "astro" },
})

vim.lsp.config('cssmodules_ls', {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact" },
})

vim.lsp.config('emmet_language_server', {
  filetypes = {
    "html",
    "css",
    "javascriptreact",
    "typescriptreact",
    "sass",
    "scss",
    "less",
    "svelte",
    "vue",
    "astro"
  },
})

vim.lsp.config('ts_ls', {})

vim.lsp.config('html', {
  filetypes = { 'html', 'templ' },
  single_file_support = true,
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
})

vim.lsp.config('astro', {})

vim.lsp.config('pyright', {})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" } -- сообщаем серверу о глобале
      },
      -- Дополнительно: подсказки для Neovim API (опционально, но полезно)
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,  -- стандартные библиотеки Neovim
          '${3rd}/luv/library' -- для vim.uv.* функций
        },
        checkThirdParty = false
      }
    }
  }
})

-- Включаем все серверы
vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "emmet_language_server",
  "cssls",
  "cssmodules_ls",
  "html",
  "astro",
  "pyright"
})
