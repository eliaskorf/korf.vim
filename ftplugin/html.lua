if vim.bo.filetype ~= "html" then return end

bo = vim.bo

-- Buffer options
bo.tabstop = 2
bo.shiftwidth = 2
bo.expandtab = true
bo.autoindent = true

-- Keymaps
vim.keymap.set('n', '<leader>o', ':!open %<CR>', { buffer = true, desc = "Open in browser" })
