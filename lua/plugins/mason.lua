-- ~/.config/nvim/lua/plugins/mason.lua
return {
  "williamboman/mason.nvim",
  lazy = false,
  priority = 1000,
  build = ":MasonUpdate",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig", -- lspconfig теперь нужен только как база данных дефолтных настроек языков
  },

  config = function()
    -- 1. Настройка интерфейса Mason
    require("mason").setup({
      ui = {
        border = "rounded",
        check_outdated_packages_on_open = true,
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    })

    -- Список ваших серверов
    local servers = {
      "lua_ls",
      "ts_ls",
      "emmet_language_server",
      "cssls",
      "cssmodules_ls",
      "html",
      "astro",
      "pyright"
    }

    -- 2. Автоустановка серверов через Mason
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- 3. Нативная активация серверов в стиле Neovim 0.11/0.12 (БЕЗ использования устаревшего lspconfig фреймворка)
    -- Глобально настраиваем автоматическое включение inlay hints для всех LSP бафферов
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
      end,
    })

    -- Кастомная нативная настройка для Lua (убираем ворнинг 'vim')
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- Активируем каждый сервер встроенным методом Neovim
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    -- 4. Автоматическая установка линтеров и форматировщиков (не-LSP)
    local mr = require("mason-registry")
    local tools = { "prettier", "eslint_d", "black", "flake8", "php-cs-fixer", "phpstan" }

    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    -- 5. Добавляем пути к бинарникам Mason в PATH Neovim
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
  end,
}
