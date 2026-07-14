return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,           -- важно!
  build = ":TSUpdate",    -- обязательно
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "astro", "css", "scss", "html", "javascript", "typescript", "tsx",
        "vue", "lua", "bash", "vim", "vimdoc", "php", "sql", "svelte",
        "nginx", "pug", "glsl", "git_config", "git_rebase",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        disable = { "lua" },                    -- можешь добавить { "latex" } и т.д.
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },        -- добавь, очень полезно
    })
  end,
}
