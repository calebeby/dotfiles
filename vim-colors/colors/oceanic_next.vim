set bg=dark
hi clear
syntax reset
let colors_name = "oceanic_next"

hi Normal guifg=#C0C5CE guibg=#1B2B34
hi Visual guibg=#4F5B66
hi LspReferenceText guibg=#343D46
hi LspReferenceRead guibg=#343D46
hi LspReferenceWrite guibg=#343D46
hi VertSplit guifg=#4F5B66 guibg=#4F5B66 gui=none
hi StatusLine guifg=#A7ADBA guibg=#4F5B66 gui=none
hi StatusLineNC guifg=#65737E guibg=#343D46 gui=none
hi LineNr guifg=#65737E guibg=#1B2B34
hi CursorLineNr guifg=#A7ADBA guibg=#1B2B34
hi Cursor guifg=#1B2B34 guibg=#C0C5CE
hi Cursor guifg=#1B2B34 guibg=#C0C5CE
hi CursorLine guibg=#223039 gui=none
hi ColorColumn guibg=#223039 gui=none
hi NonText guifg=#343D46
hi QuickFixLine guibg=#343D46 gui=none
hi Error guifg=#1B2B34 guibg=#EC5f67
hi Underlined guifg=#EC5f67
hi Title guifg=#6699CC gui=none
hi TabLine guifg=#A7ADBA guibg=#1B2B34 gui=none
hi TabLineFill guifg=#65737E guibg=#1B2B34 gui=none
hi TabLineSel guifg=#C0C5CE guibg=#343D46 gui=bold
hi MatchParen guibg=#4F5B66
hi IncSearch guifg=#343D46 guibg=#F99157 gui=none
hi Search guifg=#343D46 guibg=#FAC863
hi Comment guifg=#65737E gui=italic
hi Delimiter guifg=#929ca6
hi String guifg=#99C794
hi Statement guifg=#C594C5 gui=none
hi StorageClass guifg=#C594C5 gui=none
hi Type guifg=#FAC863 gui=none
hi Operator guifg=#C594C5 gui=none
hi Identifier guifg=#EC5f67 gui=none
hi Special guifg=#5FB3B3 gui=none
hi Constant guifg=#F99157 gui=none
hi PreProc guifg=#FAC863
hi Function guifg=#6699CC
hi xmlTag guifg=#C0C5CE
hi xmlEndTag guifg=#C0C5CE
hi xmlTagName guifg=#6699CC
hi xmlTagN guifg=#6699CC
hi xmlAttrib guifg=#AB7967
hi SpellBad gui=undercurl guisp=#EC5f67
hi SpellLocal gui=undercurl guisp=#5FB3B3
hi SpellCap gui=undercurl guisp=#6699CC
hi SpellRare gui=undercurl guisp=#C594C5
hi DiagnosticError guifg=#EC5f67
hi DiagnosticUnderlineError gui=undercurl guisp=#EC5f67
hi DiagnosticWarn guifg=#F99157
hi DiagnosticUnderlineWarn gui=undercurl guisp=#F99157
hi DiagnosticHint guifg=#99C794
hi DiagnosticUnderlineHint gui=undercurl guisp=#99C794
hi DiagnosticInfo guifg=#6699CC
hi DiagnosticUnderlineInfo gui=undercurl guisp=#6699CC
hi DiffAdd guibg=#3a524c gui=none
hi DiffChange guibg=#1B2B34
hi DiffDelete guifg=#3a323b guibg=#3a323b gui=none
hi DiffText guibg=#3a524c gui=none
hi DiffAdded guifg=#99C794 guibg=#1B2B34
hi DiffFile guifg=#EC5f67 guibg=#1B2B34
hi DiffNewFile guifg=#99C794 guibg=#1B2B34
hi DiffLine guifg=#6699CC guibg=#1B2B34
hi DiffRemoved guifg=#EC5f67 guibg=#1B2B34
hi SignifySignAdd guifg=#99C794 guibg=#3a524c
hi SignifySignChange guifg=#6699CC guibg=#2d465a
hi SignifySignDelete guifg=#EC5f67 gui=underline
hi SignifySignDeleteFirstLine guifg=#EC5f67
hi PMenu guifg=#C0C5CE guibg=#343D46 gui=none
hi PMenuSel guifg=#343D46 guibg=#C0C5CE
hi Todo guifg=#FAC863 guibg=#343D46
hi Folded guifg=#65737E guibg=#343D46
hi FoldColumn guifg=#5FB3B3 guibg=#1B2B34

let g:terminal_color_0 =  "#1B2B34"
let g:terminal_color_1 =  "#EC5f67"
let g:terminal_color_2 =  "#99C794"
let g:terminal_color_3 =  "#FAC863"
let g:terminal_color_4 =  "#6699CC"
let g:terminal_color_5 =  "#C594C5"
let g:terminal_color_6 =  "#5FB3B3"
let g:terminal_color_7 =  "#C0C5CE"
let g:terminal_color_8 =  "#65737E"
let g:terminal_color_9 =  "#EC5f67"
let g:terminal_color_10 = "#99C794"
let g:terminal_color_11 = "#FAC863"
let g:terminal_color_12 = "#6699CC"
let g:terminal_color_13 = "#C594C5"
let g:terminal_color_14 = "#5FB3B3"
let g:terminal_color_15 = "#D8DEE9"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5

" TS stands for Tree Sitter, not TypeScript
hi link TSInclude Keyword
hi link TSVariable Identifier
hi link TSVariableBuiltin Identifier
hi link TSProperty Normal
hi link TSField Normal
hi link TSConstant TSVariable
hi link TSConstBuiltin TSVariable
hi link TSFuncBuiltin TSFunction
hi link TSTag xmlTagN

" This gets used for capitalized imports
hi link typescriptTSConstructor TSVariable
hi link tsxTSConstructor TSVariable
hi link javascriptTSConstructor TSVariable

" This gets used for namespace imports
hi link typescriptTSNamespace TSVariable
hi link tsxTSNamespace TSVariable
hi link javascriptTSNamespace TSVariable

hi link regexTSConstant TSStringRegex
