-- ~/.config/nvim/lua/plugins/cmp.lua
local M = {}

function M.setup()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    vim.notify("nvim-cmp not installed", vim.log.levels.WARN)
    return
  end

  local luasnip_status_ok, luasnip = pcall(require, "luasnip")
  if luasnip_status_ok then
    require("luasnip.loaders.from_vscode").lazy_load()
  end

  local lspkind_status_ok, lspkind = pcall(require, "lspkind")
  if not lspkind_status_ok then
    vim.notify("lspkind not installed", vim.log.levels.WARN)
  end

  -- Completion item icons
  local kind_icons = {
    Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
    Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
    Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
    Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
    File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
    Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
    TypeParameter = "󰊄"
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        if luasnip_status_ok then
          luasnip.lsp_expand(args.body)
        end
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      
      -- Улучшенное поведение Enter для CSS и других языков
      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }
          local entry = cmp.get_selected_entry()
          
          -- Для сниппетов используем Insert поведение
          if entry and entry.source.name == 'luasnip' then
            confirm_opts.behavior = cmp.ConfirmBehavior.Insert
          end
          
          cmp.confirm(confirm_opts)
          
          -- Автоматически пытаемся раскрыть сниппет
          if luasnip_status_ok then
            vim.defer_fn(function()
              if luasnip.expandable() then
                luasnip.expand()
              end
            end, 10)
          end
        else
          fallback()
        end
      end),
      
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      
      -- Улучшенная навигация Tab/S-Tab
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          -- Если выбран сниппет, подтверждаем и раскрываем
          if entry and entry.source.name == 'luasnip' then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            })
            if luasnip_status_ok then
              vim.defer_fn(function()
                if luasnip.expandable() then
                  luasnip.expand()
                end
              end, 10)
            end
          else
            cmp.select_next_item()
          end
        elseif luasnip_status_ok and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_status_ok and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    }),

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if lspkind_status_ok then
          return lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(_, item)
              item.kind = string.format('%s %s', kind_icons[item.kind] or '?', item.kind)
              return item
            end
          })(entry, vim_item)
        else
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '?', vim_item.kind)
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

    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  -- Command line completion
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = 'buffer' }}
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {{ name = 'path' }},
      {{ name = 'cmdline' }}
    )
  })

  -- Language-specific configurations
  cmp.setup.filetype({'css', 'scss', 'sass'}, {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  cmp.setup.filetype('html', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  print("nvim-cmp configuration loaded successfully")
end

return M

