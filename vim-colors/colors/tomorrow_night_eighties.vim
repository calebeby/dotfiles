set bg=dark
hi clear
syntax reset
let colors_name = "tomorrow_night_eighties"

hi Normal guifg=#cccccc guibg=#2d2d2d
hi Visual guibg=#515151
hi LspReferenceText guibg=#393939
hi LspReferenceRead guibg=#393939
hi LspReferenceWrite guibg=#393939
hi VertSplit guifg=#515151 guibg=#515151 gui=none
hi StatusLine guifg=#b4b7b4 guibg=#515151 gui=none
hi StatusLineNC guifg=#999999 guibg=#393939 gui=none
hi LineNr guifg=#999999 guibg=#2d2d2d
hi CursorLineNr guifg=#b4b7b4 guibg=#2d2d2d
hi Cursor guifg=#2d2d2d guibg=#cccccc
hi Cursor guifg=#2d2d2d guibg=#cccccc
hi CursorLine guibg=#2e2e2e gui=none
hi ColorColumn guibg=#2e2e2e gui=none
hi SignColumn guifg=#cccccc guibg=#393939 gui=none
hi NonText guifg=#393939
hi QuickFixLine guibg=#393939 gui=none
hi Error guifg=#2d2d2d guibg=#f2777a
hi Underlined guifg=#f2777a
hi Title guifg=#6699cc gui=none
hi TabLine guifg=#b4b7b4 guibg=#2d2d2d gui=none
hi TabLineFill guifg=#999999 guibg=#2d2d2d gui=none
hi TabLineSel guifg=#cccccc guibg=#393939 gui=bold
hi MatchParen guibg=#515151
hi Directory guifg=#6699cc
hi IncSearch guifg=#393939 guibg=#f99157 gui=none
hi Search guifg=#393939 guibg=#ffcc66
hi Comment guifg=#999999 gui=italic
hi Delimiter guifg=#b2b2b2
hi String guifg=#99cc99
hi Statement guifg=#cc99cc gui=none
hi StorageClass guifg=#cc99cc gui=none
hi Type guifg=#ffcc66 gui=none
hi Operator guifg=#cc99cc gui=none
hi Identifier guifg=#f2777a gui=none
hi Special guifg=#66cccc gui=none
hi Constant guifg=#f99157 gui=none
hi PreProc guifg=#ffcc66
hi Function guifg=#6699cc
hi xmlTag guifg=#cccccc
hi xmlEndTag guifg=#cccccc
hi xmlTagName guifg=#6699cc
hi xmlTagN guifg=#6699cc
hi xmlAttrib guifg=#a3685a
hi SpellBad gui=undercurl guisp=#f2777a
hi SpellLocal gui=undercurl guisp=#66cccc
hi SpellCap gui=undercurl guisp=#6699cc
hi SpellRare gui=undercurl guisp=#cc99cc
hi DiagnosticError guifg=#f2777a
hi DiagnosticUnderlineError gui=undercurl guisp=#f2777a
hi DiagnosticWarn guifg=#f99157
hi DiagnosticUnderlineWarn gui=undercurl guisp=#f99157
hi DiagnosticHint guifg=#99cc99
hi DiagnosticUnderlineHint gui=undercurl guisp=#99cc99
hi DiagnosticInfo guifg=#6699cc
hi DiagnosticUnderlineInfo gui=undercurl guisp=#6699cc
hi DiffAdd guibg=#424c42 gui=none
hi DiffChange guibg=#2d2d2d
hi DiffDelete guifg=#543b3c guibg=#543b3c gui=none
hi DiffText guibg=#424c42 gui=none
hi NeogitDiffContext guifg=#cccccc guibg=#2d2d2d
hi NeogitDiffAdd guifg=#99cc99 guibg=#2d2d2d
hi NeogitDiffDelete guifg=#f2777a guibg=#2d2d2d
hi NeogitDiffContextHighlight guifg=#cccccc guibg=#2d2d2d
hi NeogitDiffAddHighlight guifg=#99cc99 guibg=#2d2d2d
hi NeogitDiffDeleteHighlight guifg=#f2777a guibg=#2d2d2d
hi NeogitHunkHeader guifg=#cccccc guibg=#393939
hi NeogitHunkHeaderHighlight guifg=#cccccc guibg=#393939
hi DiffAdded guifg=#99cc99 guibg=#2d2d2d
hi DiffFile guifg=#f2777a guibg=#2d2d2d
hi DiffNewFile guifg=#99cc99 guibg=#2d2d2d
hi DiffLine guifg=#6699cc guibg=#2d2d2d
hi DiffRemoved guifg=#f2777a guibg=#2d2d2d
hi SignifySignAdd guifg=#99cc99 guibg=#424c42
hi SignifySignChange guifg=#6699cc guibg=#3b4854
hi SignifySignDelete guifg=#f2777a gui=underline
hi SignifySignDeleteFirstLine guifg=#f2777a
hi @markup.heading guifg=#6699cc gui=bold
hi @markup.list guifg=#f2777a
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#f2777a guibg=#2d2d2d
hi @markup.underline guifg=#99cc99 guibg=#2d2d2d
hi @markup.link.url gui=underline
hi PMenu guifg=#cccccc guibg=#393939 gui=none
hi PMenuSel guifg=#393939 guibg=#cccccc
hi Todo guifg=#ffcc66 guibg=#393939
hi Folded guifg=#999999 guibg=#393939
hi FoldColumn guifg=#999999 guibg=#2d2d2d

let g:terminal_color_0 =  "#2d2d2d"
let g:terminal_color_1 =  "#f2777a"
let g:terminal_color_2 =  "#99cc99"
let g:terminal_color_3 =  "#ffcc66"
let g:terminal_color_4 =  "#6699cc"
let g:terminal_color_5 =  "#cc99cc"
let g:terminal_color_6 =  "#66cccc"
let g:terminal_color_7 =  "#cccccc"
let g:terminal_color_8 =  "#999999"
let g:terminal_color_9 =  "#f2777a"
let g:terminal_color_10 = "#99cc99"
let g:terminal_color_11 = "#ffcc66"
let g:terminal_color_12 = "#6699cc"
let g:terminal_color_13 = "#cc99cc"
let g:terminal_color_14 = "#66cccc"
let g:terminal_color_15 = "#ffffff"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
