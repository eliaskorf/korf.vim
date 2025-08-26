require("core.plugins") -- Load Plugins
require("core.mappings") -- Load Keymappings
require("core.options") -- Load Options

 local llm = require("modules.llm")
 llm.setup()

require("modules.notes")

-- Load plugins config files
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
require("plugins.cmp")
require("plugins.dressing")
