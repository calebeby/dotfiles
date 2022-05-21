set bg=dark
hi clear
syntax reset
let colors_name = "solarized_dark"

hi Normal guifg=#93a1a1 guibg=#002b36
hi Visual guibg=#586e75
hi VertSplit guifg=#586e75 guibg=#586e75 gui=none
hi StatusLine guifg=#839496 guibg=#586e75 gui=none
hi StatusLineNC guifg=#657b83 guibg=#073642 gui=none
hi LineNr guifg=#657b83 guibg=#002b36
hi CursorLineNr guifg=#839496 guibg=#002b36
hi Cursor guifg=#002b36 guibg=#93a1a1
hi Cursor guifg=#002b36 guibg=#93a1a1
hi CursorLine guibg=#022e39 gui=none
hi ColorColumn guibg=#022e39 gui=none
hi NonText guifg=#657b83
hi QuickFixLine guibg=#073642 gui=none
hi Error guifg=#002b36 guibg=#dc322f
hi Underlined guifg=#dc322f
hi Title guifg=#268bd2 gui=none
hi TabLine guifg=#839496 guibg=#002b36 gui=none
hi TabLineFill guifg=#657b83 guibg=#002b36 gui=none
hi TabLineSel guifg=#93a1a1 guibg=#073642 gui=bold
hi MatchParen guibg=#586e75
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
hi CocHighlightText guifg=#93a1a1 guibg=#073642
hi CocErrorSign guifg=#dc322f
hi CocErrorHighlight gui=undercurl guisp=#dc322f
hi CocWarningSign guifg=#cb4b16
hi CocWarningHighlight gui=undercurl guisp=#cb4b16
hi CocHintSign guifg=#859900
hi CocHintHighlight gui=undercurl guisp=#859900
hi CocInfoSign guifg=#268bd2
hi CocInfoHighlight gui=undercurl guisp=#268bd2
hi CocUnusedHighlight gui=undercurl guisp=#d33682
hi DiffAdd guibg=#214628 gui=none
hi DiffChange guibg=#002b36
hi DiffDelete guifg=#212c34 guibg=#212c34 gui=none
hi DiffText guibg=#214628 gui=none
hi DiffAdded guifg=#859900 guibg=#002b36
hi DiffFile guifg=#dc322f guibg=#002b36
hi DiffNewFile guifg=#859900 guibg=#002b36
hi DiffLine guifg=#268bd2 guibg=#002b36
hi DiffRemoved guifg=#dc322f guibg=#002b36
hi SignifySignAdd guifg=#859900 guibg=#214628
hi SignifySignChange guifg=#268bd2 guibg=#09435d
hi SignifySignDelete guifg=#dc322f gui=underline
hi SignifySignDeleteFirstLine guifg=#dc322f
hi PMenu guifg=#93a1a1 guibg=#073642 gui=none
hi PMenuSel guifg=#073642 guibg=#93a1a1
hi Todo guifg=#b58900 guibg=#073642
hi Folded guifg=#657b83 guibg=#073642
hi FoldColumn guifg=#2aa198 guibg=#002b36

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
