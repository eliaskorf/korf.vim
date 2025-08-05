-- ~/.config/nvim/lua/modules/llm/config.lua

local M = {}

M.default_settings = {
  model = "qwen/qwen3-coder:free",
  timeout = 30000,
  buffer_width = 60,
  api_key_file = "/api/api_key.txt"
}

function M.get_api_key_path()
  return vim.fn.stdpath("config") .. M.default_settings.api_key_file
end

return M
