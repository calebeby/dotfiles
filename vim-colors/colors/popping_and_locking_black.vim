set bg=dark
hi clear
syntax reset
let colors_name = "popping_and_locking_black"

hi Normal guifg=#f2e5bc guibg=#000000
hi Visual guibg=#26261c
hi LspReferenceText guibg=#1a1a1a
hi LspReferenceRead guibg=#1a1a1a
hi LspReferenceWrite guibg=#1a1a1a
hi VertSplit guifg=#26261c guibg=#26261c gui=none
hi StatusLine guifg=#d5c4a1 guibg=#26261c gui=none
hi StatusLineNC guifg=#506899 guibg=#1a1a1a gui=none
hi LineNr guifg=#506899 guibg=#000000
hi CursorLineNr guifg=#d5c4a1 guibg=#000000
hi Cursor guifg=#000000 guibg=#f2e5bc
hi Cursor guifg=#000000 guibg=#f2e5bc
hi CursorLine guibg=#070707 gui=none
hi ColorColumn guibg=#070707 gui=none
hi NonText guifg=#1a1a1a
hi QuickFixLine guibg=#1a1a1a gui=none
hi Error guifg=#000000 guibg=#99c6ca
hi Underlined guifg=#99c6ca
hi Title guifg=#fabd2f gui=none
hi TabLine guifg=#d5c4a1 guibg=#000000 gui=none
hi TabLineFill guifg=#506899 guibg=#000000 gui=none
hi TabLineSel guifg=#f2e5bc guibg=#1a1a1a gui=bold
hi MatchParen guibg=#26261c
hi IncSearch guifg=#1a1a1a guibg=#d3869b gui=none
hi Search guifg=#1a1a1a guibg=#fabd2f
hi Comment guifg=#506899 gui=italic
hi Delimiter guifg=#a1a6aa
hi String guifg=#b8bb26
hi Statement guifg=#f42c3e gui=none
hi StorageClass guifg=#f42c3e gui=none
hi Type guifg=#fabd2f gui=none
hi Operator guifg=#f42c3e gui=none
hi Identifier guifg=#99c6ca gui=none
hi Special guifg=#7ec16e gui=none
hi Constant guifg=#d3869b gui=none
hi PreProc guifg=#fabd2f
hi Function guifg=#fabd2f
hi xmlTag guifg=#f2e5bc
hi xmlEndTag guifg=#f2e5bc
hi xmlTagName guifg=#fabd2f
hi xmlTagN guifg=#fabd2f
hi xmlAttrib guifg=#928374
hi SpellBad gui=undercurl guisp=#99c6ca
hi SpellLocal gui=undercurl guisp=#7ec16e
hi SpellCap gui=undercurl guisp=#fabd2f
hi SpellRare gui=undercurl guisp=#f42c3e
hi DiagnosticError guifg=#99c6ca
hi DiagnosticUnderlineError gui=undercurl guisp=#99c6ca
hi DiagnosticWarn guifg=#d3869b
hi DiagnosticUnderlineWarn gui=undercurl guisp=#d3869b
hi DiagnosticHint guifg=#b8bb26
hi DiagnosticUnderlineHint gui=undercurl guisp=#b8bb26
hi DiagnosticInfo guifg=#fabd2f
hi DiagnosticUnderlineInfo gui=undercurl guisp=#fabd2f
hi DiffAdd guibg=#1f301b gui=none
hi DiffChange guibg=#000000
hi DiffDelete guifg=#240609 guibg=#240609 gui=none
hi DiffText guibg=#1f301b gui=none
hi DiffAdded guifg=#7ec16e guibg=#000000
hi DiffFile guifg=#f42c3e guibg=#000000
hi DiffNewFile guifg=#7ec16e guibg=#000000
hi DiffLine guifg=#fabd2f guibg=#000000
hi DiffRemoved guifg=#f42c3e guibg=#000000
hi SignifySignAdd guifg=#7ec16e guibg=#1f301b
hi SignifySignChange guifg=#fabd2f guibg=#3e2f0b
hi SignifySignDelete guifg=#f42c3e gui=underline
hi SignifySignDeleteFirstLine guifg=#f42c3e
hi PMenu guifg=#f2e5bc guibg=#1a1a1a gui=none
hi PMenuSel guifg=#1a1a1a guibg=#f2e5bc
hi Todo guifg=#fabd2f guibg=#1a1a1a
hi Folded guifg=#506899 guibg=#1a1a1a
hi FoldColumn guifg=#7ec16e guibg=#000000

let g:terminal_color_0 =  "#000000"
let g:terminal_color_1 =  "#99c6ca"
let g:terminal_color_2 =  "#b8bb26"
let g:terminal_color_3 =  "#fabd2f"
let g:terminal_color_4 =  "#fabd2f"
let g:terminal_color_5 =  "#f42c3e"
let g:terminal_color_6 =  "#7ec16e"
let g:terminal_color_7 =  "#f2e5bc"
let g:terminal_color_8 =  "#506899"
let g:terminal_color_9 =  "#99c6ca"
let g:terminal_color_10 = "#b8bb26"
let g:terminal_color_11 = "#fabd2f"
let g:terminal_color_12 = "#fabd2f"
let g:terminal_color_13 = "#f42c3e"
let g:terminal_color_14 = "#7ec16e"
let g:terminal_color_15 = "#f9f5d7"
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
