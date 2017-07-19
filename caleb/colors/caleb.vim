set background=dark
if exists("syntax_on")
 syntax reset
endif
let g:colors_name="caleb"
hi Cursor guifg=NONE guibg=NONE gui=inverse
hi CursorColumn guibg=#3c3836
hi CursorLine guibg=#3c3836
hi Directory guifg=#b8bb26 gui=bold
hi DiffAdd guifg=#b8bb26 guibg=#282828 gui=inverse
hi DiffAdded guifg=#b8bb26 guibg=#282828 gui=inverse
hi DiffChange guifg=#8ec07c guibg=#282828 gui=inverse
hi DiffDelete guifg=#fb4934 guibg=#282828 gui=inverse
hi DiffRemoved guifg=#fb4934 guibg=#282828 gui=inverse
hi DiffText guifg=#282828 guibg=#fabd2f
hi ErrorMsg guifg=#282828 guibg=#fb4934
hi VertSplit guibg=#928374 guifg=#282828
hi Folded guifg=#928374 guibg=#3c3836 gui=italic
hi FoldColumn guifg=#928374 guibg=#3c3836
hi LineNr guifg=#7c6f64
hi CursorLineNr guifg=#ebdbb2
hi MatchParen guifg=none guibg=#665c54 gui=bold
hi NonText guifg=#504945
hi Normal guifg=#ebdbb2 guibg=#282828
hi Pmenu guifg=#ebdbb2 guibg=#504945
hi PmenuSel guifg=#504945 guibg=#83a598 gui=bold
hi PmenuSbar guifg=none guibg=#504945
hi PmenuThumb guifg=none guibg=#7c6f64
hi Search guibg=#fabd2f guifg=#282828
hi StatusLine guibg=#282828 guifg=#928374 gui=bold
hi StatusLineNC guifg=#282828 guibg=#928374
hi Title guifg=#b8bb26 gui=bold
hi Visual guibg=#3c3836
hi WarningMsg guifg=#fb4934 gui=bold
hi Comment guifg=#928374
hi Constant guifg=#d3869b
hi String guifg=#b8bb26
hi Identifier guifg=#83a598
hi Function guifg=#b8bb26 gui=bold
hi Statement gui=NONE guifg=#fb4934
hi Operator guifg=#ebdbb2 guibg=#282828
hi PreProc guifg=#8ec07c
hi Type gui=NONE guifg=#fabd2f
hi StorageClass guifg=#fe8019
hi Structure guifg=#8ec07c
hi Special guifg=#fe8019
hi Underlined guifg=#83a598 gui=underline
hi Error guibg=#fb4934 gui=bold
hi Todo guifg=#ebdbb2 guibg=#282828 gui=bold,italic
hi xmlTag guifg=#83a598
hi htmlTag guifg=#83a598
hi xmlTagname guifg=#8ec07c gui=bold
hi htmlTagName guifg=#8ec07c gui=bold
hi htmlSpecialTagName guifg=#8ec07c gui=bold
hi htmlArg guifg=#8ec07c
hi xmlAttrib guifg=#8ec07c
hi xmlEndTag guifg=#8ec07c gui=bold
hi htmlEndTag guifg=#8ec07c gui=bold