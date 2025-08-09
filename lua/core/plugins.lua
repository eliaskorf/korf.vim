-- ~/.config/nvim/lua/core/plugins.lua
-- ============================================================================
-- lazy.nvim Bootstrap and Plugin Setup
-- Eli's Neovim Config (clean, structured, and well-commented)
-- ============================================================================
-- Define path to lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- If lazy.nvim is not installed, clone it from GitHub
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
-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)
-- Set leader keys before any mappings or plugin loading
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- ============================================================================
-- Plugin Setup with lazy.nvim
-- ============================================================================
require("lazy").setup({
  spec = {
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- 🎨 UI & THEMING
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Color theme
    { 'rebelot/kanagawa.nvim' },
    -- Startup screen
    { 'glepnir/dashboard-nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- Buffer line
    { 'akinsho/bufferline.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- Status line
    { 'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'linrongbin16/lsp-progress.nvim'
      },
    },
    -- File icons with fallback support
    { 'echasnovski/mini.icons',
      opts = {},
      lazy = true,
      specs = {
        { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
      },
      init = function()
        package.preload["nvim-web-devicons"] = function()
          require("mini.icons").mock_nvim_web_devicons()
          return package.loaded["nvim-web-devicons"]
        end
      end,
    },
    -- Keybinding helper
    { 'folke/which-key.nvim' },
    -- UI enhancement for vim.ui.select and vim.ui.input
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- 🚀 NAVIGATION & SEARCH
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Fuzzy finder
    { 'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- File explorer with modern features
    { 'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        '3rd/image.nvim',
      },
    },
    -- Indentation guides
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {},
    },
    -- Integrated terminal
    { 'akinsho/toggleterm.nvim',
      version = '*',
      config = true,
    },
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- 🧠 LANGUAGE SUPPORT & LSP
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Syntax highlighting
    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },
    -- LSP management and configuration
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'simrat39/inlay-hints.nvim' },
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- ✨ AUTOCOMPLETION & SNIPPETS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Сначала объявляем LuaSnip с зависимостью от friendly-snippets
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        -- Загружаем сниппеты из VSCode (включая friendly-snippets) лениво
        require("luasnip.loaders.from_vscode").lazy_load()
        print("LuaSnip configured with friendly-snippets")
      end
    },
    -- Затем настраиваем nvim-cmp, который будет использовать LuaSnip
    {
      'hrsh7th/nvim-cmp',
      event = "VeryLazy",
      dependencies = {
        -- Completion sources
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- Snippet engine (теперь это зависимость от уже объявленного плагина)
        'saadparwaiz1/cmp_luasnip',
        -- Icons for completion items
        'onsails/lspkind.nvim'
      },
      config = function()
        -- Загружаем основную конфигурацию из отдельного файла
        local status_ok, cmp_plugin = pcall(require, "plugins.cmp")
        if status_ok then
          cmp_plugin.setup()
        else
          vim.notify("Failed to load cmp plugin config", vim.log.levels.ERROR)
        end
      end,
    },
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- 🎨 VISUAL ENHANCEMENTS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Colorizer for CSS, HTML, etc.
    {
      'NvChad/nvim-colorizer.lua',
      event = "BufReadPre", -- Загружать при открытии файла
      config = function()
        -- Загружаем и запускаем настройку из отдельного файла
        local status_ok, colorizer_plugin = pcall(require, "plugins.colorizer")
        if status_ok then
          colorizer_plugin.setup()
        else
          vim.notify("Failed to load colorizer plugin config", vim.log.levels.ERROR)
        end
      end,
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- 🛠️ DEVELOPMENT TOOLS
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Mind mapping tool
    {
      'phaazon/mind.nvim',
      branch = 'v2.2',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('mind').setup({
          icon = '🧠',
          indent = 2,
          signs = {
            ADD = '+',
            DELETE = '-',
            CHANGE = '~'
          }
        })
      end
    },
    -- Git integration
    { 'lewis6991/gitsigns.nvim' },
    -- Quality of life improvements
    { 'windwp/nvim-autopairs' },
    { 'windwp/nvim-ts-autotag' },
    { 'terrortylor/nvim-comment' },
  },
  -- Default colorscheme when installing
  install = { colorscheme = { "kanagawa" } },
  -- Enable auto-checking for plugin updates
  checker = { enabled = true },
  -- Performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
    },
  },
})

