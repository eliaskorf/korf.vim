return {
  'echasnovski/mini.icons',
  opts = {}, -- 🚀 Этого достаточно! Lazy сам вызовет require('mini.icons').setup({})
  lazy = true,
  specs = { { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true } },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
