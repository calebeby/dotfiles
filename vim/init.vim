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
Plug 'AndrewRadev/sideways.vim' " J, K for moving arguments left/right/up/down
Plug 'tpope/vim-fugitive', exists('g:vscode') ? { 'on': [] } : {}
Plug 'tpope/vim-dispatch', exists('g:vscode') ? { 'on': [] } : {} " used by git push
Plug 'vim-scripts/ReplaceWithRegister' " grMOTION for 'paste on top of' other text, and discards the overridden text
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/deol.nvim', { 'on': 'Deol' }

Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter' " i, / a,
Plug 'michaeljsmith/vim-indent-object' " ii / ai / iI / aI
Plug 'Julian/vim-textobj-variable-segment' " iv / av
Plug 'glts/vim-textobj-comment' " ic, ac
Plug 'kana/vim-textobj-entire' " ie, ae

Plug 'herringtondarkholme/yats.vim', exists('g:vscode') ? { 'on': [] } : {}

call plug#end()

set title titlestring=

nnoremap <s-j> :SidewaysLeft<cr>
nnoremap <s-k> :SidewaysRight<cr>

let mapleader=","

" sensible up/down (go down visual line for wrapping)
nmap j gj
nmap k gk

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
  nmap <silent> gd <Plug>(coc-definition)
  " 'quick-fix'
  nmap <silent> <leader>a :CocAction<cr>

  " close FZF buffer with <esc>
  augroup fzfclose
    autocmd!
    autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  augroup END

  " quit
  noremap <silent> <c-q> :xall<cr>

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

  noremap <leader>r :source $MYVIMRC \| call InstallPlugins()<cr>

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

  " Git
  nmap <silent> <leader>gs :Git<cr>
  nmap <silent> <leader>gp :Git push<cr>
  nmap <silent> <leader>gl :Git pull<cr>
  nmap <silent> <leader>gf :Git fetch<cr>

  map <silent><C-n> :NERDTreeToggle<CR>
  let NERDTreeQuitOnOpen=1
  map <silent> <c-j> :Deol -split=vertical<cr>
  tmap <silent> <c-j> <c-\><c-n>:q<cr>

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

  " Allow comments in json
  autocmd FileType json syntax match Comment +\/\/.\+$+

  command! -nargs=0 Prettier :CocCommand prettier.formatFile
endif
