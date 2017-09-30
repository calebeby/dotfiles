" Plug 'roxma/nvim-cm-tern', [ 'do': 'yarn', 'for': 'javascript' ]
" Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern', 'for': 'javascript' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neco-syntax'
Plug 'mhartington/nvim-typescript', { 'do': 'yarn global add typescript'}
" Plug '~/Programming/calebeby/emmet-vim-lite'
" Plug '~/Programming/calebeby/ncm-css'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1

function! OnTab()
  if neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif pumvisible()
    return "\<c-n>"
  elseif neosnippet#jumpable()
    return "\<Plug>(neosnippet_jump)"
  " elseif emmet#isExpandable()
  "   return "\<Plug>(emmet-expand)"
  else
    return "\<tab>"
  endif
endfunction

imap <expr><tab> OnTab()
imap <silent> <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
smap <expr><tab> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)" : "\<tab>"

imap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

imap jk <esc>
imap kj <esc>

" snippets
let g:neosnippet#snippets_directory='~/dotfiles/snippets'
let g:neosnippet#enable_completed_snippet=1
let g:neosnippet#disable_runtime_snippets = {'_': 1}

augroup clearmarkers
  autocmd!
  autocmd InsertLeave * NeoSnippetClearMarkers
augroup END

" tab character in neosnippet
augroup neosnippettab
  autocmd!
  autocmd FileType neosnippet setlocal noexpandtab
augroup END

" don't show "The only match", "Back at original", etc.
set shortmess+=c

