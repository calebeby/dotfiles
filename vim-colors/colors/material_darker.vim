set bg=dark
hi clear
syntax reset
let colors_name = "material_darker"

hi Normal guifg=#EEFFFF guibg=#212121
hi Visual guibg=#353535
hi LspReferenceText guibg=#303030
hi LspReferenceRead guibg=#303030
hi LspReferenceWrite guibg=#303030
hi VertSplit guifg=#353535 guibg=#353535 gui=none
hi StatusLine guifg=#B2CCD6 guibg=#353535 gui=none
hi StatusLineNC guifg=#4A4A4A guibg=#303030 gui=none
hi LineNr guifg=#4A4A4A guibg=#212121
hi CursorLineNr guifg=#B2CCD6 guibg=#212121
hi Cursor guifg=#212121 guibg=#EEFFFF
hi Cursor guifg=#212121 guibg=#EEFFFF
hi CursorLine guibg=#232323 gui=none
hi ColorColumn guibg=#232323 gui=none
hi SignColumn guifg=#EEFFFF guibg=#303030 gui=none
hi NonText guifg=#303030
hi QuickFixLine guibg=#303030 gui=none
hi Error guifg=#212121 guibg=#F07178
hi Underlined guifg=#F07178
hi Title guifg=#82AAFF gui=none
hi TabLine guifg=#B2CCD6 guibg=#212121 gui=none
hi TabLineFill guifg=#4A4A4A guibg=#212121 gui=none
hi TabLineSel guifg=#EEFFFF guibg=#303030 gui=bold
hi MatchParen guibg=#353535
hi Directory guifg=#82AAFF
hi IncSearch guifg=#303030 guibg=#F78C6C gui=none
hi Search guifg=#303030 guibg=#FFCB6B
hi Comment guifg=#4A4A4A gui=italic
hi Delimiter guifg=#9ca4a4
hi String guifg=#C3E88D
hi Statement guifg=#C792EA gui=none
hi StorageClass guifg=#C792EA gui=none
hi Type guifg=#FFCB6B gui=none
hi Operator guifg=#C792EA gui=none
hi Identifier guifg=#F07178 gui=none
hi Special guifg=#89DDFF gui=none
hi Constant guifg=#F78C6C gui=none
hi PreProc guifg=#FFCB6B
hi Function guifg=#82AAFF
hi xmlTag guifg=#EEFFFF
hi xmlEndTag guifg=#EEFFFF
hi xmlTagName guifg=#82AAFF
hi xmlTagN guifg=#82AAFF
hi xmlAttrib guifg=#FF5370
hi SpellBad gui=undercurl guisp=#F07178
hi SpellLocal gui=undercurl guisp=#89DDFF
hi SpellCap gui=undercurl guisp=#82AAFF
hi SpellRare gui=undercurl guisp=#C792EA
hi DiagnosticError guifg=#F07178
hi DiagnosticUnderlineError gui=undercurl guisp=#F07178
hi DiagnosticWarn guifg=#F78C6C
hi DiagnosticUnderlineWarn gui=undercurl guisp=#F78C6C
hi DiagnosticHint guifg=#C3E88D
hi DiagnosticUnderlineHint gui=undercurl guisp=#C3E88D
hi DiagnosticInfo guifg=#82AAFF
hi DiagnosticUnderlineInfo gui=undercurl guisp=#82AAFF
hi DiffAdd guibg=#414836 gui=none
hi DiffChange guibg=#212121
hi DiffDelete guifg=#4a3132 guibg=#4a3132 gui=none
hi DiffText guibg=#414836 gui=none
hi NeogitDiffContext guifg=#EEFFFF guibg=#212121
hi NeogitDiffAdd guifg=#C3E88D guibg=#212121
hi NeogitDiffDelete guifg=#F07178 guibg=#212121
hi NeogitDiffContextHighlight guifg=#EEFFFF guibg=#212121
hi NeogitDiffAddHighlight guifg=#C3E88D guibg=#212121
hi NeogitDiffDeleteHighlight guifg=#F07178 guibg=#212121
hi NeogitHunkHeader guifg=#EEFFFF guibg=#303030
hi NeogitHunkHeaderHighlight guifg=#EEFFFF guibg=#303030
hi DiffAdded guifg=#C3E88D guibg=#212121
hi DiffFile guifg=#F07178 guibg=#212121
hi DiffNewFile guifg=#C3E88D guibg=#212121
hi DiffLine guifg=#82AAFF guibg=#212121
hi DiffRemoved guifg=#F07178 guibg=#212121
hi SignifySignAdd guifg=#C3E88D guibg=#414836
hi SignifySignChange guifg=#82AAFF guibg=#394358
hi SignifySignDelete guifg=#F07178 gui=underline
hi SignifySignDeleteFirstLine guifg=#F07178
hi @markup.heading guifg=#82AAFF gui=bold
hi @markup.list guifg=#F07178
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#F07178 guibg=#212121
hi @markup.underline guifg=#C3E88D guibg=#212121
hi @markup.link.url gui=underline
hi PMenu guifg=#EEFFFF guibg=#303030 gui=none
hi PMenuSel guifg=#303030 guibg=#EEFFFF
hi Todo guifg=#FFCB6B guibg=#303030
hi Folded guifg=#4A4A4A guibg=#303030
hi FoldColumn guifg=#4A4A4A guibg=#212121

let g:terminal_color_0 =  "#212121"
let g:terminal_color_1 =  "#F07178"
let g:terminal_color_2 =  "#C3E88D"
let g:terminal_color_3 =  "#FFCB6B"
let g:terminal_color_4 =  "#82AAFF"
let g:terminal_color_5 =  "#C792EA"
let g:terminal_color_6 =  "#89DDFF"
let g:terminal_color_7 =  "#EEFFFF"
let g:terminal_color_8 =  "#4A4A4A"
let g:terminal_color_9 =  "#F07178"
let g:terminal_color_10 = "#C3E88D"
let g:terminal_color_11 = "#FFCB6B"
let g:terminal_color_12 = "#82AAFF"
let g:terminal_color_13 = "#C792EA"
let g:terminal_color_14 = "#89DDFF"
let g:terminal_color_15 = "#FFFFFF"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
