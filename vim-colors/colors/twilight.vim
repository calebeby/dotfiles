set bg=dark
hi clear
syntax reset
let colors_name = "twilight"

hi Normal guifg=#a7a7a7 guibg=#1e1e1e
hi Visual guibg=#464b50
hi LspReferenceText guibg=#323537
hi LspReferenceRead guibg=#323537
hi LspReferenceWrite guibg=#323537
hi VertSplit guifg=#464b50 guibg=#464b50 gui=none
hi StatusLine guifg=#838184 guibg=#464b50 gui=none
hi StatusLineNC guifg=#5f5a60 guibg=#323537 gui=none
hi LineNr guifg=#5f5a60 guibg=#1e1e1e
hi CursorLineNr guifg=#838184 guibg=#1e1e1e
hi Cursor guifg=#1e1e1e guibg=#a7a7a7
hi Cursor guifg=#1e1e1e guibg=#a7a7a7
hi CursorLine guibg=#242425 gui=none
hi ColorColumn guibg=#242425 gui=none
hi NonText guifg=#323537
hi QuickFixLine guibg=#323537 gui=none
hi Error guifg=#1e1e1e guibg=#cf6a4c
hi Underlined guifg=#cf6a4c
hi Title guifg=#7587a6 gui=none
hi TabLine guifg=#838184 guibg=#1e1e1e gui=none
hi TabLineFill guifg=#5f5a60 guibg=#1e1e1e gui=none
hi TabLineSel guifg=#a7a7a7 guibg=#323537 gui=bold
hi MatchParen guibg=#464b50
hi IncSearch guifg=#323537 guibg=#cda869 gui=none
hi Search guifg=#323537 guibg=#f9ee98
hi Comment guifg=#5f5a60 gui=italic
hi Delimiter guifg=#838083
hi String guifg=#8f9d6a
hi Statement guifg=#9b859d gui=none
hi StorageClass guifg=#9b859d gui=none
hi Type guifg=#f9ee98 gui=none
hi Operator guifg=#9b859d gui=none
hi Identifier guifg=#cf6a4c gui=none
hi Special guifg=#afc4db gui=none
hi Constant guifg=#cda869 gui=none
hi PreProc guifg=#f9ee98
hi Function guifg=#7587a6
hi xmlTag guifg=#a7a7a7
hi xmlEndTag guifg=#a7a7a7
hi xmlTagName guifg=#7587a6
hi xmlTagN guifg=#7587a6
hi xmlAttrib guifg=#9b703f
hi SpellBad gui=undercurl guisp=#cf6a4c
hi SpellLocal gui=undercurl guisp=#afc4db
hi SpellCap gui=undercurl guisp=#7587a6
hi SpellRare gui=undercurl guisp=#9b859d
hi DiagnosticError guifg=#cf6a4c
hi DiagnosticUnderlineError gui=undercurl guisp=#cf6a4c
hi DiagnosticWarn guifg=#cda869
hi DiagnosticUnderlineWarn gui=undercurl guisp=#cda869
hi DiagnosticHint guifg=#8f9d6a
hi DiagnosticUnderlineHint gui=undercurl guisp=#8f9d6a
hi DiagnosticInfo guifg=#7587a6
hi DiagnosticUnderlineInfo gui=undercurl guisp=#7587a6
hi DiffAdd guibg=#3a3d31 gui=none
hi DiffChange guibg=#1e1e1e
hi DiffDelete guifg=#382924 guibg=#382924 gui=none
hi DiffText guibg=#3a3d31 gui=none
hi DiffAdded guifg=#8f9d6a guibg=#1e1e1e
hi DiffFile guifg=#cf6a4c guibg=#1e1e1e
hi DiffNewFile guifg=#8f9d6a guibg=#1e1e1e
hi DiffLine guifg=#7587a6 guibg=#1e1e1e
hi DiffRemoved guifg=#cf6a4c guibg=#1e1e1e
hi SignifySignAdd guifg=#8f9d6a guibg=#3a3d31
hi SignifySignChange guifg=#7587a6 guibg=#333840
hi SignifySignDelete guifg=#cf6a4c gui=underline
hi SignifySignDeleteFirstLine guifg=#cf6a4c
hi PMenu guifg=#a7a7a7 guibg=#323537 gui=none
hi PMenuSel guifg=#323537 guibg=#a7a7a7
hi Todo guifg=#f9ee98 guibg=#323537
hi Folded guifg=#5f5a60 guibg=#323537
hi FoldColumn guifg=#afc4db guibg=#1e1e1e

let g:terminal_color_0 =  "#1e1e1e"
let g:terminal_color_1 =  "#cf6a4c"
let g:terminal_color_2 =  "#8f9d6a"
let g:terminal_color_3 =  "#f9ee98"
let g:terminal_color_4 =  "#7587a6"
let g:terminal_color_5 =  "#9b859d"
let g:terminal_color_6 =  "#afc4db"
let g:terminal_color_7 =  "#a7a7a7"
let g:terminal_color_8 =  "#5f5a60"
let g:terminal_color_9 =  "#cf6a4c"
let g:terminal_color_10 = "#8f9d6a"
let g:terminal_color_11 = "#f9ee98"
let g:terminal_color_12 = "#7587a6"
let g:terminal_color_13 = "#9b859d"
let g:terminal_color_14 = "#afc4db"
let g:terminal_color_15 = "#ffffff"
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
