-- ~/.config/nvim/lua/modules/llm/api.lua

local curl = require("plenary.curl")

local M = {}

function M.send_request(prompt, api_key)
  vim.notify("Отправка запроса к Qwen...", vim.log.levels.INFO)

  local response = curl.post("https://openrouter.ai/api/v1/chat/completions", {
    body = vim.json.encode({
      model = "qwen/qwen3-coder:free",
      messages = {
        { role = "user", content = prompt }
      }
    }),
    headers = {
      ["Authorization"] = "Bearer " .. api_key,
      ["Content-Type"] = "application/json"
    },
    timeout = 30000
  })

  if not response or response.status ~= 200 then
    vim.notify("Ошибка при запросе к Qwen: " .. (response and response.status or "неизвестно"), vim.log.levels.ERROR)
    return nil
  end

  local data = vim.json.decode(response.body)

  if not data or not data.choices or not data.choices[1] or not data.choices[1].message or not data.choices[1].message.content then
    vim.notify("Ответ от Qwen некорректен", vim.log.levels.WARN)
    return nil
  end

  return data.choices[1].message.content
end

return M
