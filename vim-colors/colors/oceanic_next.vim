set bg=dark
hi clear
syntax reset
let colors_name = "oceanic_next"

hi Normal guifg=#C0C5CE guibg=#1B2B34
hi Visual guibg=#4F5B66
hi VertSplit guifg=#4F5B66 guibg=#4F5B66 gui=none
hi StatusLine guifg=#A7ADBA guibg=#4F5B66 gui=none
hi StatusLineNC guifg=#65737E guibg=#343D46 gui=none
hi LineNr guifg=#65737E guibg=#1B2B34
hi CursorLineNr guifg=#A7ADBA guibg=#1B2B34
hi Cursor guifg=#1B2B34 guibg=#C0C5CE
hi Cursor guifg=#1B2B34 guibg=#C0C5CE
hi CursorLine guibg=#343D46 gui=none
hi NonText guifg=#65737E
hi QuickFixLine guibg=#343D46 gui=none
hi Error guifg=#1B2B34 guibg=#EC5f67
hi Underlined guifg=#EC5f67
hi Title guifg=#6699CC gui=none
hi TabLine guifg=#A7ADBA guibg=#1B2B34 gui=none
hi TabLineFill guifg=#65737E guibg=#1B2B34 gui=none
hi TabLineSel guifg=#C0C5CE guibg=#343D46 gui=bold
hi IncSearch guifg=#343D46 guibg=#F99157 gui=none
hi Search guifg=#343D46 guibg=#FAC863
hi Comment guifg=#65737E gui=italic
hi String guifg=#99C794
hi Statement guifg=#C594C5 gui=none
hi Type guifg=#FAC863 gui=none
hi Operator guifg=#C594C5 gui=none
hi Identifier guifg=#EC5f67 gui=none
hi Special guifg=#5FB3B3 gui=none
hi Constant guifg=#F99157 gui=none
hi PreProc guifg=#FAC863
hi Function guifg=#6699CC
hi xmlTag guifg=#C0C5CE
hi xmlEndTag guifg=#C0C5CE
hi xmlTagName guifg=#EC5f67
hi xmlTagN guifg=#EC5f67
hi xmlAttrib guifg=#6699CC
hi SpellBad gui=undercurl guisp=#EC5f67
hi SpellLocal gui=undercurl guisp=#5FB3B3
hi SpellCap gui=undercurl guisp=#6699CC
hi SpellRare gui=undercurl guisp=#C594C5
hi CocHighlightText guibg=#343D46
hi CocErrorSign guifg=#EC5f67
hi CocWarningSign guifg=#F99157
hi CocHintSign guifg=#99C794
hi CocInfoSign guifg=#6699CC
hi DiffAdd guibg=#3a524c gui=none
hi DiffChange guibg=#1B2B34
hi DiffDelete guifg=#3a323b guibg=#3a323b gui=none
hi DiffText guibg=#3a524c gui=none
hi DiffAdded guifg=#99C794 guibg=#1B2B34
hi DiffFile guifg=#EC5f67 guibg=#1B2B34
hi DiffNewFile guifg=#99C794 guibg=#1B2B34
hi DiffLine guifg=#6699CC guibg=#1B2B34
hi DiffRemoved guifg=#EC5f67 guibg=#1B2B34
hi SignifySignAdd guifg=#A7ADBA guibg=#3a524c
hi SignifySignChange guifg=#A7ADBA guibg=#2d465a
hi SignifySignDelete guifg=#A7ADBA guibg=#4f3840
hi PMenu guifg=#C0C5CE guibg=#343D46 gui=none
hi PMenuSel guifg=#343D46 guibg=#C0C5CE
hi Todo guifg=#FAC863 guibg=#343D46
hi Folded guifg=#65737E guibg=#343D46
hi FoldColumn guifg=#5FB3B3 guibg=#1B2B34
