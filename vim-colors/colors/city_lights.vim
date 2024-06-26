set bg=dark
hi clear
syntax reset
let colors_name = "city_lights"

hi Normal guifg=#b7c5d3 guibg=#1d252c
hi Visual guibg=#28323a
hi LspReferenceText guibg=#171d23
hi LspReferenceRead guibg=#171d23
hi LspReferenceWrite guibg=#171d23
hi VertSplit guifg=#28323a guibg=#28323a gui=none
hi StatusLine guifg=#b7c5d3 guibg=#28323a gui=none
hi StatusLineNC guifg=#41505E guibg=#171d23 gui=none
hi LineNr guifg=#41505E guibg=#1d252c
hi CursorLineNr guifg=#b7c5d3 guibg=#1d252c
hi Cursor guifg=#1d252c guibg=#b7c5d3
hi Cursor guifg=#1d252c guibg=#b7c5d3
hi CursorLine guibg=#1c232a gui=none
hi ColorColumn guibg=#1c232a gui=none
hi SignColumn guifg=#b7c5d3 guibg=#171d23 gui=none
hi NonText guifg=#171d23
hi QuickFixLine guibg=#171d23 gui=none
hi Error guifg=#1d252c guibg=#8BD49C
hi Underlined guifg=#8BD49C
hi Title guifg=#70e1e8 gui=none
hi TabLine guifg=#b7c5d3 guibg=#1d252c gui=none
hi TabLineFill guifg=#41505E guibg=#1d252c gui=none
hi TabLineSel guifg=#b7c5d3 guibg=#171d23 gui=bold
hi MatchParen guibg=#28323a
hi Directory guifg=#70e1e8
hi IncSearch guifg=#171d23 guibg=#e27e8d gui=none
hi Search guifg=#171d23 guibg=#ebbf83
hi Comment guifg=#41505E gui=italic
hi Delimiter guifg=#7c8a98
hi String guifg=#68a1f0
hi Statement guifg=#008b94 gui=none
hi StorageClass guifg=#008b94 gui=none
hi Type guifg=#ebbf83 gui=none
hi Operator guifg=#008b94 gui=none
hi Identifier guifg=#8BD49C gui=none
hi Special guifg=#e27e8d gui=none
hi Constant guifg=#e27e8d gui=none
hi PreProc guifg=#ebbf83
hi Function guifg=#70e1e8
hi xmlTag guifg=#b7c5d3
hi xmlEndTag guifg=#b7c5d3
hi xmlTagName guifg=#70e1e8
hi xmlTagN guifg=#70e1e8
hi xmlAttrib guifg=#008b94
hi SpellBad gui=undercurl guisp=#8BD49C
hi SpellLocal gui=undercurl guisp=#e27e8d
hi SpellCap gui=undercurl guisp=#70e1e8
hi SpellRare gui=undercurl guisp=#008b94
hi DiagnosticError guifg=#8BD49C
hi DiagnosticUnderlineError gui=undercurl guisp=#8BD49C
hi DiagnosticWarn guifg=#e27e8d
hi DiagnosticUnderlineWarn gui=undercurl guisp=#e27e8d
hi DiagnosticHint guifg=#68a1f0
hi DiagnosticUnderlineHint gui=undercurl guisp=#68a1f0
hi DiagnosticInfo guifg=#70e1e8
hi DiagnosticUnderlineInfo gui=undercurl guisp=#70e1e8
hi DiffAdd guibg=#334842 gui=none
hi DiffChange guibg=#1d252c
hi DiffDelete guifg=#44363f guibg=#44363f gui=none
hi DiffText guibg=#334842 gui=none
hi NeogitDiffContext guifg=#b7c5d3 guibg=#1d252c
hi NeogitDiffAdd guifg=#8BD49C guibg=#1d252c
hi NeogitDiffDelete guifg=#e27e8d guibg=#1d252c
hi NeogitDiffContextHighlight guifg=#b7c5d3 guibg=#1d252c
hi NeogitDiffAddHighlight guifg=#8BD49C guibg=#1d252c
hi NeogitDiffDeleteHighlight guifg=#e27e8d guibg=#1d252c
hi NeogitHunkHeader guifg=#b7c5d3 guibg=#171d23
hi NeogitHunkHeaderHighlight guifg=#b7c5d3 guibg=#171d23
hi DiffAdded guifg=#8BD49C guibg=#1d252c
hi DiffFile guifg=#e27e8d guibg=#1d252c
hi DiffNewFile guifg=#8BD49C guibg=#1d252c
hi DiffLine guifg=#70e1e8 guibg=#1d252c
hi DiffRemoved guifg=#e27e8d guibg=#1d252c
hi SignifySignAdd guifg=#8BD49C guibg=#334842
hi SignifySignChange guifg=#70e1e8 guibg=#31545b
hi SignifySignDelete guifg=#e27e8d gui=underline
hi SignifySignDeleteFirstLine guifg=#e27e8d
hi @markup.heading guifg=#70e1e8 gui=bold
hi @markup.list guifg=#8BD49C
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#e27e8d guibg=#1d252c
hi @markup.underline guifg=#8BD49C guibg=#1d252c
hi @markup.link.url gui=underline
hi PMenu guifg=#b7c5d3 guibg=#171d23 gui=none
hi PMenuSel guifg=#171d23 guibg=#b7c5d3
hi Todo guifg=#ebbf83 guibg=#171d23
hi Folded guifg=#41505E guibg=#171d23
hi FoldColumn guifg=#41505E guibg=#1d252c

let g:terminal_color_0 =  "#1d252c"
let g:terminal_color_1 =  "#8BD49C"
let g:terminal_color_2 =  "#68a1f0"
let g:terminal_color_3 =  "#ebbf83"
let g:terminal_color_4 =  "#70e1e8"
let g:terminal_color_5 =  "#008b94"
let g:terminal_color_6 =  "#e27e8d"
let g:terminal_color_7 =  "#b7c5d3"
let g:terminal_color_8 =  "#41505E"
let g:terminal_color_9 =  "#8BD49C"
let g:terminal_color_10 = "#68a1f0"
let g:terminal_color_11 = "#ebbf83"
let g:terminal_color_12 = "#70e1e8"
let g:terminal_color_13 = "#008b94"
let g:terminal_color_14 = "#e27e8d"
let g:terminal_color_15 = "#ffffff"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
