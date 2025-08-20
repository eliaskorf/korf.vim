require('lualine').setup {

  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = ' . ', right = ''},
    section_separators = { left = ' ', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {

    lualine_a = {
        {'mode', icon = {'', align='left', color={fg='#262622'}}}
    },

    lualine_b = {'branch', 'diff', 'diagnostics'},

    lualine_c = {
      'windows',
      -- {'filetype', icon_only = true},
      {'filename',
      path = 4,
      symbols = {
        modified = '', readonly = '', unnamed = '[No Name]', newfile = '[New]',
        }
      }
    },

    lualine_x = {'encoding', 'fileformat'},

    lualine_y = {'progress'},

    lualine_z = {
        {'location', icon = {'  ', align='left', color={fg='#262622', bg='#607f60'}}}
    },

  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },

    --    tabline = {},

    --    winbar = {
    --    lualine_a = {'buffers'},
    --    lualine_b = {},
    --    lualine_c = {},
    --    lualine_x = {},
    --    lualine_y = {'hostname'},
    --    lualine_z = {'tabs'}
    --    },

  inactive_winbar = {},
  extensions = {}

  -- end --
}



