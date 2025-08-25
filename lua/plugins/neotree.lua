
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
--      vim.fn.sign_define("DiagnosticSignError",
--        {text = " ", texthl = "DiagnosticSignError"})
--      vim.fn.sign_define("DiagnosticSignWarn",
--        {text = " ", texthl = "DiagnosticSignWarn"})
--      vim.fn.sign_define("DiagnosticSignInfo",
--        {text = " ", texthl = "DiagnosticSignInfo"})
--      vim.fn.sign_define("DiagnosticSignHint",
--        {text = "󰌵", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
  rocks = {
    enabled = false,  -- ⛔ Отключаем luarocks
  },
})
