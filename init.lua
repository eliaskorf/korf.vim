require("core.plugins") -- Load Plugins
require("core.mappings") -- Load Keymappings
require("core.config")
require("core.options")
-- require("config.lazy")

--Plugins
require("plugins.lsp")
require("plugins.neotree")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.mason")
require("plugins.dashboard")
require("plugins.buffline")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.autopairs")
require("plugins.autotag")
require("plugins.comments")
require("plugins.inlayhints")
require("plugins.miniicons")
require("plugins.wichkey")
require("plugins.indent-blankline")
--require("plugins.cmp")

-- Подключаем модуль lspconfig
local lspconfig = require('lspconfig')

-- Настраиваем CSS LSP
lspconfig.cssls.setup({})



-- vim.opt.mouse = ""
vim.cmd("colorscheme kanagawa")
-- Конец файла, убедитесь, что после этой строки нет лишних символов.
