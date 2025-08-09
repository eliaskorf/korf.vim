-- ~/.config/nvim/lua/plugins/colorizer.lua
local M = {}

-- Функция для настройки nvim-colorizer
function M.setup()
  -- Защитная загрузка модуля
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    vim.notify("nvim-colorizer.lua not installed", vim.log.levels.WARN)
    return
  end

  -- Настройка плагина
  colorizer.setup {
    -- Глобальные настройки по умолчанию для всех типов файлов
    user_default_options = {
      RGB      = true,         -- #RGB hex codes
      RRGGBB   = true,         -- #RRGGBB hex codes
      names    = true,         -- "Name" codes like Blue or blue
      RRGGBBAA = true,         -- #RRGGBBAA hex codes
      AARRGGBB = false,        -- 0xAARRGGBB hex codes
      rgb_fn   = true,         -- CSS rgb() and rgba() functions
      hsl_fn   = true,         -- CSS hsl() and hsla() functions
      css      = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn   = true,         -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background, virtualtext
      mode     = "background", -- Set the display mode. (background по умолчанию)
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = false,        -- Enable tailwind colors, можно установить в false если не нужно
      sass     = { enable = true, parsers = { "css" }, }, -- Enable sass colors
      -- virtualtext = "■■■",  -- Текст для virtualtext режима
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false    -- Не обновлять цвета в неактивных буферах/окнах
    },
    -- Настройки для конкретных типов файлов (раскомментируйте и измените при необходимости)
    -- filetypes = {
    --   -- Для этих типов файлов будут использоваться user_default_options
    --   "css", "scss", "sass", "html", "javascript", "typescript", "vue", "svelte"
    -- },
    -- buftypes = {}, -- Настройки для конкретных типов буферов
  }

  -- Автоматически подключить colorizer к новым буферам
  -- Это не обязательно, если вы используете `filetypes` в setup,
  -- но может быть полезно для динамического подключения.
  -- vim.api.nvim_create_augroup("ColorizerSetup", { clear = true })
  -- vim.api.nvim_create_autocmd("BufEnter", {
  --   group = "ColorizerSetup",
  --   pattern = { "*.css", "*.scss", "*.sass", "*.html", "*.js", "*.ts", "*.vue", "*.svelte" },
  --   callback = function()
  --     require("colorizer").attach_to_buffer(0)
  --   end,
  -- })

  --  print("nvim-colorizer configured from plugins/colorizer.lua")
end

return M

