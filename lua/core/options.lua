local o = vim.opt

o.langmap = [[йq,ЙQ,цw,ЦW,уe,УE,кr,КR,еt,ЕT,нy,НY,гu,ГU,шi,ШI,щo,ЩO,зp,ЗP,х[,Х{,ъ],Ъ},фa,ФA,ыs,ЫS,вd,ВD,аf,АF,пg,ПG,рh,РH,оj,ОJ,лk,ЛK,дl,ДL,ж\;,Ж:,э',Э",яz,ЯZ,чx,ЧX,сc,СC,мv,МV,иb,ИB,тn,ТN,ьm,ЬM,б\\,,Б<,ю.,Ю>,ё~,Ё~]]

o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Автоматическое определение отступов на основе файла
o.autoindent = true
o.smartindent = true

-- Показывать символы табуляции (если expandtab=false)
o.listchars:append({ tab = '→ ' })
o.list = true  -- Включить отображение

-- o.mouse = ""

