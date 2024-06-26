set bg=dark
hi clear
syntax reset
let colors_name = "signed_dark_pro"

hi Normal guifg=#ffffff guibg=#000000
hi Visual guibg=#3e4451
hi LspReferenceText guibg=#1c1f25
hi LspReferenceRead guibg=#1c1f25
hi LspReferenceWrite guibg=#1c1f25
hi VertSplit guifg=#3e4451 guibg=#3e4451 gui=none
hi StatusLine guifg=#565c64 guibg=#3e4451 gui=none
hi StatusLineNC guifg=#545862 guibg=#1c1f25 gui=none
hi LineNr guifg=#545862 guibg=#000000
hi CursorLineNr guifg=#565c64 guibg=#000000
hi Cursor guifg=#000000 guibg=#ffffff
hi Cursor guifg=#000000 guibg=#ffffff
hi CursorLine guibg=#040405 gui=none
hi ColorColumn guibg=#040405 gui=none
hi SignColumn guifg=#ffffff guibg=#1c1f25 gui=none
hi NonText guifg=#1c1f25
hi QuickFixLine guibg=#1c1f25 gui=none
hi Error guifg=#000000 guibg=#ef596f
hi Underlined guifg=#ef596f
hi Title guifg=#61afef gui=none
hi TabLine guifg=#565c64 guibg=#000000 gui=none
hi TabLineFill guifg=#545862 guibg=#000000 gui=none
hi TabLineSel guifg=#ffffff guibg=#1c1f25 gui=bold
hi MatchParen guibg=#3e4451
hi Directory guifg=#61afef
hi IncSearch guifg=#1c1f25 guibg=#d19a66 gui=none
hi Search guifg=#1c1f25 guibg=#e5c07b
hi Comment guifg=#545862 gui=italic
hi Delimiter guifg=#a9abb0
hi String guifg=#89ca78
hi Statement guifg=#d55fde gui=none
hi StorageClass guifg=#d55fde gui=none
hi Type guifg=#e5c07b gui=none
hi Operator guifg=#d55fde gui=none
hi Identifier guifg=#ef596f gui=none
hi Special guifg=#2bbac5 gui=none
hi Constant guifg=#d19a66 gui=none
hi PreProc guifg=#e5c07b
hi Function guifg=#61afef
hi xmlTag guifg=#ffffff
hi xmlEndTag guifg=#ffffff
hi xmlTagName guifg=#61afef
hi xmlTagN guifg=#61afef
hi xmlAttrib guifg=#be5046
hi SpellBad gui=undercurl guisp=#ef596f
hi SpellLocal gui=undercurl guisp=#2bbac5
hi SpellCap gui=undercurl guisp=#61afef
hi SpellRare gui=undercurl guisp=#d55fde
hi DiagnosticError guifg=#ef596f
hi DiagnosticUnderlineError gui=undercurl guisp=#ef596f
hi DiagnosticWarn guifg=#d19a66
hi DiagnosticUnderlineWarn gui=undercurl guisp=#d19a66
hi DiagnosticHint guifg=#89ca78
hi DiagnosticUnderlineHint gui=undercurl guisp=#89ca78
hi DiagnosticInfo guifg=#61afef
hi DiagnosticUnderlineInfo gui=undercurl guisp=#61afef
hi DiffAdd guibg=#1b2818 gui=none
hi DiffChange guibg=#000000
hi DiffDelete guifg=#26100e guibg=#26100e gui=none
hi DiffText guibg=#1b2818 gui=none
hi NeogitDiffContext guifg=#ffffff guibg=#000000
hi NeogitDiffAdd guifg=#89ca78 guibg=#000000
hi NeogitDiffDelete guifg=#be5046 guibg=#000000
hi NeogitDiffContextHighlight guifg=#ffffff guibg=#000000
hi NeogitDiffAddHighlight guifg=#89ca78 guibg=#000000
hi NeogitDiffDeleteHighlight guifg=#be5046 guibg=#000000
hi NeogitHunkHeader guifg=#ffffff guibg=#1c1f25
hi NeogitHunkHeaderHighlight guifg=#ffffff guibg=#1c1f25
hi DiffAdded guifg=#89ca78 guibg=#000000
hi DiffFile guifg=#be5046 guibg=#000000
hi DiffNewFile guifg=#89ca78 guibg=#000000
hi DiffLine guifg=#61afef guibg=#000000
hi DiffRemoved guifg=#be5046 guibg=#000000
hi SignifySignAdd guifg=#89ca78 guibg=#1b2818
hi SignifySignChange guifg=#61afef guibg=#182b3b
hi SignifySignDelete guifg=#be5046 gui=underline
hi SignifySignDeleteFirstLine guifg=#be5046
hi @markup.heading guifg=#61afef gui=bold
hi @markup.list guifg=#ef596f
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#be5046 guibg=#000000
hi @markup.underline guifg=#89ca78 guibg=#000000
hi @markup.link.url gui=underline
hi PMenu guifg=#ffffff guibg=#1c1f25 gui=none
hi PMenuSel guifg=#1c1f25 guibg=#ffffff
hi Todo guifg=#e5c07b guibg=#1c1f25
hi Folded guifg=#545862 guibg=#1c1f25
hi FoldColumn guifg=#545862 guibg=#000000

let g:terminal_color_0 =  "#000000"
let g:terminal_color_1 =  "#ef596f"
let g:terminal_color_2 =  "#89ca78"
let g:terminal_color_3 =  "#e5c07b"
let g:terminal_color_4 =  "#61afef"
let g:terminal_color_5 =  "#d55fde"
let g:terminal_color_6 =  "#2bbac5"
let g:terminal_color_7 =  "#ffffff"
let g:terminal_color_8 =  "#545862"
let g:terminal_color_9 =  "#ef596f"
let g:terminal_color_10 = "#89ca78"
let g:terminal_color_11 = "#e5c07b"
let g:terminal_color_12 = "#61afef"
let g:terminal_color_13 = "#d55fde"
let g:terminal_color_14 = "#2bbac5"
let g:terminal_color_15 = "#ffffff"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
