-- Пример функции для создания новой заметки
vim.api.nvim_create_user_command('NewNote', function(opts)
  local title = opts.args or 'Untitled'
  local date = os.date('%Y-%m-%d')
  local template = string.gsub([[
---
title: "%s"
tags: []
created: %s
---

# %s

]], '%%s', title):gsub('%%s', date)

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, '\n'))
end, { nargs = '?' })
