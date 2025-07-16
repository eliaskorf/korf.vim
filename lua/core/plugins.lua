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

    -- ------------------------------------------------------------------------
    -- UI Plugins: Themes, Status Lines, Dashboard, Bufferline
    -- ------------------------------------------------------------------------

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

    -- Optional icon plugin with fallback if devicons missing
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

    -- Which-key menu for mapping discovery
    { 'folke/which-key.nvim' },

    -- ------------------------------------------------------------------------
    -- Navigation & Search
    -- ------------------------------------------------------------------------

    -- Telescope fuzzy finder
    { 'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- File explorer with image preview support
    { 'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        '3rd/image.nvim', -- Optional image support
      },
    },


    -- This plugin adds indentation guides to Neovim.
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      ---@module "ibl"
      ---@type ibl.config
      opts = {},
    },
    -- ------------------------------------------------------------------------
    -- Built-in Terminal
    -- ------------------------------------------------------------------------
    { 'akinsho/toggleterm.nvim',
      version = '*',
      config = true,
    },

    -- ------------------------------------------------------------------------
    -- Syntax Highlighting and Treesitter
    -- ------------------------------------------------------------------------
    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },

    -- ------------------------------------------------------------------------
    -- LSP Configuration
    -- ------------------------------------------------------------------------
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'simrat39/inlay-hints.nvim' },

    -- ------------------------------------------------------------------------
    -- Autocompletion
    -- ------------------------------------------------------------------------
--    { 'hrsh7th/nvim-cmp' },
--    { 'hrsh7th/cmp-nvim-lsp' },
--    { 'hrsh7th/cmp-buffer' },
--    { 'hrsh7th/cmp-path' },
--    { 'hrsh7th/cmp-cmdline' },

----




{
  'hrsh7th/nvim-cmp',
  event = "VeryLazy",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip',
    'onsails/lspkind.nvim'
  },
  -- >>> ВОЗВРАЩАЕМ ПОЛНУЮ КОНФИГУРАЦИЮ <<<
  config = function()
    -- Безопасно загружаем cmp и lspkind
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then vim.notify("Ошибка: Не удалось загрузить nvim-cmp в config!", vim.log.levels.ERROR); return end
    local lspkind_ok, lspkind = pcall(require, "lspkind")
    if not lspkind_ok then vim.notify("Предупреждение: Не удалось загрузить lspkind для nvim-cmp.", vim.log.levels.WARN) end

    local kind_icons = { Text = "", Method = "󰆧", Function = "󰊕", Constructor = "", Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "", Module = "", Property = "󰜢", Unit = "", Value = "󰎠", Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘", File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "", Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕", TypeParameter = "󰊄", }

    cmp.setup({
      snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
      },
      mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() elseif vim.fn["vsnip#available"](1) == 1 then vim.fn["vsnip#expand"]() else fallback() end end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() elseif vim.fn["vsnip#jumpable"](-1) == 1 then vim.fn["vsnip#jump"](-1) else fallback() end end, { "i", "s" }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' }, { name = 'vsnip' }, { name = 'buffer' }, { name = 'path' },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Загружаем lspkind здесь для надежности
          local lspkind_formating_ok, lspkind = pcall(require, "lspkind")
          if lspkind_formating_ok then
            return lspkind.cmp_format({
              mode = "symbol_text", maxwidth = 50, ellipsis_char = '...',
              before = function (entry, item)
                item.kind = string.format('%s %s', kind_icons[item.kind] or '?', item.kind)
                return item
              end
            })(entry, vim_item)
          else
            vim_item.kind = string.format('%s', vim_item.kind) -- Fallback без иконок
            return vim_item
          end
        end
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      experimental = {
        ghost_text = true,
      },
    })

    -- Настройка cmdline
    cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
    cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }) })

    print("ПОЛНАЯ конфигурация nvim-cmp УСПЕШНО загружена (встроена в plugins.lua)")
  end,
  -- >>> КОНЕЦ ИЗМЕНЕНИЙ <<<
},




----

    -- ------------------------------------------------------------------------
    -- Git Integration
    -- ------------------------------------------------------------------------
    { 'lewis6991/gitsigns.nvim' },

    -- ------------------------------------------------------------------------
    -- Quality of Life Plugins
    -- ------------------------------------------------------------------------
    { 'windwp/nvim-autopairs' },
    { 'windwp/nvim-ts-autotag' },
    { 'terrortylor/nvim-comment' },

  },

  -- Default colorscheme when installing (optional)
  install = { colorscheme = { "kanagawa" } },

  -- Enable auto-checking for plugin updates
  checker = { enabled = true },
})
