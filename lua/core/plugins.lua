-- ============================================================================
-- lazy.nvim Bootstrap and Plugin Setup
-- Eli's Neovim Config (clean, structured, well-commented)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================================
-- Plugin Setup with lazy.nvim
-- ============================================================================
require("lazy").setup({
  spec = {
    -- 🎨 UI & THEMING
    { 'rebelot/kanagawa.nvim' },
    { 'glepnir/dashboard-nvim', event = 'VimEnter', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'akinsho/bufferline.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', 'linrongbin16/lsp-progress.nvim' } },
    { 'echasnovski/mini.icons',
      opts = {},
      lazy = true,
      specs = { { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true } },
      init = function()
        package.preload["nvim-web-devicons"] = function()
          require("mini.icons").mock_nvim_web_devicons()
          return package.loaded["nvim-web-devicons"]
        end
      end,
    },
    { 'folke/which-key.nvim' },
    { 'stevearc/dressing.nvim', opts = {} },

    -- 🚀 NAVIGATION & SEARCH
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim', '3rd/image.nvim' },
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { 'akinsho/toggleterm.nvim', version = '*', config = true },

    -- 🧠 LANGUAGE SUPPORT & LSP
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'simrat39/inlay-hints.nvim' },

    -- ✨ AUTOCOMPLETION & SNIPPETS
    { 'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        print("LuaSnip configured with friendly-snippets")
      end
    },
    { 'hrsh7th/nvim-cmp',
      event = "VeryLazy",
      dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'saadparwaiz1/cmp_luasnip', 'onsails/lspkind.nvim' },
      config = function()
        local status_ok, cmp_plugin = pcall(require, "plugins.cmp")
        if status_ok then
          cmp_plugin.setup()
        else
          vim.notify("Failed to load cmp plugin config", vim.log.levels.ERROR)
        end
      end,
    },

    -- 🎨 VISUAL ENHANCEMENTS
    { 'NvChad/nvim-colorizer.lua',
      event = "BufReadPre",
      config = function()
        local status_ok, colorizer_plugin = pcall(require, "plugins.colorizer")
        if status_ok then
          colorizer_plugin.setup()
        else
          vim.notify("Failed to load colorizer plugin config", vim.log.levels.ERROR)
        end
      end,
    },
    { 'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
      opts = {},
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "echasnovski/mini.icons" },
      opts = {}
    },
    {
      "saxon1964/neovim-tips",
      version = "*", -- Only update on tagged releases
      dependencies = { 
        "ibhagwan/fzf-lua", 
        "MeanderingProgrammer/render-markdown.nvim" 
      },
      opts = {
        -- OPTIONAL: Location of user defined tips (default value shown below)
        user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
        -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
        user_tip_prefix = "[User] ",
        -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
        warn_on_conflicts = true,
      },
      init = function()
        -- OPTIONAL: Change to your liking or drop completely 
        -- The plugin does not provide default key mappings, only commands
        local map = vim.keymap.set
        map("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips", noremap = true, silent = true })
        map("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", noremap = true, silent = true })
        map("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", noremap = true, silent = true })
        map("n", "<leader>nth", ":NeovimTipsHelp<CR>", { desc = "Neovim tips user guide", noremap = true, silent = true })
      end
    },

    -- 🛠️ DEVELOPMENT TOOLS
    { 'phaazon/mind.nvim',
      branch = 'v2.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('mind').setup({
          icon = '🧠',
          indent = 2,
          signs = { ADD = '+', DELETE = '-', CHANGE = '~' },
        })
      end
    },
    { 'lewis6991/gitsigns.nvim' },
    { 'windwp/nvim-autopairs' },
    { 'windwp/nvim-ts-autotag' },
    { 'terrortylor/nvim-comment' },

    -- ✅ Avante plugin - ИСПРАВЛЕННЫЙ КОНФИГ
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      -- build не нужен для OpenRouter, только для локальных моделей
      opts = {
        -- Указываем провайдера
        provider = "openrouter",
        -- Отладка (раскомментируй при необходимости)
        -- debug = true,
        -- log_level = "debug",

        -- Настройки провайдеров
        providers = {
          openrouter = {
            -- Наследуемся от OpenAI, так как OpenRouter совместим с их API
            __inherited_from = "openai",
            -- Базовая точка входа
            endpoint = "https://openrouter.ai/api/v1",
            -- Имя переменной окружения с API ключом
            api_key_name = "OPENROUTER_API_KEY",
            -- Модель для использования
            model = "qwen/qwen3-coder:free",
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- Остальные зависимости по желанию, но эти обязательны
        -- "nvim-telescope/telescope.nvim", -- если используешь Telescope
        -- "echasnovski/mini.pick", -- альтернатива Telescope
        -- "hrsh7th/nvim-cmp", -- для автодополнения
      },
    },
  },

  install = { colorscheme = { "kanagawa" } },
  checker = { enabled = true },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = { reset = true },
  },
})
