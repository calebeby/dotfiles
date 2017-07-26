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
Plug 'lambdalisue/gina.vim', {'on': 'Gina'}
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'radenling/vim-dispatch-neovim'

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" completion
Plug 'roxma/nvim-cm-tern', {'do': 'yarn', 'for': 'javascript'}
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'roxma/nvim-completion-manager'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neosnippet.vim'
" Plug 'mattn/emmet-vim'
Plug '~/Programming/calebeby/emmet-vim-lite'

" performance
Plug 'tweekmonster/startuptime.vim', {'on': 'StartupTime'}

" text objects
Plug 'b4winckler/vim-angry'

" language
Plug 'ap/vim-css-color'
Plug 'hhsnopek/vim-sugarss'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'reshape/vim-sugarml'
Plug 'plasticboy/vim-markdown', {'for': ['md', 'markdown']}

Plug 'vim-colorize/one-dark'
Plug 'vim-scripts/SyntaxAttr.vim'

call plug#end()

colorscheme one-dark
set background=dark

let g:jsx_ext_required = 0

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call SyntaxAttr()<CR>

if (has("termguicolors"))
  set termguicolors
endif

let mapleader = ","

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

set nofoldenable
let g:vim_markdown_conceal = 0

augroup vimrc
  au!
  au BufWritePost vimrc,.vimrc source ~/.config/nvim/init.vim
augroup END

" save file
nmap <c-s> :up<CR>
vmap <c-s> <esc>:up<CR>gv
imap <c-s> <esc>:up<CR>a

" show relative numbers and current line #
set relativenumber number

function! OnTab()
  if neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif pumvisible()
    return "\<C-n>"
  elseif neosnippet#jumpable()
    return "\<Plug>(neosnippet_jump)"
  elseif emmet#isExpandable()
    return "\<Plug>(emmet-expand-abbr)"
  else
    return "\<tab>"
  endif
endfunction

imap <expr><tab> OnTab()

imap <expr><enter> pumvisible() ? "\<c-y>" : "\<cr>"

smap <expr><tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<tab>"

imap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" snippets
let g:neosnippet#snippets_directory='~/dotfiles/snippets'
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#disable_runtime_snippets = {'_': 1}

autocmd InsertLeave * NeoSnippetClearMarkers

" tab character in neosnippet
autocmd FileType neosnippet setlocal noexpandtab

nmap <leader>s :NeoSnippetEdit -split -vertical<cr>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" hide markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" use system clipboard
" requires xsel
set clipboard=unnamedplus

" clear search by pressing <esc>
nnoremap <silent> <esc> :noh<return><esc>

" split right and below instead of left and up
set splitbelow
set splitright

" split character
set fillchars=stl:─,stlnc:─,vert:│,fold:۰,diff:·

" case insensitive suggestions for files and directories
set wildignorecase
" case insensitive suggestions for :command suggestions
set ignorecase

" switch panes
nnoremap <m-h> <c-w><c-h>
nnoremap <m-j> <c-w><c-j>
nnoremap <m-k> <c-w><c-k>
nnoremap <m-l> <c-w><c-l>

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

" don't show "The only match", "Back at original", etc.
set shortmess+=c

" always show statusline
set laststatus=2

set laststatus=0

" read when changing buffers
au FocusGained,BufEnter * :silent! !

nmap <leader>f :Dispatch! prettier-eslint --write %<cr>

set mouse=a

" ctrl-enter
nmap <c-m> :botright 1split \| term<cr>
