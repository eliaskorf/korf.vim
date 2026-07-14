return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      python = { "black" },
      php = { "php_cs_fixer" }, -- В conform название форматировщика пишется через подчеркивание!
    },
    -- Кастомная настройка для PHP форматировщика
    formatters = {
      php_cs_fixer = {
        command = "php-cs-fixer",
        args = { "fix", "$FILENAME", "--quiet" },
        stdin = false,
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
