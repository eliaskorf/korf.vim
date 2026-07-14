require("core.plugins")  -- Load Plugins
require("core.mappings") -- Load Keymappings
require("core.options")  -- Load Options

local llm = require("modules.llm")
llm.setup()

require("modules.notes")

-- Load plugins config files
require("plugins.mason")

require("plugins.conform")
require("plugins.lint")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.buffline")
require("plugins.cmp")
require("plugins.comments")
require("plugins.dashboard")
require("plugins.dressing")
require("plugins.indent-blankline")
require("plugins.kanagawa")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.mini")
require("plugins.neotree")
require("plugins.nvim-ts-autotag")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.treesitter")
require("plugins.wichkey")


vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- === Принудительная загрузка Mason ===
vim.defer_fn(function()
  require("mason").setup()
  require("mason-lspconfig").setup()
end, 50)
