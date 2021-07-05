set bg=dark
hi clear
syntax reset
let colors_name = "material_lighter"

hi Normal guifg=#80CBC4 guibg=#FAFAFA
hi Visual guibg=#CCEAE7
hi VertSplit guifg=#CCEAE7 guibg=#CCEAE7 gui=none
hi StatusLine guifg=#8796B0 guibg=#CCEAE7 gui=none
hi StatusLineNC guifg=#CCD7DA guibg=#E7EAEC gui=none
hi LineNr guifg=#CCD7DA guibg=#FAFAFA
hi CursorLineNr guifg=#8796B0 guibg=#FAFAFA
hi Cursor guifg=#FAFAFA guibg=#80CBC4
hi Cursor guifg=#FAFAFA guibg=#80CBC4
hi CursorLine guibg=#f4f5f5 gui=none
hi ColorColumn guibg=#f4f5f5 gui=none
hi NonText guifg=#CCD7DA
hi QuickFixLine guibg=#E7EAEC gui=none
hi Error guifg=#FAFAFA guibg=#FF5370
hi Underlined guifg=#FF5370
hi Title guifg=#6182B8 gui=none
hi TabLine guifg=#8796B0 guibg=#FAFAFA gui=none
hi TabLineFill guifg=#CCD7DA guibg=#FAFAFA gui=none
hi TabLineSel guifg=#80CBC4 guibg=#E7EAEC gui=bold
hi IncSearch guifg=#E7EAEC guibg=#F76D47 gui=none
hi Search guifg=#E7EAEC guibg=#FFB62C
hi Comment guifg=#CCD7DA gui=italic
hi Delimiter guifg=#a6d1cf
hi String guifg=#91B859
hi Statement guifg=#7C4DFF gui=none
hi StorageClass guifg=#7C4DFF gui=none
hi Type guifg=#FFB62C gui=none
hi Operator guifg=#7C4DFF gui=none
hi Identifier guifg=#FF5370 gui=none
hi Special guifg=#39ADB5 gui=none
hi Constant guifg=#F76D47 gui=none
hi PreProc guifg=#FFB62C
hi Function guifg=#6182B8
hi xmlTag guifg=#80CBC4
hi xmlEndTag guifg=#80CBC4
hi xmlTagName guifg=#6182B8
hi xmlTagN guifg=#6182B8
hi xmlAttrib guifg=#E53935
hi SpellBad gui=undercurl guisp=#FF5370
hi SpellLocal gui=undercurl guisp=#39ADB5
hi SpellCap gui=undercurl guisp=#6182B8
hi SpellRare gui=undercurl guisp=#7C4DFF
hi CocHighlightText guibg=#E7EAEC
hi CocErrorSign guifg=#FF5370
hi CocWarningSign guifg=#F76D47
hi CocHintSign guifg=#91B859
hi CocInfoSign guifg=#6182B8
hi DiffAdd guibg=#dfe9d1 gui=none
hi DiffChange guibg=#FAFAFA
hi DiffDelete guifg=#f6dddc guibg=#f6dddc gui=none
hi DiffText guibg=#dfe9d1 gui=none
hi DiffAdded guifg=#91B859 guibg=#FAFAFA
hi DiffFile guifg=#E53935 guibg=#FAFAFA
hi DiffNewFile guifg=#91B859 guibg=#FAFAFA
hi DiffLine guifg=#6182B8 guibg=#FAFAFA
hi DiffRemoved guifg=#E53935 guibg=#FAFAFA
hi SignifySignAdd guifg=#91B859 guibg=#dfe9d1
hi SignifySignChange guifg=#6182B8 guibg=#d3dce9
hi SignifySignDelete guifg=#E53935 gui=underline
hi SignifySignDeleteFirstLine guifg=#E53935
hi PMenu guifg=#80CBC4 guibg=#E7EAEC gui=none
hi PMenuSel guifg=#E7EAEC guibg=#80CBC4
hi Todo guifg=#FFB62C guibg=#E7EAEC
hi Folded guifg=#CCD7DA guibg=#E7EAEC
hi FoldColumn guifg=#39ADB5 guibg=#FAFAFA

let g:terminal_color_0 =  "#FAFAFA"
let g:terminal_color_1 =  "#FF5370"
let g:terminal_color_2 =  "#91B859"
let g:terminal_color_3 =  "#FFB62C"
let g:terminal_color_4 =  "#6182B8"
let g:terminal_color_5 =  "#7C4DFF"
let g:terminal_color_6 =  "#39ADB5"
let g:terminal_color_7 =  "#80CBC4"
let g:terminal_color_8 =  "#CCD7DA"
let g:terminal_color_9 =  "#FF5370"
let g:terminal_color_10 = "#91B859"
let g:terminal_color_11 = "#FFB62C"
let g:terminal_color_12 = "#6182B8"
let g:terminal_color_13 = "#7C4DFF"
let g:terminal_color_14 = "#39ADB5"
let g:terminal_color_15 = "#FFFFFF"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
