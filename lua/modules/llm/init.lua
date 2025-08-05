-- ~/.config/nvim/lua/modules/llm/init.lua

local M = {}

-- Загружаем необходимые модули
local config = require("modules.llm.config")
local api_module = require("modules.llm.api")
local buffer_module = require("modules.llm.buffer")
local utils = require("modules.llm.utils")

-- Основная функция для работы с LLM
function M.ask_llm(prompt)
  if prompt == "" then
    vim.notify("Пожалуйста, введите запрос. Пример: :LLM Напиши функцию на Python", vim.log.levels.WARN)
    return
  end

  local api_key_path = config.get_api_key_path()
  local api_key = utils.load_api_key(api_key_path)

  if not api_key then
    vim.notify("API ключ не найден! Создайте файл " .. api_key_path, vim.log.levels.ERROR)
    return
  end

  local answer = api_module.send_request(prompt, api_key)
  if not answer then return end

  local bufnr = buffer_module.find_qwen_buffer()
  local new_buffer_created = false

  if not bufnr then
    bufnr = vim.api.nvim_create_buf(false, true)
    new_buffer_created = true
  end

  buffer_module.setup_buffer(bufnr, new_buffer_created)
  buffer_module.update_buffer(bufnr, prompt, answer, new_buffer_created)
  buffer_module.open_buffer_window(bufnr, new_buffer_created)

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), {line_count, 0})

  vim.notify("Получен ответ от Qwen", vim.log.levels.INFO)
end

-- Создаем пользовательскую команду :LLM
function M.setup()
  vim.api.nvim_create_user_command("LLM", function(opts)
    M.ask_llm(opts.args)
  end, { nargs = "*" })
end

return M
