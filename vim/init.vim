set nocompatible

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

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }
Plug 'chriskempson/base16-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'herringtondarkholme/yats.vim'

call plug#end()

set background=dark

set title titlestring=

" sensible up/down (go down visual line for wrapping)
nmap j gj
nmap k gk

" use hex colors
if (has("termguicolors"))
  set termguicolors
endif

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

" switch buffers without saving
set hidden

" use different indents in different filetypes
filetype plugin indent on

" tab characters are 2 wide
set tabstop=2

" when indenting with <>= use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

" use syntax detection/highlighting
syntax enable

" reload files changed outside vim
set autoread
au CursorHold * checktime  

noremap <c-s-r> :source $MYVIMRC \| call InstallPlugins()<cr>

" auto-refresh vimrc
augroup vimrc
  au!
  au BufWritePost vimrc,.vimrc source $MYVIMRC | call InstallPlugins()
augroup END

" save file
nmap <c-s> :up<cr>
vmap <c-s> <esc>:up<cr>gv
imap <c-s> <esc>:up<cr>a

" use system clipboard
" requires xsel
set clipboard=unnamedplus

" clear search by pressing <esc>
nnoremap <silent> <esc> :noh<return><esc>

" split right and below instead of left and up
set splitbelow
set splitright

set noswapfile

set relativenumber
set number
set mouse=a

colorscheme base16-oceanicnext

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
