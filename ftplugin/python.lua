-- ~/.config/nvim/ftplugin/python.lua
if vim.bo.filetype ~= "python" then return end
--
bo = vim.bo
-- Buffer-local options (буферные настройки)
bo.tabstop = 4
bo.shiftwidth = 4
bo.softtabstop = 4
bo.expandtab = true
bo.smartindent = true
bo.textwidth = 88  -- PEP-8 recommendation

-- Window-local options (оконные настройки)
vim.wo.colorcolumn = "89"  -- Линия для PEP-8

-- Keymaps (только для Python-файлов)
vim.keymap.set('n', '<leader>r', ':!python %<CR>', { buffer = true, desc = "Run Python file" })
