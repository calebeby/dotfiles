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
Plug 'lambdalisue/gina.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'radenling/vim-dispatch-neovim'

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" completion
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern', {'do': 'yarn'}

Plug 'tweekmonster/startuptime.vim'

" text objects
Plug 'b4winckler/vim-angry'

" language
Plug 'ap/vim-css-color'
Plug 'hhsnopek/vim-sugarss'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug '~/dotfiles/caleb'
Plug 'vim-scripts/SyntaxAttr.vim'

call plug#end()

colorscheme caleb
set background=dark

let g:jsx_ext_required = 0

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call SyntaxAttr()<CR>

if (has("termguicolors"))
  set termguicolors
endif

let mapleader = ","

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" open a new file in a new buffer
nmap <c-o> :FZF<cr>

" quit
noremap <c-q> :xall<CR>

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

" highlight current line
set cursorline

" save file
nmap <c-s> :up<CR>
vmap <c-s> <Esc>:up<CR>gv
imap <c-s> <Esc>:up<CR>a

" show relative numbers and current line on 0
set relativenumber number

" use system clipboard
" requires xsel
set clipboard=unnamedplus

" clear search by pressing <esc>
nnoremap <silent> <esc> :noh<return><esc>

" split right and below instead of left and up
set splitbelow
set splitright

" vertical split character
set fillchars=stl:─,stlnc:─,vert:│

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

xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine

nmap gs :Gina status<CR>
nnoremap gc :Gina commit --verbose<CR>
nmap gp :Gina push<CR>
nmap gl :Gina pull<CR>

nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>
nnoremap <c-n> :NERDTreeToggle<CR>

" ; === :
nnoremap ; :

" enter insert mode automatically in terminal buffers
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" don't show -- INSERT --, etc.
set noshowmode

" always show statusline
set laststatus=2

function! ModifiedIndicator()
  return &modified ? '*' : ''
endfunction

function! ReadOnlyIndicator()
  return &readonly ? '🔒' : ''
endfunction

"tail
set statusline=%t
"file modified
set statusline+=%#WarningMsg#
set statusline+=%{ModifiedIndicator()}
set statusline+=%*\  
" read only
set statusline+=%{ReadOnlyIndicator()}
" git branch
" set statusline+=%{fugitive#statusline()}

" read when changing buffers
au FocusGained,BufEnter * :silent! !

nmap <leader>f :Dispatch! prettier-eslint --write %<cr>

set mouse=a

augroup filetypedetect
  au BufRead,BufNewFile *.sgr setfiletype pug
  au BufRead,BufNewFile *.sml setfiletype pug
augroup END
