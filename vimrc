set nocompatible

call plug#begin('~/.vim/plugged')

" functionality
" Plug 'FredKSchott/CoVim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rafi/vim-tinyline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" completion
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" text objects
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'

" theming
Plug 'morhetz/gruvbox'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color', { 'for': [ 'css', 'styl' ] }

call plug#end()

call deoplete#enable()

" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

colorscheme gruvbox
set background=dark

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

" automatically :write before running commands
set autowrite

" reload files changed outside vim
set autoread

" save file
nmap <c-s> :up<CR>
vmap <c-s> <Esc>:up<CR>gv
imap <c-s> <Esc>:up<CR>a

" show relative numbers and current line on 0
set relativenumber number

" no arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

imap <up> <NOP>
imap <down> <NOP>
imap <left> <NOP>
imap <right> <NOP>

" quit
noremap <c-q> :xall<CR>

" adjust numbers
noremap + <C-a>
noremap - <C-x>

" use system clipboard
" requires xsel
set clipboard=unnamedplus

" enable italic
let g:gruvbox_italic=1

" clear search by pressing <esc>
nnoremap <silent> <esc> :noh<return><esc>

" split right and below instead of left and up
set splitbelow
set splitright

" vertical split character
set fillchars+=vert:│

nnoremap <m-j> <c-w><c-j>
nnoremap <m-k> <c-w><c-k>
nnoremap <m-l> <c-w><c-l>
nnoremap <m-h> <c-w><c-h>
nnoremap <m-h> <c-w><c-h>

" open a new file in a new buffer
nmap <c-t> :FZF<cr>
vmap <c-t> <esc><c-t>gv
imap <c-t> <esc><c-t>
tmap <c-t> <esc><c-t>

" <esc> as <esc> in terminal
tmap <esc> <c-\><c-n>

" fix shortcuts in terminal
tmap <m-j> <esc><m-j>
tmap <m-k> <esc><m-k>
tmap <m-l> <esc><m-l>
tmap <m-h> <esc><m-h>

tmap <c-q> <esc><c-q>

" close FZF buffer with <esc>
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c><esc>:q<CR>

nnoremap gs :Gstatus<CR>
nnoremap gca :Git commit -a<CR>
nnoremap gaa :Git add -A<CR>
nnoremap gp :Gpush<CR>

" change cursor shape on entering insert or replace mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

if exists('$TMUX')
  let &t_SI = "\ePtmux;\e" . &t_SI . "\e\\"
  let &t_EI = "\ePtmux;\e" . &t_EI . "\e\\"
endif

" ; === :
nnoremap ; :

" enter insert mode automatically in terminal buffers
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" read when changing buffers
au FocusGained,BufEnter * :silent! !
