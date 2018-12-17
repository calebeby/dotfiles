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
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale', { 'on': [] }
Plug 'Shougo/neco-vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Colors
Plug 'chriskempson/base16-vim'

" Language

"" General
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"" Typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescript', 'typescriptreact' ] }
Plug 'mhartington/nvim-typescript', { 'do': './install.sh', 'on': [] }

call plug#end()

""""""""""" Base

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
nmap <silent><c-p> :FZF<cr>

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

""""""""""" End Base

let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-Space> "\<C-n>"

" Use the popup menu by default; only insert the longest common text of the completion matches
" don't automatically show extra information in the preview window
set completeopt=menu,longest

let g:nvim_typescript#javascript_support = 1

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['typescriptreact'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']

let g:ale_fix_on_save = 1

function! LoadInsertModePlugins()
  call plug#load('ale', 'nvim-typescript', 'neco-vim')
endfunction

augroup load_insert_mode_plugins
  autocmd!
  autocmd InsertEnter * call LoadInsertModePlugins()
augroup END

