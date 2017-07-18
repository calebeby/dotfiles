set nocompatible

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo "installing vim-plug"
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" functionality
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'radenling/vim-dispatch-neovim'
Plug 'alvan/vim-closetag'
Plug 'fatih/vim-go'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" completion
Plug 'jiangmiao/auto-pairs'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern', {'do': 'yarn'}

Plug 'tweekmonster/startuptime.vim'

Plug 'guns/xterm-color-table.vim'

" text objects
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'hhsnopek/vim-sugarss'

Plug 'joshdick/onedark.vim'
" Plug 'rakr/vim-one'
" Plug 'larsbs/vimtom'
" Plug 'patrickw276/one-dark.vim'
" Plug '~/Programming/color/onedark/'
Plug 'vim-scripts/SyntaxAttr.vim'

call plug#end()

colorscheme onedark
set background=dark

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call SyntaxAttr()<CR>

if (has("termguicolors"))
  set termguicolors
endif

let g:onedark_terminal_italics = 1

nnoremap <leader>t :botright 10 new <bar> call termopen('ava') <bar> startinsert<cr>
nnoremap <leader>T :botright 10 new <bar> call termopen('ava --watch') <bar> startinsert<cr>
nnoremap <leader>l :botright 10 new <bar> call termopen('xo --fix') <bar> startinsert<cr>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" open a new file in a new buffer
nmap <c-t> :FZF<cr>
vmap <c-t> <esc><c-t>gv
imap <c-t> <esc><c-t>
tmap <c-t> <esc><c-t>

" quit
noremap <c-q> :xall<CR>

let mapleader = ","

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

" save file
nmap <c-s> :up<CR>
vmap <c-s> <Esc>:up<CR>gv
imap <c-s> <Esc>:up<CR>a

" show relative numbers and current line on 0
set relativenumber number

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
set fillchars=stl:―,stlnc:―,vert:│

" switch panes
nnoremap <m-j> <c-w><c-j>
nnoremap <m-k> <c-w><c-k>
nnoremap <m-l> <c-w><c-l>
nnoremap <m-h> <c-w><c-h>
nnoremap <m-h> <c-w><c-h>

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
nnoremap gca :Gcommit -a<CR>
nnoremap gaa :Git add -A<CR>
nnoremap gp :Gpush<CR>

nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <c-n> :NERDTreeToggle<CR>

" let &t_SI = "\<esc>[5 q"
" let &t_SR = "\<esc>[5 q"
" let &t_EI = "\<esc>[2 q"

" if exists('$TMUX')
"   let &t_SI = "\ePtmux;\e" . &t_SI . "\e\\"
"   let &t_EI = "\ePtmux;\e" . &t_EI . "\e\\"
" endif

" ; === :
nnoremap ; :

" enter insert mode automatically in terminal buffers
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" read when changing buffers
au FocusGained,BufEnter * :silent! !

nmap <leader>f :Dispatch! prettier-eslint --write %<cr>

set mouse=a

augroup filetypedetect
  au BufRead,BufNewFile *.sgr setfiletype pug
  au BufRead,BufNewFile *.sml setfiletype pug
augroup END

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.js"

let g:go_def_mapping_enabled = 0
