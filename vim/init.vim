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
Plug 'asvetliakov/vim-easymotion', exists('g:vscode') ? { 'as': 'vscode-easymotion' } : { 'on': [], 'as': 'vscode-easymotion' }
Plug 'easymotion/vim-easymotion', exists('g:vscode') ? { 'on': [] } : {}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }
Plug 'neoclide/coc.nvim', exists('g:vscode') ? { 'branch': 'release', 'on': [] } : { 'branch': 'release' }
Plug 'chriskempson/base16-vim', exists('g:vscode') ? { 'on': [] } : {}
Plug 'AndrewRadev/sideways.vim' " <s-l>, <s-h> for moving arguments left/right

Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter' " i, / a,
Plug 'michaeljsmith/vim-indent-object' " ii / ai / iI / aI
Plug 'Julian/vim-textobj-variable-segment' " iv / av
Plug 'terryma/vim-expand-region' " K / J
Plug 'glts/vim-textobj-comment' " ic, ac
Plug 'kana/vim-textobj-entire' " ie, ae

Plug 'herringtondarkholme/yats.vim', exists('g:vscode') ? { 'on': [] } : {}

call plug#end()

set title titlestring=

nnoremap <s-h> :SidewaysLeft<cr>
nnoremap <s-l> :SidewaysRight<cr>

let mapleader=","

" sensible up/down (go down visual line for wrapping)
nmap j gj
nmap k gk

map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" 1 means allow nesting
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i,'  :1,
      \ 'i]'  :1,
      \ 'i)'  :1,
      \ 'i}'  :1,
      \ 'a]'  :1,
      \ 'a)'  :1,
      \ 'a}'  :1,
      \ }

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
endif

map <Leader> <Plug>(easymotion-prefix)
" s finds character forwards or backwards
nmap s <Plug>(easymotion-s2)

if !exists('g:vscode')
  " use hex colors
  if (has("termguicolors"))
    set termguicolors
  endif

  set background=dark

  colorscheme base16-tomorrow-night-eighties

  " Don't highlight library/DOM keywords specially
  let g:yats_host_keyword = 0

  " alt-up alt-down for moving this line up or down
  nnoremap <a-up> :m .-2<CR>
  nnoremap <a-down> :m .+1<CR>

  " alt-up alt-down for moving visual selection up or down
  vnoremap <a-up> :m '<-2<CR>gv
  vnoremap <a-down> :m '>+1<CR>gv

  " open a file
  nmap <silent><c-i> :FZF<cr>

  " Coc command list (like ctrl+shift+p menu in vscode)
  nmap <silent><c-s-p> :CocCommand<cr>

  " close FZF buffer with <esc>
  augroup fzfclose
    autocmd!
    autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  augroup END

  " quit
  noremap <c-q> :xall<cr>

  " auto-refresh vimrc
  augroup vimrc
    au!
    au BufWritePost vimrc,.vimrc source $MYVIMRC | call InstallPlugins()
  augroup END

  " save file
  nmap <c-s> :up<cr>
  vmap <c-s> <esc>:up<cr>gv
  imap <c-s> <esc>:up<cr>a

  nmap <c-z> u
  imap <c-z> <esc>u

  noremap <c-s-r> :source $MYVIMRC \| call InstallPlugins()<cr>

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

  " Delay before highlighting word under cursor
  set updatetime=150

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  nmap <silent> <c-enter> <Plug>(coc-definition)
  nmap <silent> <enter> <Plug>(coc-definition)

  " Allow comments in json
  autocmd FileType json syntax match Comment +\/\/.\+$+

  command! -nargs=0 Prettier :CocCommand prettier.formatFile
endif
