set bg=dark
hi clear
syntax reset
let colors_name = "tomorrow_light"

hi Normal guifg=#4d4d4c guibg=#ffffff
hi Visual guibg=#d6d6d6
hi VertSplit guifg=#d6d6d6 guibg=#d6d6d6 gui=none
hi StatusLine guifg=#969896 guibg=#d6d6d6 gui=none
hi StatusLineNC guifg=#8e908c guibg=#e0e0e0 gui=none
hi LineNr guifg=#8e908c guibg=#ffffff
hi CursorLineNr guifg=#969896 guibg=#ffffff
hi Cursor guifg=#ffffff guibg=#4d4d4c
hi Cursor guifg=#ffffff guibg=#4d4d4c
hi CursorLine guibg=#f5f5f5 gui=none
hi ColorColumn guibg=#f5f5f5 gui=none
hi NonText guifg=#8e908c
hi QuickFixLine guibg=#e0e0e0 gui=none
hi Error guifg=#ffffff guibg=#c82829
hi Underlined guifg=#c82829
hi Title guifg=#4271ae gui=none
hi TabLine guifg=#969896 guibg=#ffffff gui=none
hi TabLineFill guifg=#8e908c guibg=#ffffff gui=none
hi TabLineSel guifg=#4d4d4c guibg=#e0e0e0 gui=bold
hi MatchParen guibg=#d6d6d6
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
hi CocHighlightText guifg=#4d4d4c guibg=#e0e0e0
hi CocErrorSign guifg=#c82829
hi CocErrorHighlight gui=undercurl guisp=#c82829
hi CocWarningSign guifg=#f5871f
hi CocWarningHighlight gui=undercurl guisp=#f5871f
hi CocHintSign guifg=#718c00
hi CocHintHighlight gui=undercurl guisp=#718c00
hi CocInfoSign guifg=#4271ae
hi CocInfoHighlight gui=undercurl guisp=#4271ae
hi DiffAdd guibg=#dbe2bf gui=none
hi DiffChange guibg=#ffffff
hi DiffDelete guifg=#f6dede guibg=#f6dede gui=none
hi DiffText guibg=#dbe2bf gui=none
hi DiffAdded guifg=#718c00 guibg=#ffffff
hi DiffFile guifg=#c82829 guibg=#ffffff
hi DiffNewFile guifg=#718c00 guibg=#ffffff
hi DiffLine guifg=#4271ae guibg=#ffffff
hi DiffRemoved guifg=#c82829 guibg=#ffffff
hi SignifySignAdd guifg=#718c00 guibg=#dbe2bf
hi SignifySignChange guifg=#4271ae guibg=#cfdbea
hi SignifySignDelete guifg=#c82829 gui=underline
hi SignifySignDeleteFirstLine guifg=#c82829
hi PMenu guifg=#4d4d4c guibg=#e0e0e0 gui=none
hi PMenuSel guifg=#e0e0e0 guibg=#4d4d4c
hi Todo guifg=#eab700 guibg=#e0e0e0
hi Folded guifg=#8e908c guibg=#e0e0e0
hi FoldColumn guifg=#3e999f guibg=#ffffff

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
