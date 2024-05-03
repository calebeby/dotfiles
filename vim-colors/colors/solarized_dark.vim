set bg=dark
hi clear
syntax reset
let colors_name = "solarized_dark"

hi Normal guifg=#93a1a1 guibg=#002b36
hi Visual guibg=#586e75
hi LspReferenceText guibg=#073642
hi LspReferenceRead guibg=#073642
hi LspReferenceWrite guibg=#073642
hi VertSplit guifg=#586e75 guibg=#586e75 gui=none
hi StatusLine guifg=#839496 guibg=#586e75 gui=none
hi StatusLineNC guifg=#657b83 guibg=#073642 gui=none
hi LineNr guifg=#657b83 guibg=#002b36
hi CursorLineNr guifg=#839496 guibg=#002b36
hi Cursor guifg=#002b36 guibg=#93a1a1
hi Cursor guifg=#002b36 guibg=#93a1a1
hi CursorLine guibg=#012c37 gui=none
hi ColorColumn guibg=#012c37 gui=none
hi SignColumn guifg=#93a1a1 guibg=#073642 gui=none
hi NonText guifg=#073642
hi QuickFixLine guibg=#073642 gui=none
hi Error guifg=#002b36 guibg=#dc322f
hi Underlined guifg=#dc322f
hi Title guifg=#268bd2 gui=none
hi TabLine guifg=#839496 guibg=#002b36 gui=none
hi TabLineFill guifg=#657b83 guibg=#002b36 gui=none
hi TabLineSel guifg=#93a1a1 guibg=#073642 gui=bold
hi MatchParen guibg=#586e75
hi Directory guifg=#268bd2
hi IncSearch guifg=#073642 guibg=#cb4b16 gui=none
hi Search guifg=#073642 guibg=#b58900
hi Comment guifg=#657b83 gui=italic
hi Delimiter guifg=#7c8e92
hi String guifg=#859900
hi Statement guifg=#6c71c4 gui=none
hi StorageClass guifg=#6c71c4 gui=none
hi Type guifg=#b58900 gui=none
hi Operator guifg=#6c71c4 gui=none
hi Identifier guifg=#dc322f gui=none
hi Special guifg=#2aa198 gui=none
hi Constant guifg=#cb4b16 gui=none
hi PreProc guifg=#b58900
hi Function guifg=#268bd2
hi xmlTag guifg=#93a1a1
hi xmlEndTag guifg=#93a1a1
hi xmlTagName guifg=#268bd2
hi xmlTagN guifg=#268bd2
hi xmlAttrib guifg=#d33682
hi SpellBad gui=undercurl guisp=#dc322f
hi SpellLocal gui=undercurl guisp=#2aa198
hi SpellCap gui=undercurl guisp=#268bd2
hi SpellRare gui=undercurl guisp=#6c71c4
hi DiagnosticError guifg=#dc322f
hi DiagnosticUnderlineError gui=undercurl guisp=#dc322f
hi DiagnosticWarn guifg=#cb4b16
hi DiagnosticUnderlineWarn gui=undercurl guisp=#cb4b16
hi DiagnosticHint guifg=#859900
hi DiagnosticUnderlineHint gui=undercurl guisp=#859900
hi DiagnosticInfo guifg=#268bd2
hi DiagnosticUnderlineInfo gui=undercurl guisp=#268bd2
hi DiffAdd guibg=#1a412b gui=none
hi DiffChange guibg=#002b36
hi DiffDelete guifg=#2c2c34 guibg=#2c2c34 gui=none
hi DiffText guibg=#1a412b gui=none
hi NeogitDiffContext guifg=#93a1a1 guibg=#002b36
hi NeogitDiffAdd guifg=#859900 guibg=#002b36
hi NeogitDiffDelete guifg=#dc322f guibg=#002b36
hi NeogitDiffContextHighlight guifg=#93a1a1 guibg=#002b36
hi NeogitDiffAddHighlight guifg=#859900 guibg=#002b36
hi NeogitDiffDeleteHighlight guifg=#dc322f guibg=#002b36
hi NeogitHunkHeader guifg=#93a1a1 guibg=#073642
hi NeogitHunkHeaderHighlight guifg=#93a1a1 guibg=#073642
hi DiffAdded guifg=#859900 guibg=#002b36
hi DiffFile guifg=#dc322f guibg=#002b36
hi DiffNewFile guifg=#859900 guibg=#002b36
hi DiffLine guifg=#268bd2 guibg=#002b36
hi DiffRemoved guifg=#dc322f guibg=#002b36
hi SignifySignAdd guifg=#859900 guibg=#1a412b
hi SignifySignChange guifg=#268bd2 guibg=#09435d
hi SignifySignDelete guifg=#dc322f gui=underline
hi SignifySignDeleteFirstLine guifg=#dc322f
hi @markup.heading guifg=#268bd2 gui=bold
hi @markup.list guifg=#dc322f
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#dc322f guibg=#002b36
hi @markup.underline guifg=#859900 guibg=#002b36
hi @markup.link.url gui=underline
hi PMenu guifg=#93a1a1 guibg=#073642 gui=none
hi PMenuSel guifg=#073642 guibg=#93a1a1
hi Todo guifg=#b58900 guibg=#073642
hi Folded guifg=#657b83 guibg=#073642
hi FoldColumn guifg=#657b83 guibg=#002b36

let g:terminal_color_0 =  "#002b36"
let g:terminal_color_1 =  "#dc322f"
let g:terminal_color_2 =  "#859900"
let g:terminal_color_3 =  "#b58900"
let g:terminal_color_4 =  "#268bd2"
let g:terminal_color_5 =  "#6c71c4"
let g:terminal_color_6 =  "#2aa198"
let g:terminal_color_7 =  "#93a1a1"
let g:terminal_color_8 =  "#657b83"
let g:terminal_color_9 =  "#dc322f"
let g:terminal_color_10 = "#859900"
let g:terminal_color_11 = "#b58900"
let g:terminal_color_12 = "#268bd2"
let g:terminal_color_13 = "#6c71c4"
let g:terminal_color_14 = "#2aa198"
let g:terminal_color_15 = "#fdf6e3"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
