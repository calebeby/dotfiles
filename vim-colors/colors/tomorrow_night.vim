set bg=dark
hi clear
syntax reset
let colors_name = "tomorrow_night"

hi Normal guifg=#c5c8c6 guibg=#1d1f21
hi Visual guibg=#373b41
hi LspReferenceText guibg=#282a2e
hi LspReferenceRead guibg=#282a2e
hi LspReferenceWrite guibg=#282a2e
hi VertSplit guifg=#373b41 guibg=#373b41 gui=none
hi StatusLine guifg=#b4b7b4 guibg=#373b41 gui=none
hi StatusLineNC guifg=#969896 guibg=#282a2e gui=none
hi LineNr guifg=#969896 guibg=#1d1f21
hi CursorLineNr guifg=#b4b7b4 guibg=#1d1f21
hi Cursor guifg=#1d1f21 guibg=#c5c8c6
hi Cursor guifg=#1d1f21 guibg=#c5c8c6
hi CursorLine guibg=#202224 gui=none
hi ColorColumn guibg=#202224 gui=none
hi NonText guifg=#282a2e
hi QuickFixLine guibg=#282a2e gui=none
hi Error guifg=#1d1f21 guibg=#cc6666
hi Underlined guifg=#cc6666
hi Title guifg=#81a2be gui=none
hi TabLine guifg=#b4b7b4 guibg=#1d1f21 gui=none
hi TabLineFill guifg=#969896 guibg=#1d1f21 gui=none
hi TabLineSel guifg=#c5c8c6 guibg=#282a2e gui=bold
hi MatchParen guibg=#373b41
hi IncSearch guifg=#282a2e guibg=#de935f gui=none
hi Search guifg=#282a2e guibg=#f0c674
hi Comment guifg=#969896 gui=italic
hi Delimiter guifg=#adb0ae
hi String guifg=#b5bd68
hi Statement guifg=#b294bb gui=none
hi StorageClass guifg=#b294bb gui=none
hi Type guifg=#f0c674 gui=none
hi Operator guifg=#b294bb gui=none
hi Identifier guifg=#cc6666 gui=none
hi Special guifg=#8abeb7 gui=none
hi Constant guifg=#de935f gui=none
hi PreProc guifg=#f0c674
hi Function guifg=#81a2be
hi xmlTag guifg=#c5c8c6
hi xmlEndTag guifg=#c5c8c6
hi xmlTagName guifg=#81a2be
hi xmlTagN guifg=#81a2be
hi xmlAttrib guifg=#a3685a
hi SpellBad gui=undercurl guisp=#cc6666
hi SpellLocal gui=undercurl guisp=#8abeb7
hi SpellCap gui=undercurl guisp=#81a2be
hi SpellRare gui=undercurl guisp=#b294bb
hi DiagnosticError guifg=#cc6666
hi DiagnosticUnderlineError gui=undercurl guisp=#cc6666
hi DiagnosticWarn guifg=#de935f
hi DiagnosticUnderlineWarn gui=undercurl guisp=#de935f
hi DiagnosticHint guifg=#b5bd68
hi DiagnosticUnderlineHint gui=undercurl guisp=#b5bd68
hi DiagnosticInfo guifg=#81a2be
hi DiagnosticUnderlineInfo gui=undercurl guisp=#81a2be
hi DiffAdd guibg=#434632 gui=none
hi DiffChange guibg=#1d1f21
hi DiffDelete guifg=#37292b guibg=#37292b gui=none
hi DiffText guibg=#434632 gui=none
hi DiffAdded guifg=#b5bd68 guibg=#1d1f21
hi DiffFile guifg=#cc6666 guibg=#1d1f21
hi DiffNewFile guifg=#b5bd68 guibg=#1d1f21
hi DiffLine guifg=#81a2be guibg=#1d1f21
hi DiffRemoved guifg=#cc6666 guibg=#1d1f21
hi SignifySignAdd guifg=#b5bd68 guibg=#434632
hi SignifySignChange guifg=#81a2be guibg=#363f48
hi SignifySignDelete guifg=#cc6666 gui=underline
hi SignifySignDeleteFirstLine guifg=#cc6666
hi @markup.heading guifg=#81a2be gui=bold
hi @markup.list guifg=#cc6666
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#cc6666 guibg=#1d1f21
hi @markup.underline guifg=#b5bd68 guibg=#1d1f21
hi @markup.link.url gui=underline
hi PMenu guifg=#c5c8c6 guibg=#282a2e gui=none
hi PMenuSel guifg=#282a2e guibg=#c5c8c6
hi Todo guifg=#f0c674 guibg=#282a2e
hi Folded guifg=#969896 guibg=#282a2e
hi FoldColumn guifg=#8abeb7 guibg=#1d1f21

let g:terminal_color_0 =  "#1d1f21"
let g:terminal_color_1 =  "#cc6666"
let g:terminal_color_2 =  "#b5bd68"
let g:terminal_color_3 =  "#f0c674"
let g:terminal_color_4 =  "#81a2be"
let g:terminal_color_5 =  "#b294bb"
let g:terminal_color_6 =  "#8abeb7"
let g:terminal_color_7 =  "#c5c8c6"
let g:terminal_color_8 =  "#969896"
let g:terminal_color_9 =  "#cc6666"
let g:terminal_color_10 = "#b5bd68"
let g:terminal_color_11 = "#f0c674"
let g:terminal_color_12 = "#81a2be"
let g:terminal_color_13 = "#b294bb"
let g:terminal_color_14 = "#8abeb7"
let g:terminal_color_15 = "#ffffff"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
