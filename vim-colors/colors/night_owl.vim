set bg=dark
hi clear
syntax reset
let colors_name = "night_owl"

hi Normal guifg=#abb2bf guibg=#011627
hi Visual guibg=#4b6479
hi LspReferenceText guibg=#1d3b53
hi LspReferenceRead guibg=#1d3b53
hi LspReferenceWrite guibg=#1d3b53
hi VertSplit guifg=#4b6479 guibg=#4b6479 gui=none
hi StatusLine guifg=#80a4c2 guibg=#4b6479 gui=none
hi StatusLineNC guifg=#637777 guibg=#1d3b53 gui=none
hi LineNr guifg=#637777 guibg=#011627
hi CursorLineNr guifg=#80a4c2 guibg=#011627
hi Cursor guifg=#011627 guibg=#abb2bf
hi Cursor guifg=#011627 guibg=#abb2bf
hi CursorLine guibg=#051b2d gui=none
hi ColorColumn guibg=#051b2d gui=none
hi SignColumn guifg=#abb2bf guibg=#1d3b53 gui=none
hi NonText guifg=#1d3b53
hi QuickFixLine guibg=#1d3b53 gui=none
hi Error guifg=#011627 guibg=#abb2bf
hi Underlined guifg=#abb2bf
hi Title guifg=#82aaff gui=none
hi TabLine guifg=#80a4c2 guibg=#011627 gui=none
hi TabLineFill guifg=#637777 guibg=#011627 gui=none
hi TabLineSel guifg=#abb2bf guibg=#1d3b53 gui=bold
hi MatchParen guibg=#4b6479
hi Directory guifg=#82aaff
hi IncSearch guifg=#1d3b53 guibg=#f78c6c gui=none
hi Search guifg=#1d3b53 guibg=#ffeb95
hi Comment guifg=#637777 gui=italic
hi Delimiter guifg=#87949b
hi String guifg=#ecc48d
hi Statement guifg=#c792ea gui=none
hi StorageClass guifg=#c792ea gui=none
hi Type guifg=#ffeb95 gui=none
hi Operator guifg=#c792ea gui=none
hi Identifier guifg=#abb2bf gui=none
hi Special guifg=#addb67 gui=none
hi Constant guifg=#f78c6c gui=none
hi PreProc guifg=#ffeb95
hi Function guifg=#82aaff
hi xmlTag guifg=#abb2bf
hi xmlEndTag guifg=#abb2bf
hi xmlTagName guifg=#82aaff
hi xmlTagN guifg=#82aaff
hi xmlAttrib guifg=#ef5350
hi SpellBad gui=undercurl guisp=#abb2bf
hi SpellLocal gui=undercurl guisp=#addb67
hi SpellCap gui=undercurl guisp=#82aaff
hi SpellRare gui=undercurl guisp=#c792ea
hi DiagnosticError guifg=#abb2bf
hi DiagnosticUnderlineError gui=undercurl guisp=#abb2bf
hi DiagnosticWarn guifg=#f78c6c
hi DiagnosticUnderlineWarn gui=undercurl guisp=#f78c6c
hi DiagnosticHint guifg=#ecc48d
hi DiagnosticUnderlineHint gui=undercurl guisp=#ecc48d
hi DiagnosticInfo guifg=#82aaff
hi DiagnosticUnderlineInfo gui=undercurl guisp=#82aaff
hi DiffAdd guibg=#233d33 gui=none
hi DiffChange guibg=#011627
hi DiffDelete guifg=#30222f guibg=#30222f gui=none
hi DiffText guibg=#233d33 gui=none
hi NeogitDiffContext guifg=#abb2bf guibg=#011627
hi NeogitDiffAdd guifg=#addb67 guibg=#011627
hi NeogitDiffDelete guifg=#ef5350 guibg=#011627
hi NeogitDiffContextHighlight guifg=#abb2bf guibg=#011627
hi NeogitDiffAddHighlight guifg=#addb67 guibg=#011627
hi NeogitDiffDeleteHighlight guifg=#ef5350 guibg=#011627
hi NeogitHunkHeader guifg=#abb2bf guibg=#1d3b53
hi NeogitHunkHeaderHighlight guifg=#abb2bf guibg=#1d3b53
hi DiffAdded guifg=#addb67 guibg=#011627
hi DiffFile guifg=#ef5350 guibg=#011627
hi DiffNewFile guifg=#addb67 guibg=#011627
hi DiffLine guifg=#82aaff guibg=#011627
hi DiffRemoved guifg=#ef5350 guibg=#011627
hi SignifySignAdd guifg=#addb67 guibg=#233d33
hi SignifySignChange guifg=#82aaff guibg=#213b5d
hi SignifySignDelete guifg=#ef5350 gui=underline
hi SignifySignDeleteFirstLine guifg=#ef5350
hi @markup.heading guifg=#82aaff gui=bold
hi @markup.list guifg=#abb2bf
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#ef5350 guibg=#011627
hi @markup.underline guifg=#addb67 guibg=#011627
hi @markup.link.url gui=underline
hi PMenu guifg=#abb2bf guibg=#1d3b53 gui=none
hi PMenuSel guifg=#1d3b53 guibg=#abb2bf
hi Todo guifg=#ffeb95 guibg=#1d3b53
hi Folded guifg=#637777 guibg=#1d3b53
hi FoldColumn guifg=#637777 guibg=#011627

let g:terminal_color_0 =  "#011627"
let g:terminal_color_1 =  "#abb2bf"
let g:terminal_color_2 =  "#ecc48d"
let g:terminal_color_3 =  "#ffeb95"
let g:terminal_color_4 =  "#82aaff"
let g:terminal_color_5 =  "#c792ea"
let g:terminal_color_6 =  "#addb67"
let g:terminal_color_7 =  "#abb2bf"
let g:terminal_color_8 =  "#637777"
let g:terminal_color_9 =  "#abb2bf"
let g:terminal_color_10 = "#ecc48d"
let g:terminal_color_11 = "#ffeb95"
let g:terminal_color_12 = "#82aaff"
let g:terminal_color_13 = "#c792ea"
let g:terminal_color_14 = "#addb67"
let g:terminal_color_15 = "#ffffff"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
