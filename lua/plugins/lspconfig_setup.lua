-- ~/.config/nvim/lua/plugins/lspconfig_setup.lua
-- Основная конфигурация для nvim-lspconfig и связанных настроек LSP

-- Загружаем необходимые модули с проверкой ошибок
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify("Ошибка: Не удалось загрузить nvim-lspconfig!", vim.log.levels.ERROR)
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  vim.notify("Ошибка: Не удалось загрузить mason-lspconfig!", vim.log.levels.ERROR)
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  vim.notify("Предупреждение: Не удалось загрузить cmp_nvim_lsp! Автодополнение от LSP может не работать.", vim.log.levels.WARN)
  -- Мы не делаем return здесь, чтобы LSP все равно настроился, но без автодополнения
end

local util = require('lspconfig.util') -- Утилиты lspconfig, например, для root_dir

-- ============================================================================
-- ОБЩАЯ ФУНКЦИЯ ON_ATTACH
-- Эта функция будет выполняться КАЖДЫЙ РАЗ, когда LSP-сервер успешно
-- подключается к буферу файла. Здесь удобно определять общие для всех
-- LSP серверов сочетания клавиш.
-- ============================================================================
local on_attach = function(client, bufnr)
  -- Включение автодополнения через omnifunc (стандартный механизм Vim)
  -- vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Обычно не нужно при использовании nvim-cmp

  local map = vim.keymap.set
  -- Определяем опции для маппингов: только для этого буфера, без ремапа, тихо
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- --- Стандартные LSP маппинги ---
  -- Навигация и информация
  map('n', 'K', vim.lsp.buf.hover, opts)               -- Показать документацию под курсором
  map('n', 'gd', vim.lsp.buf.definition, opts)         -- Перейти к определению
  map('n', 'gD', vim.lsp.buf.declaration, opts)        -- Перейти к объявлению
  map('n', 'gi', vim.lsp.buf.implementation, opts)     -- Перейти к реализации
  map('n', 'gr', vim.lsp.buf.references, opts)         -- Показать все использования символа
  -- map('n', 'gt', vim.lsp.buf.type_definition, opts) -- Перейти к определению типа (если нужно)

  -- Работа с кодом
  map('n', '<leader>lrn', vim.lsp.buf.rename, opts)       -- Переименовать символ (:Rename)
  map({'n', 'v'}, '<leader>lca', vim.lsp.buf.code_action, opts) -- Показать доступные действия (Code Actions)

  -- Работа с диагностиками (ошибками/предупреждениями)
  map('n', '<leader>le', vim.diagnostic.open_float, opts) -- Показать диагностику под курсором
  map('n', '[d', vim.diagnostic.goto_prev, opts)         -- Перейти к предыдущей диагностике
  map('n', ']d', vim.diagnostic.goto_next, opts)         -- Перейти к следующей диагностике
  map('n', '<leader>ld', vim.diagnostic.setloclist, opts) -- Показать все диагностики в location list

  -- (Опционально) Форматирование через LSP (если сервер поддерживает)
  if client.server_capabilities.documentFormattingProvider then
    map('n', '<leader>lf', function() vim.lsp.buf.format { async = true, timeout_ms = 2000 } end, opts) -- Форматировать буфер
    -- Можно добавить форматирование для визуального режима
    -- map('v', '<leader>lf', function() vim.lsp.buf.format { async = true, timeout_ms = 2000 } end, opts)
  end

  -- (Опционально) Подсветка ссылок на символ под курсором
  if client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true }) -- clear = true безопаснее
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, { group = highlight_augroup, buffer = bufnr, callback = vim.lsp.buf.document_highlight, })
    vim.api.nvim_create_autocmd("CursorMoved", { group = highlight_augroup, buffer = bufnr, callback = vim.lsp.buf.clear_references, })
  end

  -- Сообщение о подключении (для отладки)
  -- vim.notify("LSP '".. client.name .."' attached to buffer " .. bufnr, vim.log.levels.INFO)
end

-- ============================================================================
-- НАСТРОЙКА CAPABILITIES
-- Получаем стандартные capabilities от Neovim и добавляем те, что нужны
-- для nvim-cmp (если он загружен).
-- ============================================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- --- >>> ДОБАВЛЕНА ОТЛАДКА <<< ---
if cmp_nvim_lsp_ok then
  -- **ВАЖНО:** Дополняем capabilities из cmp_nvim_lsp.
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  print("[LSP Setup] CMP Capabilities applied successfully!") -- Сообщение об успехе
else
  print("[LSP Setup] WARN: cmp_nvim_lsp not loaded, capabilities may be incomplete for nvim-cmp.") -- Предупреждение
end
-- --- >>> КОНЕЦ ОТЛАДКИ <<< ---

-- (Опционально) Если используешь inlay-hints, добавь его capabilities
-- local inlay_hints_ok, inlay_hints_caps = pcall(require, 'inlay-hints.capabilities')
-- if inlay_hints_ok then capabilities = inlay_hints_caps.merge(capabilities) end

-- ============================================================================
-- НАСТРОЙКА СЕРВЕРОВ
-- Используем mason-lspconfig для получения списка установленных серверов
-- и настраиваем каждый из них с помощью nvim-lspconfig.
-- ============================================================================

-- Получаем список имен серверов, установленных через Mason
local servers = mason_lspconfig.get_installed_servers()

print("[LSP Setup] Found installed servers: " .. vim.inspect(servers)) -- Добавим вывод списка серверов

-- Проходим по списку серверов и настраиваем каждый
for _, server_name in ipairs(servers) do
  print("[LSP Setup] Configuring server: " .. server_name) -- Отладочное сообщение

  -- Определяем базовые (общие) настройки для каждого сервера
  local server_opts = {
    on_attach = on_attach,       -- Наша общая функция on_attach для маппингов
    capabilities = capabilities, -- Наши общие capabilities (включая для nvim-cmp)
  }

  -- --- СПЕЦИАЛЬНЫЕ НАСТРОЙКИ ДЛЯ КОНКРЕТНЫХ СЕРВЕРОВ ---
  -- Здесь можно переопределить или добавить настройки для конкретных серверов.
  if server_name == 'lua_ls' then
    server_opts.settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = {'vim'} },
        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  elseif server_name == 'ts_ls' then
    -- Определяем корень проекта для JS/TS
    server_opts.root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
    -- Дополнительные настройки для tsserver (если нужны)
    -- server_opts.settings = { tsserver = { ... } }
  elseif server_name == 'pyright' then
    -- Можно добавить настройки для Pyright, например, указать окружение
    -- server_opts.settings = { python = { pythonPath = "/path/to/venv/bin/python" } }
  elseif server_name == 'intelephense' then
     -- Можно добавить ключ лицензии для платных функций
     -- server_opts.settings = { intelephense = { licenceKey = "YOUR_LICENSE_KEY" } }
  end
  -- Добавь другие `elseif` для специфичных настроек других серверов по мере необходимости

  -- --- Вызываем setup для сервера с отладкой ---
  print("[LSP Setup] > Calling setup for " .. server_name) -- Отладочное сообщение
  local setup_ok, err = pcall(lspconfig[server_name].setup, server_opts) -- Вызываем setup безопасно
  if not setup_ok then
      print("[LSP Setup] !! ERROR setting up " .. server_name .. ": " .. tostring(err)) -- Сообщение об ошибке
  end
  -- --- Конец отладки ---
end

print("LSP servers configuration loop finished from lspconfig_setup.lua") -- Финальное сообщение
