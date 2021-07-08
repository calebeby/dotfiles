set bg=dark
hi clear
syntax reset
let colors_name = "solarized_light"

hi Normal guifg=#586e75 guibg=#fdf6e3
hi Visual guibg=#93a1a1
hi VertSplit guifg=#93a1a1 guibg=#93a1a1 gui=none
hi StatusLine guifg=#657b83 guibg=#93a1a1 gui=none
hi StatusLineNC guifg=#839496 guibg=#eee8d5 gui=none
hi LineNr guifg=#839496 guibg=#fdf6e3
hi CursorLineNr guifg=#657b83 guibg=#fdf6e3
hi Cursor guifg=#fdf6e3 guibg=#586e75
hi Cursor guifg=#fdf6e3 guibg=#586e75
hi CursorLine guibg=#f8f1de gui=none
hi ColorColumn guibg=#f8f1de gui=none
hi NonText guifg=#839496
hi QuickFixLine guibg=#eee8d5 gui=none
hi Error guifg=#fdf6e3 guibg=#dc322f
hi Underlined guifg=#dc322f
hi Title guifg=#268bd2 gui=none
hi TabLine guifg=#657b83 guibg=#fdf6e3 gui=none
hi TabLineFill guifg=#839496 guibg=#fdf6e3 gui=none
hi TabLineSel guifg=#586e75 guibg=#eee8d5 gui=bold
hi MatchParen guibg=#93a1a1
hi IncSearch guifg=#eee8d5 guibg=#cb4b16 gui=none
hi Search guifg=#eee8d5 guibg=#b58900
hi Comment guifg=#839496 gui=italic
hi Delimiter guifg=#6d8185
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
hi xmlTag guifg=#586e75
hi xmlEndTag guifg=#586e75
hi xmlTagName guifg=#268bd2
hi xmlTagN guifg=#268bd2
hi xmlAttrib guifg=#d33682
hi SpellBad gui=undercurl guisp=#dc322f
hi SpellLocal gui=undercurl guisp=#2aa198
hi SpellCap gui=undercurl guisp=#268bd2
hi SpellRare gui=undercurl guisp=#6c71c4
hi CocHighlightText guifg=#586e75 guibg=#eee8d5
hi CocErrorSign guifg=#dc322f
hi CocErrorHighlight gui=undercurl guisp=#dc322f
hi CocWarningSign guifg=#cb4b16
hi CocWarningHighlight gui=undercurl guisp=#cb4b16
hi CocHintSign guifg=#859900
hi CocHintHighlight gui=undercurl guisp=#859900
hi CocInfoSign guifg=#268bd2
hi CocInfoHighlight gui=undercurl guisp=#268bd2
hi DiffAdd guibg=#dfdeaa gui=none
hi DiffChange guibg=#fdf6e3
hi DiffDelete guifg=#f8d8c8 guibg=#f8d8c8 gui=none
hi DiffText guibg=#dfdeaa gui=none
hi DiffAdded guifg=#859900 guibg=#fdf6e3
hi DiffFile guifg=#dc322f guibg=#fdf6e3
hi DiffNewFile guifg=#859900 guibg=#fdf6e3
hi DiffLine guifg=#268bd2 guibg=#fdf6e3
hi DiffRemoved guifg=#dc322f guibg=#fdf6e3
hi SignifySignAdd guifg=#859900 guibg=#dfdeaa
hi SignifySignChange guifg=#268bd2 guibg=#c7dbde
hi SignifySignDelete guifg=#dc322f gui=underline
hi SignifySignDeleteFirstLine guifg=#dc322f
hi PMenu guifg=#586e75 guibg=#eee8d5 gui=none
hi PMenuSel guifg=#eee8d5 guibg=#586e75
hi Todo guifg=#b58900 guibg=#eee8d5
hi Folded guifg=#839496 guibg=#eee8d5
hi FoldColumn guifg=#2aa198 guibg=#fdf6e3

let g:terminal_color_0 =  "#fdf6e3"
let g:terminal_color_1 =  "#dc322f"
let g:terminal_color_2 =  "#859900"
let g:terminal_color_3 =  "#b58900"
let g:terminal_color_4 =  "#268bd2"
let g:terminal_color_5 =  "#6c71c4"
let g:terminal_color_6 =  "#2aa198"
let g:terminal_color_7 =  "#586e75"
let g:terminal_color_8 =  "#839496"
let g:terminal_color_9 =  "#dc322f"
let g:terminal_color_10 = "#859900"
let g:terminal_color_11 = "#b58900"
let g:terminal_color_12 = "#268bd2"
let g:terminal_color_13 = "#6c71c4"
let g:terminal_color_14 = "#2aa198"
let g:terminal_color_15 = "#002b36"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5

" TS stands for Tree Sitter, not TypeScript
hi link TSInclude Keyword
hi link TSVariable Identifier
hi link TSVariableBuiltin Identifier
hi link TSProperty Normal
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
