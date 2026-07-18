return {
  "williamboman/mason.nvim",
  lazy = false,
  priority = 1000,
  build = ":MasonUpdate",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp", -- Добавлено: необходимо для автодополнения
  },

  config = function()
    -- ОБЯЗАТЕЛЬНО: подгружаем lspconfig, чтобы Neovim узнал шаблоны запуска серверов
    require("lspconfig")

    -- 1. Настройка интерфейса Mason
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    })

    -- Список серверов (используем строгие системные имена nvim-lspconfig)
    local servers = {
      "lua_ls",
      "ts_ls",
      "emmet_language_server",
      "cssls",
      "html",
      "astro",
      "pyright",
      "biome"
    }

    -- 2. Автоустановка серверов через Mason
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- 3. Интеграция возможностей (Capabilities) с автодополнением nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_lsp_ok then
      capabilities = cmp_nvim_lsp.default_capabilities()
    end

    capabilities.general = {
      positionEncodings = { "utf-16" }
    }

    -- Настраиваем глобальные параметры для ВСЕХ нативных серверов
    vim.lsp.config("*", {
      capabilities = capabilities,
      -- Автоматическое включение inlay hints для всех поддерживающих это серверов
      on_attach = function(client, bufnr)
        if client and client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end,
    })

    -- 4. Кастомные конфигурации конкретных серверов
    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    vim.lsp.config("emmet_language_server", {
      filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte", "astro" },
    })

    vim.lsp.config("biome", {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "css", "html" },
      -- ДОБАВЛЯЕМ ЭТУ СТРОКУ: принудительно выставляем UTF-16 для синхронизации
      offset_encoding = "utf-16",
      -- ОТКЛЮЧАЕМ форматирование в Biome-LSP, так как за него отвечает conform.nvim
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    })

    -- 5. Чистая нативная активация серверов силами ядра Neovim (с фиксом кодировки для Biome)
    for _, server in ipairs(servers) do
      if server == "biome" then
        vim.lsp.enable("biome", {
          capabilities = {
            offsetEncoding = { "utf-16" },
            positionEncodings = { "utf-16" }
          }
        })
      else
        vim.lsp.enable(server)
      end
    end

    -- 6. Автоматическая установка внешних инструментов (линтеры/форматтеры)
    local mr = require("mason-registry")
    local tools = {
      "prettier",
      "eslint_d",
      "black",
      "flake8",
      "php-cs-fixer",
      "phpstan",
      "htmlhint",
      "stylelint"
    }

    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    -- 7. Добавляем пути к бинарникам Mason в PATH Neovim
    vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
  end,
}
