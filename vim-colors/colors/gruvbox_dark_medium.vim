set bg=dark
hi clear
syntax reset
let colors_name = "gruvbox_dark_medium"

hi Normal guifg=#d5c4a1 guibg=#282828
hi Visual guibg=#504945
hi LspReferenceText guibg=#3c3836
hi LspReferenceRead guibg=#3c3836
hi LspReferenceWrite guibg=#3c3836
hi VertSplit guifg=#504945 guibg=#504945 gui=none
hi StatusLine guifg=#bdae93 guibg=#504945 gui=none
hi StatusLineNC guifg=#665c54 guibg=#3c3836 gui=none
hi LineNr guifg=#665c54 guibg=#282828
hi CursorLineNr guifg=#bdae93 guibg=#282828
hi Cursor guifg=#282828 guibg=#d5c4a1
hi Cursor guifg=#282828 guibg=#d5c4a1
hi CursorLine guibg=#2b2a2a gui=none
hi ColorColumn guibg=#2b2a2a gui=none
hi SignColumn guifg=#d5c4a1 guibg=#3c3836 gui=none
hi NonText guifg=#3c3836
hi QuickFixLine guibg=#3c3836 gui=none
hi Error guifg=#282828 guibg=#fb4934
hi Underlined guifg=#fb4934
hi Title guifg=#83a598 gui=none
hi TabLine guifg=#bdae93 guibg=#282828 gui=none
hi TabLineFill guifg=#665c54 guibg=#282828 gui=none
hi TabLineSel guifg=#d5c4a1 guibg=#3c3836 gui=bold
hi MatchParen guibg=#504945
hi Directory guifg=#83a598
hi IncSearch guifg=#3c3836 guibg=#fe8019 gui=none
hi Search guifg=#3c3836 guibg=#fabd2f
hi Comment guifg=#665c54 gui=italic
hi Delimiter guifg=#9d907a
hi String guifg=#b8bb26
hi Statement guifg=#d3869b gui=none
hi StorageClass guifg=#d3869b gui=none
hi Type guifg=#fabd2f gui=none
hi Operator guifg=#d3869b gui=none
hi Identifier guifg=#fb4934 gui=none
hi Special guifg=#8ec07c gui=none
hi Constant guifg=#fe8019 gui=none
hi PreProc guifg=#fabd2f
hi Function guifg=#83a598
hi xmlTag guifg=#d5c4a1
hi xmlEndTag guifg=#d5c4a1
hi xmlTagName guifg=#83a598
hi xmlTagN guifg=#83a598
hi xmlAttrib guifg=#d65d0e
hi SpellBad gui=undercurl guisp=#fb4934
hi SpellLocal gui=undercurl guisp=#8ec07c
hi SpellCap gui=undercurl guisp=#83a598
hi SpellRare gui=undercurl guisp=#d3869b
hi DiagnosticError guifg=#fb4934
hi DiagnosticUnderlineError gui=undercurl guisp=#fb4934
hi DiagnosticWarn guifg=#fe8019
hi DiagnosticUnderlineWarn gui=undercurl guisp=#fe8019
hi DiagnosticHint guifg=#b8bb26
hi DiagnosticUnderlineHint gui=undercurl guisp=#b8bb26
hi DiagnosticInfo guifg=#83a598
hi DiagnosticUnderlineInfo gui=undercurl guisp=#83a598
hi DiffAdd guibg=#3c4638 gui=none
hi DiffChange guibg=#282828
hi DiffDelete guifg=#522e2a guibg=#522e2a gui=none
hi DiffText guibg=#3c4638 gui=none
hi NeogitDiffContext guifg=#d5c4a1 guibg=#282828
hi NeogitDiffAdd guifg=#8ec07c guibg=#282828
hi NeogitDiffDelete guifg=#fb4934 guibg=#282828
hi NeogitDiffContextHighlight guifg=#d5c4a1 guibg=#282828
hi NeogitDiffAddHighlight guifg=#8ec07c guibg=#282828
hi NeogitDiffDeleteHighlight guifg=#fb4934 guibg=#282828
hi NeogitHunkHeader guifg=#d5c4a1 guibg=#3c3836
hi NeogitHunkHeaderHighlight guifg=#d5c4a1 guibg=#3c3836
hi DiffAdded guifg=#8ec07c guibg=#282828
hi DiffFile guifg=#fb4934 guibg=#282828
hi DiffNewFile guifg=#8ec07c guibg=#282828
hi DiffLine guifg=#83a598 guibg=#282828
hi DiffRemoved guifg=#fb4934 guibg=#282828
hi SignifySignAdd guifg=#8ec07c guibg=#3c4638
hi SignifySignChange guifg=#83a598 guibg=#3e4744
hi SignifySignDelete guifg=#fb4934 gui=underline
hi SignifySignDeleteFirstLine guifg=#fb4934
hi @markup.heading guifg=#83a598 gui=bold
hi @markup.list guifg=#fb4934
hi @markup.italic gui=italic
hi @markup.strong gui=bold
hi @markup.strikethrough guifg=#fb4934 guibg=#282828
hi @markup.underline guifg=#8ec07c guibg=#282828
hi @markup.link.url gui=underline
hi PMenu guifg=#d5c4a1 guibg=#3c3836 gui=none
hi PMenuSel guifg=#3c3836 guibg=#d5c4a1
hi Todo guifg=#fabd2f guibg=#3c3836
hi Folded guifg=#665c54 guibg=#3c3836
hi FoldColumn guifg=#665c54 guibg=#282828

let g:terminal_color_0 =  "#282828"
let g:terminal_color_1 =  "#fb4934"
let g:terminal_color_2 =  "#b8bb26"
let g:terminal_color_3 =  "#fabd2f"
let g:terminal_color_4 =  "#83a598"
let g:terminal_color_5 =  "#d3869b"
let g:terminal_color_6 =  "#8ec07c"
let g:terminal_color_7 =  "#d5c4a1"
let g:terminal_color_8 =  "#665c54"
let g:terminal_color_9 =  "#fb4934"
let g:terminal_color_10 = "#b8bb26"
let g:terminal_color_11 = "#fabd2f"
let g:terminal_color_12 = "#83a598"
let g:terminal_color_13 = "#d3869b"
let g:terminal_color_14 = "#8ec07c"
let g:terminal_color_15 = "#fbf1c7"
let g:terminal_color_background = g:terminal_color_0
let g:terminal_color_foreground = g:terminal_color_5
