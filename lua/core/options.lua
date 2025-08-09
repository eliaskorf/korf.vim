local o = vim.opt
local cmd = vim.cmd

o.number = true               -- показывать номера строк
o.relativenumber = true       -- относительная нумерация строк
o.cursorline = true           -- подсветка текущей строки
o.wrap = false                -- не переносить длинные строки
-- o.scrolloff = 8            -- минимум 8 строк до края экрана при скролле

o.langmap = [[йq,ЙQ,цw,ЦW,уe,УE,кr,КR,еt,ЕT,нy,НY,гu,ГU,шi,ШI,щo,ЩO,зp,ЗP,х[,Х{,ъ],Ъ},фa,ФA,ыs,ЫS,вd,ВD,аf,АF,пg,ПG,рh,РH,оj,ОJ,лk,ЛK,дl,ДL,ж\;,Ж:,э',Э",яz,ЯZ,чx,ЧX,сc,СC,мv,МV,иb,ИB,тn,ТN,ьm,ЬM,б\\,,Б<,ю.,Ю>,ё~,Ё~]]

-- Options for tabs
o.expandtab = true       -- использовать пробелы вместо tab
o.tabstop = 2            -- ширина tab = 4 пробела
o.shiftwidth = 2         -- размер отступа при авто-отступе
o.softtabstop = 2        -- размер tab при нажатии Tab в insert mode
o.smartindent = true     -- умный авто-отступ

-- Options for splits
o.splitright = true       -- новые вертикальные сплиты справа
o.splitbelow = true       -- новые горизонтальные сплиты снизу

-- Автоматическое определение отступов на основе файла
o.autoindent = true
o.smartindent = true

-- Показывать символы табуляции (если expandtab=false)
o.listchars:append({ tab = '→ ' })  -- Отображать символ табуляции
o.list = true                       -- Включить отображение

-- Spellchecking for Russian and English
o.spell = true
o.spelllang = { 'ru', 'en' }

-- Options for search
o.ignorecase = true      -- Игнорировать регистр при поиске
o.smartcase = true       -- Не игнорировать регистр, если есть символы в верхнем регистре
o.showmatch = true       -- Подсвечивать найденные текстовые объекты
o.incsearch = true       -- инкрементальный поиск

-- Misc options
o.fixeol = false
o.backup = false         -- не создавать backup файлы
o.writebackup = false    -- не создавать временные файлы при записи
o.swapfile = false       -- отключить swap файлы
o.undofile = true        -- сохранять историю изменений в файле
-- o.mouse = ""

-- Advanced options
o.list = true            -- показывать невидимые символы
o.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
    extends = "›",
    precedes = "‹"
}
o.termguicolors = true        -- поддержка true color в терминале
o.signcolumn = "yes"          -- всегда показывать колонку для знаков
o.cmdheight = 2               -- высота командной строки
o.clipboard = "unnamedplus"   -- Связывает буфер обмена Vim с системным буфером обмена через + регистр (X11/Wayland).
o.splitright = true           -- Новые вертикальные сплиты :vsplit, :vnew появляются справа от текущего окна.
o.splitbelow = true           -- Что делает: Новые горизонтальные сплиты :split, :new появляются под текущим окном.
o.laststatus = 3

-- Игнорировать эти файлы при поиске и навигации
o.wildignore:append("*.o,*.obj,*.dll,*.exe,*.so,*.pyc")
o.wildignore:append("node_modules/*,bower_components/*")
o.wildignore:append("*.min.js,*.min.css")
o.wildignore:append("dist/*,build/*,.git/*")

cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")
cmd("colorscheme kanagawa")
