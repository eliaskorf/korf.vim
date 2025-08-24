-- ~/.config/nvim/lua/plugins/toggleterm.lua
local M = {}

-- Функция для настройки toggleterm
function M.setup()
  -- Защитная загрузка модуля
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    vim.notify("toggleterm.nvim not installed", vim.log.levels.WARN)
    return
  end

  -- Базовая настройка toggleterm
  toggleterm.setup {
    -- Размер терминала (может быть числом или функцией)
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    
    -- Горячая клавиша для переключения терминала
    -- Используем <C-\> как в руководстве
    open_mapping = [[<c-\>]],
    
    -- Скрывать номера строк в буфере терминала
    hide_numbers = true,
    
    -- Затемнять фон терминала
    shade_terminals = true,
    -- shading_factor = -30, -- Процент затемнения (по умолчанию -30)
    
    -- Начинать в режиме вставки
    start_in_insert = true,
    
    -- Применять маппинг в insert и terminal режимах
    insert_mappings = true,
    terminal_mappings = true,
    
    -- Сохранять размер терминала
    persist_size = true,
    -- Сохранять режим терминала (persist_mode = true по умолчанию)
    -- persist_mode = true,
    
    -- Направление по умолчанию для нового терминала
    direction = 'float', -- 'vertical', 'horizontal', 'tab', 'float'
    
    -- Закрывать окно терминала при выходе процесса
    close_on_exit = true,
    
    -- Использовать переменные окружения из env (false по умолчанию)
    -- clear_env = false,
    
    -- Оболочка по умолчанию (используем системную)
    -- shell = vim.o.shell,
    
    -- Автоматически прокручивать к последней строке вывода
    auto_scroll = true,
    
    -- Настройки для float терминала
    float_opts = {
      -- Тип границы
      border = 'curved', -- 'single', 'double', 'shadow', 'curved'
      -- Ширина и высота могут быть числами или функциями
      -- width = <value>,
      -- height = <value>,
      -- Позиция (row, col) может быть числом или функцией
      -- row = <value>,
      -- col = <value>,
      -- Прозрачность фона окна (0-100)
      winblend = 3,
      -- zindex = <value>, -- Порядок наложения окон
      -- Позиция заголовка
      title_pos = 'center', -- 'left', 'center', 'right'
    },
    
    -- Настройки винбара (экспериментальные)
    winbar = {
      enabled = false, -- Отключено по умолчанию
      -- name_formatter = function(term) return term.name end
    },
  }

  -- Функция для установки маппингов внутри терминала
  local function set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- Выход из режима терминала в нормальный режим Neovim
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    -- Альтернативный выход (удобно для быстрого набора)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    -- Навигация между окнами из режима терминала
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    -- Быстрый выход в нормальный режим и затем в навигацию окон
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end

  -- Применять эти маппинги ко всем буферам терминала
  -- Используем более точный паттерн из руководства
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = set_terminal_keymaps,
  })

--  print("toggleterm configured from plugins/toggleterm.lua")
end

M.setup()

return M
