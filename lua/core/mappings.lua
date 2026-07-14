local km = vim.keymap

vim.g.mapleader = " "

-- NeoTree
km.set('n', '<leader>e', ':Neotree float focus<CR>')

km.set("n", "<C-v>", '"+p') -- нормальный paste
