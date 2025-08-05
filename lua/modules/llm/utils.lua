-- ~/.config/nvim/lua/modules/llm/utils.lua

local M = {}

function M.wrap_text(text, width)
  if #text <= width then
    return {text}
  end
  
  local lines = {}
  local current_line = ""
  
  for word in text:gmatch("%S+") do
    if #current_line + #word + 1 <= width then
      if current_line == "" then
        current_line = word
      else
        current_line = current_line .. " " .. word
      end
    else
      if current_line ~= "" then
        table.insert(lines, current_line)
        current_line = word
      else
        if #word > width then
          local start_pos = 1
          while start_pos <= #word do
            local end_pos = math.min(start_pos + width - 1, #word)
            table.insert(lines, word:sub(start_pos, end_pos))
            start_pos = end_pos + 1
          end
        else
          current_line = word
        end
      end
    end
  end
  
  if current_line ~= "" then
    table.insert(lines, current_line)
  end
  
  return lines
end

function M.load_api_key(key_path)
  if vim.fn.filereadable(key_path) == 1 then
    local key = vim.fn.readfile(key_path)[1]
    return key and key:gsub("^%s*(.-)%s*$", "%1") or nil
  end
  return nil
end

return M
