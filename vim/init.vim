set nocompatible

if !exists('g:vscode')
  " auto-install vim-plug
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    echo "installing vim-plug"
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  " Automatically install missing plugins
  function! InstallPlugins()
    if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      PlugInstall
    endif
  endfunction

  augroup installplugins
    autocmd!
    autocmd VimEnter * call InstallPlugins()
  augroup END

endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary', exists('g:vscode') ? { 'on': [] } : {} " gcc gcip (there is alternative for vscode)
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ggandor/lightspeed.nvim' " s motion (like vim-sneak/easymotion)
Plug 'neoclide/coc.nvim', exists('g:vscode') ? { 'branch': 'release', 'on': [] } : { 'branch': 'release' }
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
set rtp+=$HOME/dotfiles/vim-colors
" moving arguments left/right/up/down leader-h leader-l, also argument text object i, a,
Plug 'AndrewRadev/sideways.vim', { 'on': ['<Plug>Sideways', 'SidewaysLeft', 'SidewaysRight'] }
Plug 'tpope/vim-fugitive', { 'on': exists('g:vscode') ? [] : ['Git', 'Gdiffsplit'] }
Plug 'tpope/vim-rhubarb', exists('g:vscode') ? { 'on': [] } : {}
" TODO: conflicts with gr for go to references, shouldn't be in g namespace
Plug 'vim-scripts/ReplaceWithRegister' " R <motion/textobj> for 'paste on top of' other text, and discards the overridden text
Plug 'vim-test/vim-test'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'calebeby/vim-signify', exists('g:vscode') ? { 'on': [] } : {} " My fork highlights the line numbers instead of just the lines
Plug 'aymericbeaumet/vim-symlink', exists('g:vscode') ? { 'on': [] } : {}
Plug 'AndrewRadev/splitjoin.vim' " gS / gJ to convert to single line or multi line
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch' " :Rename and :Move and :Delete
Plug 'mg979/vim-visual-multi', exists('g:vscode') ? { 'on': [] } : {} " multple cursors

Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment', { 'on': '<Plug>(textobj-variable' } " iv / av
Plug 'glts/vim-textobj-comment', { 'on': '<Plug>(textobj-comment' } " ic, ac
Plug 'kana/vim-textobj-entire', { 'on': '<Plug>(textobj-entire' } " ie, ae
Plug 'mattn/vim-textobj-url', { 'on': '<Plug>(textobj-url' }
Plug 'AndrewRadev/dsf.vim', { 'on': '<Plug>Dsf' } " dsF ciF csF (surrounding function call / around function call)
Plug 'rhysd/conflict-marker.vim', exists('g:vscode') ? { 'on': [] } : {}

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'windwp/nvim-ts-autotag' " auto close/rename xml/html/jsx tags
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'

call plug#end()

set title titlestring=

let mapleader=" "

nmap <silent> <leader>h :SidewaysLeft<cr>
nmap <silent> <leader>l :SidewaysRight<cr>

" sensible up/down (go down visual line for wrapping)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" switch buffers without saving
set hidden

" use different indents in different filetypes
filetype plugin indent on

" tab characters are 2 wide
set tabstop=2

" when indenting with <>= use 2 spaces width
set shiftwidth=2

" use system clipboard
" requires xsel
set clipboard=unnamedplus

" clear search by pressing <esc>
nnoremap <silent> <esc> :noh<return><esc>

" split right and below instead of left and up
set splitbelow
set splitright

set noswapfile

" Case-insensitive unless there is a capital letter in the search
set ignorecase
set smartcase

if exists('g:vscode')
  xmap gc  <Plug>VsCodeCommentaryLine
  nmap gc  <Plug>VSCodeCommentaryLine
  omap gc  <Plug>VSCodeCommentaryLine
  nmap gcc <Plug>VSCodeCommentaryLine

  nmap <silent> <leader>gs :<C-u>call VSCodeNotify('workbench.view.scm')<CR>
  nmap <silent> <leader>gp :<C-u>call VSCodeNotify('git.push')<CR>
  nmap <silent> <leader>gl :<C-u>call VSCodeNotify('git.pull')<CR>
  nmap <silent> <leader>gf :<C-u>call VSCodeNotify('git.fetch')<CR>

  nmap <silent> <leader>a :<C-u>call VSCodeNotify('editor.action.quickFix')<CR>
  vmap <silent> <leader>a :<C-u>call VSCodeNotify('editor.action.quickFix')<CR>
endif

" Text Objects
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)

xmap ie <Plug>(textobj-entire-i)
omap ie <Plug>(textobj-entire-i)
xmap ae <Plug>(textobj-entire-a)
omap ae <Plug>(textobj-entire-a)

xmap iu <Plug>(textobj-url-i)
omap iu <Plug>(textobj-url-i)
xmap au <Plug>(textobj-url-a)
omap au <Plug>(textobj-url-a)

xmap iv <Plug>(textobj-variable-i)
omap iv <Plug>(textobj-variable-i)
xmap av <Plug>(textobj-variable-a)
omap av <Plug>(textobj-variable-a)

xmap a, <Plug>SidewaysArgumentTextobjA
omap a, <Plug>SidewaysArgumentTextobjA
xmap i, <Plug>SidewaysArgumentTextobjI
omap i, <Plug>SidewaysArgumentTextobjI

xmap ih <Plug>(signify-motion-inner-visual)
omap ih <Plug>(signify-motion-inner-pending)
xmap ah <Plug>(signify-motion-outer-visual)
omap ah <Plug>(signify-motion-outer-pending)

" Go to next/prev word segment
" creates visual selection and then goes to beginning/end of that selection
nmap ]v viv<esc>`>l
nmap [v hviv<esc>`<

" Like the default pattern, but it allows <> in function name for type
" arguments
let g:dsf_function_pattern = '[a-zA-Z.#<>_]\+[?!]\='
let g:dsf_brackets = '('
let g:dsf_no_mappings = 1
nmap dsF <Plug>DsfDelete
nmap csF <Plug>DsfChange
omap iF <Plug>DsfTextObjectI
xmap iF <Plug>DsfTextObjectI

nmap R <Plug>ReplaceWithRegisterOperator
nmap RR <Plug>ReplaceWithRegisterLine
xmap R <Plug>ReplaceWithRegisterVisual

" delete previous word with ctrl-backspace (terminal sees it as c-h)
imap <C-h> <C-W>
imap <C-BS> <C-W>

nmap -a :TSHighlightCapturesUnderCursor<cr>

autocmd FileType typescript,typescriptreact,json setlocal commentstring=//\ %s
au BufRead,BufNewFile *.cjs set filetype=javascript

" save file
nmap <leader>s :up<cr>

let test#strategy = "neovim"
let test#neovim#term_position = "botright 15"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

if !exists('g:vscode')
  " use hex colors
  if (has("termguicolors"))
    set termguicolors
  endif

  set background=dark

  colorscheme one_dark
  set colorcolumn=80

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript" },
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = false,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aF"] = "@call.outer",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
  },
}
EOF

  " Visual Multi Cursor
  let g:VM_default_mappings = 1
  let g:VM_maps = {}
  let g:VM_maps["Find Under"] = '' " force remove the <c-n> mapping
  let g:VM_maps["Find Subword Under"] = '' " force remove the <c-n> mapping

  " alt-up alt-down for moving this line up or down
  nnoremap <a-up> :m .-2<CR>
  nnoremap <a-down> :m .+1<CR>
  " alt-up alt-down for moving this line up or down
  imap <a-up> <esc>:m .-2<CR>i
  imap <a-down> <esc>:m .+1<CR>i

  " alt-up alt-down for moving visual selection up or down
  vnoremap <a-up> :m '<-2<CR>gv
  vnoremap <a-down> :m '>+1<CR>gv

  " nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gd :Telescope coc definitions<cr>
  " nmap <silent> gD <Plug>(coc-type-definition)
  nmap <silent> gD :Telescope coc type_definitions<cr>
  " nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gr :Telescope coc references<cr>
  nmap <silent> gi <Plug>(coc-implementation)

  " 'quick-fix'
  xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
  nmap <silent> <leader>a :CocAction<CR>

  " next/prev error/warning
  " These aren't under leader because leader-k is already used
  nmap <silent> gj <Plug>(coc-diagnostic-next)
  nmap <silent> gk <Plug>(coc-diagnostic-prev)

  nmap <silent> <leader>rn <Plug>(coc-rename)
  " " Use K to show documentation in preview window
  " nnoremap <silent> K :call CocAction('doHover')<CR>
  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " let g:signify_sign_show_text = 0
  " let g:signify_sign_show_count = 0
  let g:signify_sign_change = '~'
  let g:signify_sign_delete = 'ㅤ'

  nmap ) <plug>(signify-next-hunk)
  nmap ( <plug>(signify-prev-hunk)

  set signcolumn=number

  " quit
  noremap <silent> <c-q> :qall<cr>

  " auto-refresh vimrc
  augroup vimrc
    au!
    au BufWritePost vimrc,.vimrc source $MYVIMRC | call InstallPlugins()
  augroup END

  nmap <c-z> u
  imap <c-z> <esc>u

  " reload vimrc leader kr
  noremap <leader>kr :source $MYVIMRC \| call InstallPlugins()<cr>

  " window mappings
  noremap <leader>w <c-w>

  noremap <leader>; :

  " c-/ comes through as c-_
  nmap <c-_> <Plug>CommentaryLine
  vmap <c-_> <Plug>Commentary gv

  " reload files changed outside vim
  set autoread
  au CursorHold * checktime  

  " use syntax detection/highlighting
  syntax enable

  set relativenumber
  set number
  set mouse=a

  " On pressing tab, insert 2 spaces
  set expandtab

  " Git / Fugitive
  nmap <silent> <leader>gs :tabnew %<cr> :Git<cr> :only<cr>
  " nmap <silent> <leader>gs :Git<cr>
  nmap <silent> <leader>gp :Git push<cr>
  nmap <silent> <leader>gP :Git push -u origin HEAD<cr>
  nmap <silent> <leader>gl :Git pull<cr>
  nmap <silent> <leader>gf :Git fetch<cr>
  nmap <silent> <leader>gh :SignifyHunkDiff<cr>
  nmap <silent> <leader>gd :tabnew %<cr> :Gdiffsplit!<cr>
  vmap <silent> <leader>gS :diffput<cr>
  nmap <silent> <leader>gS :diffput<cr>

  map <silent><C-n> :NERDTreeToggle<CR>
  let NERDTreeQuitOnOpen=1

  " open url under cursor
  nmap go yiu :!open (xsel -b)<cr><cr>

  " tabs
  nmap g1 1gt
  nmap g2 2gt
  nmap g3 3gt
  nmap g4 4gt
  nmap g5 5gt
  nmap g6 6gt
  nmap g7 7gt
  nmap g8 8gt
  nmap g9 9gt

  " Make <c-w> in terminal go out of terminal "insert" mode so
  " window-switching commands can be used
  tmap <silent> <esc> <c-\><c-n>

  augroup custom_term
      autocmd!
      autocmd TermOpen * setlocal bufhidden=hide nonumber norelativenumber winfixwidth winfixheight
  augroup END

  let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-pairs', 'coc-eslint', 'coc-prettier']

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Delay before highlighting word under cursor (and writing swap files)
  set updatetime=10

  " Highlight symbol under cursor on CursorHold
  augroup highlightWordUnderCursor
    autocmd!
    autocmd! CursorHold * silent call CocActionAsync('highlight')
  augroup END

  " Allow comments in json
  autocmd FileType json syntax match Comment +\/\/.\+$+

  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " open a file
  nmap <silent> <leader>o :Telescope find_files<cr>
  nmap <silent> <leader><leader> :Telescope coc document_symbols<cr>

lua <<EOF
require('telescope').load_extension('coc')
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  }
}
EOF



  map <leader>kt :Telescope colorscheme<cr>
endif

" disable the default highlight group
let g:conflict_marker_highlight_group = ''
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e

" TS stands for Tree Sitter, not TypeScript
hi link TSInclude Keyword
hi link TSVariable Identifier
hi link TSVariableBuiltin Identifier
hi link TSProperty Normal
hi link TSConstant TSVariable
hi link TSTag xmlTagN

" This gets used for capitalized imports
hi link typescriptTSConstructor TSVariable
hi link tsxTSConstructor TSVariable
hi link javascriptTSConstructor TSVariable

hi link regexTSConstant TSStringRegex
