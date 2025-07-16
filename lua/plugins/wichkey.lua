local wk = require("which-key")

wk.setup({
  -- Группируем маппинги по категориям
  { "<leader>c", group = "Comment" },
  { "<leader>cl", desc = "Comment Line" },
  
  -- Группа для поиска
  { "<leader>f", group = "Find" },
  { "<leader>ff", desc = "Find File" },
  { "<leader>fb", desc = "Find Buffer" },
  { "<leader>fh", desc = "Find Help" },
  { "<leader>fw", desc = "Find Text" },
  
  -- Группа для Git
  { "<leader>g", group = "Git" },
  { "<leader>gb", desc = "Git Branches" },
  { "<leader>gc", desc = "Git Commits" },
  { "<leader>gs", desc = "Git Status" },
  
  -- Группа для LSP
  { "<leader>l", group = "LSP" },
  { "<leader>lD", desc = "Hover Diagnostic" },
  { "<leader>la", desc = "LSP Action" },
  { "<leader>ld", desc = "Diagnostic" },
  { "<leader>lf", desc = "Format Code" },
  { "<leader>lr", desc = "Rename Symbol" },
  { "<leader>ls", desc = "Symbol Search" },

  -- Прочие маппинги
  { "<leader>o", desc = "Git Status" },
  { "<leader>h", desc = "Clear Highlights" },
  { "<leader>w", desc = "Save File" },
  { "<leader>x", desc = "Close Buffer" },

  -- Группа для терминала
  { "<leader>t", group = "Terminal" },
  { "<leader>tf", desc = "Floating Terminal" },
  { "<leader>th", desc = "Horizontal Terminal" },
})
