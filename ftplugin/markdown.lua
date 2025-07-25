if vim.bo.filetype ~= "markdown" then return end

wo = vim.wo
bo = vim.bo

-- Window options
wo.wrap = true
wo.linebreak = true
wo.spell = true

-- Buffer options
bo.tabstop = 2
bo.shiftwidth = 2
bo.expandtab = true

-- Keymaps
vim.keymap.set('n', '<leader>p', ':MarkdownPreview<CR>', { buffer = true, desc = "Preview Markdown" })
