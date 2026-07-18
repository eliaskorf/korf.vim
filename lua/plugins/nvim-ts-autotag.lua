-- ~/.config/nvim/lua/plugins/autotag.lua
require('nvim-ts-autotag').setup({
  -- Можно добавить настройки, если нужно
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})

-- Новый способ настройки диагностики (Neovim 0.11+)
vim.diagnostic.config({
  underline = true,
  virtual_text = {
    spacing = 5,
    severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = true,
  severity_sort = true,
  float = { border = "rounded" },
})
