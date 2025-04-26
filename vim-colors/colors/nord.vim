set bg=dark
hi clear
syntax reset
let colors_name = "nord"
hi Normal guifg=#E5E9F0 guibg=#2E3440
hi Visual guibg=#434C5E
hi LspReferenceText guibg=#3B4252
hi LspReferenceRead guibg=#3B4252
hi LspReferenceWrite guibg=#3B4252
hi VertSplit guifg=#434C5E guibg=#434C5E gui=none
hi StatusLine guifg=#D8DEE9 guibg=#434C5E gui=none
hi StatusLineNC guifg=#4C566A guibg=#3B4252 gui=none
hi LineNr guifg=#4C566A guibg=#2E3440
hi CursorLineNr guifg=#D8DEE9 guibg=#2E3440
hi Cursor guifg=#2E3440 guibg=#E5E9F0
hi CursorLine guibg=#2f3642 gui=none
hi ColorColumn guibg=#2f3642 gui=none
hi SignColumn guifg=#E5E9F0 guibg=#3B4252 gui=none
hi NonText guifg=#3B4252
hi QuickFixLine guibg=#3B4252 gui=none
hi Error guifg=#2E3440 guibg=#88C0D0
hi Underlined guifg=#88C0D0
hi Title guifg=#EBCB8B gui=none
hi TabLine guifg=#D8DEE9 guibg=#2E3440 gui=none
hi TabLineFill guifg=#4C566A guibg=#2E3440 gui=none
hi TabLineSel guifg=#E5E9F0 guibg=#3B4252 gui=bold
hi MatchParen guibg=#434C5E
hi Directory guifg=#EBCB8B
hi IncSearch guifg=#3B4252 guibg=#81A1C1 gui=none
hi Search guifg=#3B4252 guibg=#5E81AC
hi Comment guifg=#4C566A gui=italic
hi Delimiter guifg=#989fad
hi String guifg=#A3BE8C
hi Statement guifg=#BF616A gui=none
hi StorageClass guifg=#BF616A gui=none
hi Type guifg=#5E81AC gui=none
hi Operator guifg=#BF616A gui=none
hi Identifier guifg=#88C0D0
hi Special guifg=#D08770
hi Constant guifg=#81A1C1
hi PreProc guifg=#5E81AC
hi Function guifg=#EBCB8B
hi xmlTag guifg=#E5E9F0
hi xmlEndTag guifg=#E5E9F0
hi xmlTagName guifg=#EBCB8B
hi xmlTagN guifg=#EBCB8B
hi xmlAttrib guifg=#B48EAD
hi SpellBad gui=undercurl guisp=#88C0D0
hi SpellLocal gui=undercurl guisp=#D08770
hi SpellCap gui=undercurl guisp=#EBCB8B
hi SpellRare gui=undercurl guisp=#BF616A
hi DiagnosticError guifg=#88C0D0
hi DiagnosticUnderlineError gui=undercurl guisp=#88C0D0
hi DiagnosticWarn guifg=#81A1C1
hi DiagnosticUnderlineWarn gui=undercurl guisp=#81A1C1
hi DiagnosticHint guifg=#A3BE8C
hi DiagnosticUnderlineHint gui=undercurl guisp=#A3BE8C
hi DiagnosticInfo guifg=#EBCB8B
hi DiagnosticUnderlineInfo gui=undercurl guisp=#EBCB8B
hi DiffAdd guibg=#454f4f gui=none
hi DiffChange guibg=#2E3440
hi DiffDelete guifg=#4b3d48 guibg=#4b3d48 gui=none
hi DiffText guibg=#454f4f gui=none
hi NeogitDiffContext guifg=#E5E9F0 guibg=#2E3440
hi NeogitDiffAdd guifg=#A3BE8C guibg=#2E3440
hi NeogitDiffDelete guifg=#BF616A guibg=#2E3440
hi NeogitDiffContextHighlight guifg=#E5E9F0 guibg=#2E3440
hi NeogitDiffAddHighlight guifg=#A3BE8C guibg=#2E3440
hi NeogitDiffDeleteHighlight guifg=#BF616A guibg=#2E3440
hi NeogitHunkHeader guifg=#E5E9F0 guibg=#3B4252
hi NeogitHunkHeaderHighlight guifg=#E5E9F0 guibg=#3B4252
hi DiffAdded guifg=#A3BE8C guibg=#2E3440
hi DiffFile guifg=#BF616A guibg=#2E3440
hi DiffNewFile guifg=#A3BE8C guibg=#2E3440
hi DiffLine guifg=#EBCB8B guibg=#2E3440
hi DiffRemoved guifg=#BF616A guibg=#2E3440
hi SignifySignAdd guifg=#A3BE8C guibg=#454f4f
hi SignifySignChange guifg=#EBCB8B guibg=#5d5952
hi SignifySignDelete guifg=#BF616A gui=underline
hi SignifySignDeleteFirstLine guifg=#BF616A
hi @markup.heading guifg=#EBCB8B gui=bold
hi @markup.list guifg=#88C0D0
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#BF616A guibg=#2E3440
hi @markup.underline guifg=#A3BE8C guibg=#2E3440
hi @markup.link.url gui=underline
hi PMenu guifg=#E5E9F0 guibg=#3B4252
hi PMenuSel guifg=#3B4252 guibg=#E5E9F0
hi Todo guifg=#5E81AC guibg=#3B4252
hi Folded guifg=#4C566A guibg=#3B4252
hi FoldColumn guifg=#4C566A guibg=#2E3440

let g:terminal_color_0  = "#2E3440"
let g:terminal_color_1  = "#88C0D0"
let g:terminal_color_2  = "#A3BE8C"
let g:terminal_color_3  = "#5E81AC"
let g:terminal_color_4  = "#EBCB8B"
let g:terminal_color_5  = "#BF616A"
let g:terminal_color_6  = "#D08770"
let g:terminal_color_7  = "#E5E9F0"
let g:terminal_color_8  = "#4C566A"
let g:terminal_color_9  = "#88C0D0"
let g:terminal_color_10 = "#A3BE8C"
let g:terminal_color_11 = "#5E81AC"
let g:terminal_color_12 = "#EBCB8B"
let g:terminal_color_13 = "#BF616A"
let g:terminal_color_14 = "#D08770"
let g:terminal_color_15 = "#8FBCBB"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5

