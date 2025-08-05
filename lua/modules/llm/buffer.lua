-- ~/.config/nvim/lua/modules/llm/buffer.lua

local utils = require("modules.llm.utils")
local config = require("modules.llm.config")

local M = {}

function M.find_qwen_buffer()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(bufnr)
    if buf_name:match("Qwen Chat") then
      return bufnr
    end
  end
  return nil
end

function M.get_buffer_width(bufnr)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return vim.api.nvim_win_get_width(win) - 4
    end
  end
  return config.default_settings.buffer_width - 4
end

function M.update_buffer(bufnr, prompt, answer, new_buffer_created)
  local buffer_width = M.get_buffer_width(bufnr)
  if buffer_width < 20 then buffer_width = 20 end

  local timestamp = os.date("%H:%M:%S")
  local new_content = {
    "┌── Вопрос [" .. timestamp .. "]:",
  }

  local wrapped_prompt_lines = utils.wrap_text(prompt, buffer_width)
  for _, line in ipairs(wrapped_prompt_lines) do
    table.insert(new_content, "│ " .. line)
  end

  table.insert(new_content, "├── Ответ:")

  local answer_lines = {}
  for line in answer:gmatch("([^\n]*)\n?") do
    local wrapped_lines = utils.wrap_text(line, buffer_width)
    for _, wrapped_line in ipairs(wrapped_lines) do
      table.insert(answer_lines, wrapped_line)
    end
  end

  for _, line in ipairs(answer_lines) do
    table.insert(new_content, "│ " .. line)
  end

  local separator_width = math.max(buffer_width + 2, 20)
  local separator = {"└" .. string.rep("─", separator_width - 2), ""}

  local current_lines = {}
  if not new_buffer_created then
    current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  end

  local all_lines = {}
  for _, line in ipairs(current_lines) do
    table.insert(all_lines, line)
  end

  for _, line in ipairs(new_content) do
    table.insert(all_lines, line)
  end

  for _, line in ipairs(separator) do
    table.insert(all_lines, line)
  end

  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, all_lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
end

function M.setup_buffer(bufnr, new_buffer_created)
  if new_buffer_created then
    vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(bufnr, "buflisted", true)
    vim.api.nvim_buf_set_name(bufnr, "Qwen Chat")
    vim.api.nvim_buf_set_option(bufnr, "readonly", true)
    vim.api.nvim_buf_set_option(bufnr, "syntax", "markdown")
  end
end

function M.open_buffer_window(bufnr, new_buffer_created)
  if new_buffer_created then
    vim.api.nvim_command("botright vsplit")
    local new_winnr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(new_winnr, bufnr)
    vim.api.nvim_win_set_width(new_winnr, config.default_settings.buffer_width)
  else
    local win_found = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == bufnr then
        vim.api.nvim_set_current_win(win)
        win_found = true
        break
      end
    end

    if not win_found then
      vim.api.nvim_command("botright vsplit")
      local new_winnr = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(new_winnr, bufnr)
      vim.api.nvim_win_set_width(new_winnr, config.default_settings.buffer_width)
    end
  end
end

return M
