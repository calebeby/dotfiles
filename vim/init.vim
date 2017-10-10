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

" functionality
Plug 'tpope/vim-commentary', { 'on': ['<Plug>Commentary', '<Plug>CommentaryLine'] }
Plug 'lambdalisue/gina.vim', { 'on': 'Gina' }
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'metakirby5/codi.vim', { 'on': 'Codi' }
Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion-' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript', 'on': 'JsDoc' }
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'AndrewRadev/sideways.vim', { 'on': [ 'SidewaysLeft', 'SidewaysRight', '<Plug>Sideways' ] }
Plug 'jremmen/vim-ripgrep', { 'on': 'Rg' }

" operators
Plug 'tpope/vim-surround', { 'on': [ '<Plug>Dsurround', '<Plug>Csurround', '<Plug>Ysurround' ] }

" text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent', { 'on': '<Plug>(textobj-indent' }
Plug 'glts/vim-textobj-comment', { 'on': '<Plug>(textobj-comment' }
Plug 'sgur/vim-textobj-parameter', { 'on': '<Plug>(textobj-parameter' }
Plug 'AndrewRadev/dsf.vim', { 'on': '<Plug>Dsf' }
Plug 'thinca/vim-textobj-between', { 'on': '<Plug>(textobj-between' }

" file managing/switching
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }
Plug 'jiangmiao/auto-pairs'

source $HOME/.config/nvim/completion.vim
source $HOME/.config/nvim/linting.vim

" performance
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }

" language
Plug 'hhsnopek/vim-sugarss'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'jparise/vim-graphql', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
Plug 'reshape/vim-sugarml'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'gisphm/vim-gitignore', { 'for': 'gitignore' }
Plug 'dag/vim-fish'

call plug#end()

augroup insertplugins
  autocmd!
  autocmd InsertEnter * call plug#load(
    \'neosnippet.vim',
    \'neco-syntax'
  \) | call deoplete#enable() | autocmd! insertplugins
augroup END

let mapleader = "\\"
map <space> \

set background=dark

set title titlestring=

" jsx
let g:jsx_ext_required = 0

" js
let g:javascript_plugin_jsdoc = 1

" jsdoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1
let NERDTreeQuitOnOpen=1
nmap <leader>d :JsDoc<cr>

" navigate tabs
nnoremap tj :tabprevious<cr>
nnoremap tk :tabnext<cr>
nnoremap tn :tabnew<cr>
nnoremap tc :tabclose<cr>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt

" sensible up/down
nmap j gj
nmap k gk

" use hex colors
if (has("termguicolors"))
  set termguicolors
endif

" open a file
nmap <silent><c-o> :FZF<cr>

" close FZF buffer with <esc>
augroup fzfclose
  autocmd!
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END

" dsf
let g:dsf_no_mappings = 1

nmap dsf <Plug>DsfDelete
nmap csf <Plug>DsfChange

omap af <Plug>DsfTextObjectA
xmap af <Plug>DsfTextObjectA
omap if <Plug>DsfTextObjectI
xmap if <Plug>DsfTextObjectI

" surround
let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround

" parameter
omap i, <Plug>(textobj-parameter-i)
xmap i, <Plug>(textobj-parameter-i)
omap a, <Plug>(textobj-parameter-a)
xmap a, <Plug>(textobj-parameter-a)

" comment
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)

" between
xmap ib <Plug>(textobj-between-i)
omap ib <Plug>(textobj-between-i)
xmap ab <Plug>(textobj-between-a)
omap ab <Plug>(textobj-between-a)

" indent
xmap ii <Plug>(textobj-indent-i)
omap ii <Plug>(textobj-indent-i)
xmap ai <Plug>(textobj-indent-a)
omap ai <Plug>(textobj-indent-a)

nmap <c-h> <Plug>SidewaysLeft
nmap <c-l> <Plug>SidewaysRight

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

set nofoldenable
let g:vim_markdown_conceal = 0

" auto-refresh vimrc
augroup vimrc
  au!
  au BufWritePost vimrc,.vimrc source $MYVIMRC | call InstallPlugins()
augroup END

" save file
nmap <c-s> :up<cr>
vmap <c-s> <esc>:up<cr>gv
imap <c-s> <esc>:up<cr>a

" show relative numbers and current line #
set relativenumber number

xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine

let g:EasyMotion_do_mapping = 0
nmap <leader><space> <Plug>(easymotion-overwin-f)

nmap <silent> <leader>r :source ~/.config/nvim/init.vim<cr>
nmap <silent> <leader>s :NeoSnippetEdit -split -vertical<cr>
nmap <silent> <leader>t :TestAll<cr>
nmap <silent> <leader>T :TestFile<cr>
nmap <silent> <c-u> :UndotreeToggle \| UndotreeFocus<cr>

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

nmap gs :Gina status<cr>
nmap gc :Gina commit --verbose<cr>
nmap gaa :Gina add -A<cr>
nmap gp :Gina push<cr>
nmap gl :Gina pull<cr>

nnoremap <silent><c-n> :NERDTreeToggle<cr>

" ; === :
nnoremap ; :

" don't show -- INSERT --, etc.
set noshowmode

set laststatus=0

" read when changing buffers
au FocusGained,BufEnter * :silent! !

set mouse=a

set noswapfile
