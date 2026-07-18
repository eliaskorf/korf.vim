local map = vim.keymap.set


vim.g.mapleader = " "

-- NeoTree
map('n', '<leader>e', ':Neotree float focus<CR>')

map("n", "<C-v>", '"+p') -- нормальный paste


-- ============================================================================
-- 🛠️ НАВИГАЦИЯ ПО ОШИБКАМ И ПОДСКАЗКАМ (LSP Diagnostic Keymaps)
-- ============================================================================

-- gl (go line) — показать детальный текст ошибки под курсором в плавающем окне
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- [d и ]d — прыгать по ошибкам в файле назад и вперед
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

-- <leader>q — открыть список ВСЕХ ошибок текущего проекта внизу экрана
map('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open project diagnostics list' })
