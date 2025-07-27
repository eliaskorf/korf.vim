require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "astro",
    "css",
    "scss",         -- SCSS (расширение CSS)
    "html",
    "javascript",
    "typescript",
    "tsx",
    "vue",
    "lua",
    "bash",
    "vim",
    "vimdoc",
    "php",
    "sql",
    "svelte",       -- если имелся в виду Svelte
    "nginx",
    "pug",
    "glsl",
    "git_config",   -- git конфигурационные файлы
    "git_rebase",   -- git rebase файлы
    -- "mermaid" отсутствует в официальных парсерах, требуется отдельный плагин для подсветки
    -- "ssh" парсеров нет, но можно использовать bash или sh для подсветки скриптов
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}

