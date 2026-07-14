return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    -- 🔑 Все ваши горячие клавиши теперь безопасно обёрнуты для Lazy.
    -- Neovim не будет вызывать 'telescope.builtin' при старте, пока вы не нажмете кнопку.
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = "Find Files" },
        { '<leader>fw', function() require('telescope.builtin').live_grep() end, desc = "Live Grep" },
        { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = "Buffers" },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
        { '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = "Git Branches" },
        { '<leader>gs', function() require('telescope.builtin').git_status() end, desc = "Git Status" },
        { '<leader>ls', function() require('telescope.builtin').lsp_document_symbols() end, desc = "LSP Document Symbols" },
        { 'gr', function() require('telescope.builtin').lsp_references() end, { noremap = true, silent = true, desc = "LSP References" } },
        { 'gd', function() require('telescope.builtin').lsp_definitions() end, { noremap = true, silent = true, desc = "LSP Definitions" } },
    },
    config = function()
        -- Настройки самого плагина (запускаются автоматически после его загрузки)
        require('telescope').setup({
            defaults = {
                -- Здесь в будущем можно настроить внешний вид окон
            }
        })
    end
}