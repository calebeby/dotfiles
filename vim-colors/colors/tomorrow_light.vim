set bg=dark
hi clear
syntax reset
let colors_name = "tomorrow_light"

hi Normal guifg=#4d4d4c guibg=#ffffff
hi Visual guibg=#d6d6d6
hi LspReferenceText guibg=#e0e0e0
hi LspReferenceRead guibg=#e0e0e0
hi LspReferenceWrite guibg=#e0e0e0
hi VertSplit guifg=#d6d6d6 guibg=#d6d6d6 gui=none
hi StatusLine guifg=#969896 guibg=#d6d6d6 gui=none
hi StatusLineNC guifg=#8e908c guibg=#e0e0e0 gui=none
hi LineNr guifg=#8e908c guibg=#ffffff
hi CursorLineNr guifg=#969896 guibg=#ffffff
hi Cursor guifg=#ffffff guibg=#4d4d4c
hi Cursor guifg=#ffffff guibg=#4d4d4c
hi CursorLine guibg=#fafafa gui=none
hi ColorColumn guibg=#fafafa gui=none
hi NonText guifg=#e0e0e0
hi QuickFixLine guibg=#e0e0e0 gui=none
hi Error guifg=#ffffff guibg=#c82829
hi Underlined guifg=#c82829
hi Title guifg=#4271ae gui=none
hi TabLine guifg=#969896 guibg=#ffffff gui=none
hi TabLineFill guifg=#8e908c guibg=#ffffff gui=none
hi TabLineSel guifg=#4d4d4c guibg=#e0e0e0 gui=bold
hi MatchParen guibg=#d6d6d6
hi Directory guifg=#4271ae
hi IncSearch guifg=#e0e0e0 guibg=#f5871f gui=none
hi Search guifg=#e0e0e0 guibg=#eab700
hi Comment guifg=#8e908c gui=italic
hi Delimiter guifg=#6d6e6c
hi String guifg=#718c00
hi Statement guifg=#8959a8 gui=none
hi StorageClass guifg=#8959a8 gui=none
hi Type guifg=#eab700 gui=none
hi Operator guifg=#8959a8 gui=none
hi Identifier guifg=#c82829 gui=none
hi Special guifg=#3e999f gui=none
hi Constant guifg=#f5871f gui=none
hi PreProc guifg=#eab700
hi Function guifg=#4271ae
hi xmlTag guifg=#4d4d4c
hi xmlEndTag guifg=#4d4d4c
hi xmlTagName guifg=#4271ae
hi xmlTagN guifg=#4271ae
hi xmlAttrib guifg=#a3685a
hi SpellBad gui=undercurl guisp=#c82829
hi SpellLocal gui=undercurl guisp=#3e999f
hi SpellCap gui=undercurl guisp=#4271ae
hi SpellRare gui=undercurl guisp=#8959a8
hi DiagnosticError guifg=#c82829
hi DiagnosticUnderlineError gui=undercurl guisp=#c82829
hi DiagnosticWarn guifg=#f5871f
hi DiagnosticUnderlineWarn gui=undercurl guisp=#f5871f
hi DiagnosticHint guifg=#718c00
hi DiagnosticUnderlineHint gui=undercurl guisp=#718c00
hi DiagnosticInfo guifg=#4271ae
hi DiagnosticUnderlineInfo gui=undercurl guisp=#4271ae
hi DiffAdd guibg=#e2e8cc gui=none
hi DiffChange guibg=#ffffff
hi DiffDelete guifg=#f4d4d4 guibg=#f4d4d4 gui=none
hi DiffText guibg=#e2e8cc gui=none
hi NeogitDiffContext guifg=#4d4d4c guibg=#ffffff
hi NeogitDiffAdd guifg=#718c00 guibg=#ffffff
hi NeogitDiffDelete guifg=#c82829 guibg=#ffffff
hi NeogitDiffContextHighlight guifg=#4d4d4c guibg=#ffffff
hi NeogitDiffAddHighlight guifg=#718c00 guibg=#ffffff
hi NeogitDiffDeleteHighlight guifg=#c82829 guibg=#ffffff
hi DiffAdded guifg=#718c00 guibg=#ffffff
hi DiffFile guifg=#c82829 guibg=#ffffff
hi DiffNewFile guifg=#718c00 guibg=#ffffff
hi DiffLine guifg=#4271ae guibg=#ffffff
hi DiffRemoved guifg=#c82829 guibg=#ffffff
hi SignifySignAdd guifg=#718c00 guibg=#e2e8cc
hi SignifySignChange guifg=#4271ae guibg=#cfdbea
hi SignifySignDelete guifg=#c82829 gui=underline
hi SignifySignDeleteFirstLine guifg=#c82829
hi @markup.heading guifg=#4271ae gui=bold
hi @markup.list guifg=#c82829
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#c82829 guibg=#ffffff
hi @markup.underline guifg=#718c00 guibg=#ffffff
hi @markup.link.url gui=underline
hi PMenu guifg=#4d4d4c guibg=#e0e0e0 gui=none
hi PMenuSel guifg=#e0e0e0 guibg=#4d4d4c
hi Todo guifg=#eab700 guibg=#e0e0e0
hi Folded guifg=#8e908c guibg=#e0e0e0
hi FoldColumn guifg=#8e908c guibg=#ffffff

let g:terminal_color_0 =  "#ffffff"
let g:terminal_color_1 =  "#c82829"
let g:terminal_color_2 =  "#718c00"
let g:terminal_color_3 =  "#eab700"
let g:terminal_color_4 =  "#4271ae"
let g:terminal_color_5 =  "#8959a8"
let g:terminal_color_6 =  "#3e999f"
let g:terminal_color_7 =  "#4d4d4c"
let g:terminal_color_8 =  "#8e908c"
let g:terminal_color_9 =  "#c82829"
let g:terminal_color_10 = "#718c00"
let g:terminal_color_11 = "#eab700"
let g:terminal_color_12 = "#4271ae"
let g:terminal_color_13 = "#8959a8"
let g:terminal_color_14 = "#3e999f"
let g:terminal_color_15 = "#1d1f21"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
