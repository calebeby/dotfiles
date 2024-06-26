set bg=dark
hi clear
syntax reset
let colors_name = "one_dark"

hi Normal guifg=#abb2bf guibg=#282c34
hi Visual guibg=#3e4451
hi LspReferenceText guibg=#353b45
hi LspReferenceRead guibg=#353b45
hi LspReferenceWrite guibg=#353b45
hi VertSplit guifg=#3e4451 guibg=#3e4451 gui=none
hi StatusLine guifg=#565c64 guibg=#3e4451 gui=none
hi StatusLineNC guifg=#545862 guibg=#353b45 gui=none
hi LineNr guifg=#545862 guibg=#282c34
hi CursorLineNr guifg=#565c64 guibg=#282c34
hi Cursor guifg=#282c34 guibg=#abb2bf
hi Cursor guifg=#282c34 guibg=#abb2bf
hi CursorLine guibg=#292e36 gui=none
hi ColorColumn guibg=#292e36 gui=none
hi SignColumn guifg=#abb2bf guibg=#353b45 gui=none
hi NonText guifg=#353b45
hi QuickFixLine guibg=#353b45 gui=none
hi Error guifg=#282c34 guibg=#e06c75
hi Underlined guifg=#e06c75
hi Title guifg=#61afef gui=none
hi TabLine guifg=#565c64 guibg=#282c34 gui=none
hi TabLineFill guifg=#545862 guibg=#282c34 gui=none
hi TabLineSel guifg=#abb2bf guibg=#353b45 gui=bold
hi MatchParen guibg=#3e4451
hi Directory guifg=#61afef
hi IncSearch guifg=#353b45 guibg=#d19a66 gui=none
hi Search guifg=#353b45 guibg=#e5c07b
hi Comment guifg=#545862 gui=italic
hi Delimiter guifg=#7f8590
hi String guifg=#98c379
hi Statement guifg=#c678dd gui=none
hi StorageClass guifg=#c678dd gui=none
hi Type guifg=#e5c07b gui=none
hi Operator guifg=#c678dd gui=none
hi Identifier guifg=#e06c75 gui=none
hi Special guifg=#56b6c2 gui=none
hi Constant guifg=#d19a66 gui=none
hi PreProc guifg=#e5c07b
hi Function guifg=#61afef
hi xmlTag guifg=#abb2bf
hi xmlEndTag guifg=#abb2bf
hi xmlTagName guifg=#61afef
hi xmlTagN guifg=#61afef
hi xmlAttrib guifg=#be5046
hi SpellBad gui=undercurl guisp=#e06c75
hi SpellLocal gui=undercurl guisp=#56b6c2
hi SpellCap gui=undercurl guisp=#61afef
hi SpellRare gui=undercurl guisp=#c678dd
hi DiagnosticError guifg=#e06c75
hi DiagnosticUnderlineError gui=undercurl guisp=#e06c75
hi DiagnosticWarn guifg=#d19a66
hi DiagnosticUnderlineWarn gui=undercurl guisp=#d19a66
hi DiagnosticHint guifg=#98c379
hi DiagnosticUnderlineHint gui=undercurl guisp=#98c379
hi DiagnosticInfo guifg=#61afef
hi DiagnosticUnderlineInfo gui=undercurl guisp=#61afef
hi DiffAdd guibg=#3e4a41 gui=none
hi DiffChange guibg=#282c34
hi DiffDelete guifg=#4c3841 guibg=#4c3841 gui=none
hi DiffText guibg=#3e4a41 gui=none
hi NeogitDiffContext guifg=#abb2bf guibg=#282c34
hi NeogitDiffAdd guifg=#98c379 guibg=#282c34
hi NeogitDiffDelete guifg=#e06c75 guibg=#282c34
hi NeogitDiffContextHighlight guifg=#abb2bf guibg=#282c34
hi NeogitDiffAddHighlight guifg=#98c379 guibg=#282c34
hi NeogitDiffDeleteHighlight guifg=#e06c75 guibg=#282c34
hi NeogitHunkHeader guifg=#abb2bf guibg=#353b45
hi NeogitHunkHeaderHighlight guifg=#abb2bf guibg=#353b45
hi DiffAdded guifg=#98c379 guibg=#282c34
hi DiffFile guifg=#e06c75 guibg=#282c34
hi DiffNewFile guifg=#98c379 guibg=#282c34
hi DiffLine guifg=#61afef guibg=#282c34
hi DiffRemoved guifg=#e06c75 guibg=#282c34
hi SignifySignAdd guifg=#98c379 guibg=#3e4a41
hi SignifySignChange guifg=#61afef guibg=#364c62
hi SignifySignDelete guifg=#e06c75 gui=underline
hi SignifySignDeleteFirstLine guifg=#e06c75
hi @markup.heading guifg=#61afef gui=bold
hi @markup.list guifg=#e06c75
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#e06c75 guibg=#282c34
hi @markup.underline guifg=#98c379 guibg=#282c34
hi @markup.link.url gui=underline
hi PMenu guifg=#abb2bf guibg=#353b45 gui=none
hi PMenuSel guifg=#353b45 guibg=#abb2bf
hi Todo guifg=#e5c07b guibg=#353b45
hi Folded guifg=#545862 guibg=#353b45
hi FoldColumn guifg=#545862 guibg=#282c34

let g:terminal_color_0 =  "#282c34"
let g:terminal_color_1 =  "#e06c75"
let g:terminal_color_2 =  "#98c379"
let g:terminal_color_3 =  "#e5c07b"
let g:terminal_color_4 =  "#61afef"
let g:terminal_color_5 =  "#c678dd"
let g:terminal_color_6 =  "#56b6c2"
let g:terminal_color_7 =  "#abb2bf"
let g:terminal_color_8 =  "#545862"
let g:terminal_color_9 =  "#e06c75"
let g:terminal_color_10 = "#98c379"
let g:terminal_color_11 = "#e5c07b"
let g:terminal_color_12 = "#61afef"
let g:terminal_color_13 = "#c678dd"
let g:terminal_color_14 = "#56b6c2"
let g:terminal_color_15 = "#c8ccd4"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
