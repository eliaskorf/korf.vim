-- ~/.config/nvim/lua/plugins/cmp.lua
local M = {}

function M.setup()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    vim.notify("nvim-cmp not installed", vim.log.levels.WARN)
    return
  end

  local types_status_ok, types = pcall(require, "cmp.types")
  local has_custom_sorting = types_status_ok

  local luasnip_status_ok, luasnip = pcall(require, "luasnip")
  -- Не вызываем lazy_load здесь, так как это делается в основном конфиге LuaSnip
  -- if luasnip_status_ok then
  --   require("luasnip.loaders.from_vscode").lazy_load()
  -- end

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

  -- Пользовательская функция для понижения приоритета сниппетов LSP (например, Emmet)
  local function deprioritize_lsp_snippet(entry1, entry2)
    if not has_custom_sorting then return nil end
    if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
    if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
    return nil
  end

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
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace
      }),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
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

    -- Обновлённая сортировка с понижением приоритета сниппетов LSP
    sorting = {
      priority_weight = 2,
      comparators = {
        deprioritize_lsp_snippet, -- Наша пользовательская функция
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

  --  print("nvim-cmp configuration loaded successfully")
end

return M

