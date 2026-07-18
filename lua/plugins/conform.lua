return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  keys = {
    {
      "<leader>F",
      function()
        local lsp_format_languages = { lua = true }
        require("conform").format({
          async = true,
          -- Копируем ту же безопасную логику, что и в автосохранении:
          lsp_fallback = lsp_format_languages[vim.bo.filetype] and "always" or false
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },

  opts = {
    formatters_by_ft = {
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      css = { "biome", "prettier", stop_after_first = true },
      html = { "biome", "prettier", stop_after_first = true },

      svelte = { "prettier" },
      scss = { "prettier" },
      python = { "black" },
      php = { "php_cs_fixer" }, -- Исправлено: приведено к системному имени через подчёркивание
      -- lua = { "lsp" },          -- Конфиги nvim форматируем нативным lua_ls
    },

    formatters = {
      php_cs_fixer = { -- Исправлено: имя секции теперь совпадает со списком выше
        command = "php-cs-fixer",
        args = { "fix", "$FILENAME", "--quiet" },
        stdin = false,
      },
    },


    format_on_save = function(bufnr)
      -- Отдельно указываем, для каких языков использовать нативный LSP как форматировщик
      local lsp_format_languages = { lua = true }

      return {
        timeout_ms = 500,
        -- Если язык есть в списке (lua), форматируем через LSP.
        -- Для остальных (веб-стек) используем только CLI утилиты (biome/prettier), чтобы избежать гонки процессов.
        lsp_fallback = lsp_format_languages[vim.bo[bufnr].filetype] and "always" or false,
      }
    end,

  },
}
