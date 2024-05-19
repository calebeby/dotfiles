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

Plug 'tpope/vim-commentary' " gcc gcip
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ggandor/leap.nvim' " s motion (like vim-sneak/easymotion)
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
set rtp+=$HOME/dotfiles/vim-colors
" moving arguments left/right/up/down leader-h leader-l, also argument text object i, a,
Plug 'vim-scripts/ReplaceWithRegister' " R <motion/textobj> for 'paste on top of' other text, and discards the overridden text
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mhinz/vim-signify', exists('g:vscode') ? { 'on': [] } : {}
Plug 'AndrewRadev/splitjoin.vim' " gS / gJ to convert to single line or multi line
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch' " :Rename and :Move and :Delete
Plug 'mg979/vim-visual-multi', exists('g:vscode') ? { 'on': [] } : {} " multple cursors
Plug 'mhartington/formatter.nvim'
Plug 'jiangmiao/auto-pairs' " Auto insert end brackets, closing quotes, etc.
Plug 'machakann/vim-highlightedyank' " highlight yanked region briefly after yanking

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'octaltree/cmp-look'
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/lsp_signature.nvim'
Plug 'petRUShka/vim-sage'
Plug 'lervag/vimtex'
Plug 'tikhomirov/vim-glsl'

Plug 'editorconfig/editorconfig-vim'

Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment', { 'on': '<Plug>(textobj-variable' } " iv / av
Plug 'glts/vim-textobj-comment', { 'on': '<Plug>(textobj-comment' } " ic, ac
Plug 'kana/vim-textobj-entire', { 'on': '<Plug>(textobj-entire' } " ie, ae
Plug 'mattn/vim-textobj-url', { 'on': '<Plug>(textobj-url' }
Plug 'AndrewRadev/dsf.vim', { 'on': '<Plug>Dsf' } " dsF ciF csF (surrounding function call / around function call)

Plug 'rhysd/conflict-marker.vim', exists('g:vscode') ? { 'on': [] } : {}
Plug 'AndrewRadev/yankwin.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'nvim-lua/popup.nvim', exists('g:vscode') ? { 'on': [] } : {}
Plug 'nvim-lua/plenary.nvim', exists('g:vscode') ? { 'on': [] } : {}
Plug 'nvim-telescope/telescope.nvim', exists('g:vscode') ? { 'on': [] } : {}
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'debugloop/telescope-undo.nvim'
Plug 'nvim-pack/nvim-spectre' " Project Search UI

Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'

Plug 's1n7ax/nvim-window-picker'

call plug#end()

set title titlestring=

let mapleader=" "

" sensible up/down (go down visual line for wrapping)
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

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

" Permanent undo
set undodir=~/.vimdid
set undofile

" Show hidden chars (highlight group NonText)
set listchars=nbsp:¬,extends:»,precedes:«,trail:•,tab:\▸\ 
set list

let g:highlightedyank_highlight_duration = 150

function! RunTests()
  let cmd = ''
  if &ft == 'rust'
    let cmd = 'cargo insta test'
  else
    echo "No test runner for " . &ft . " files"
    return
  endif
  let original_win_id = win_getid()
  exe 'tabe'
  let term_win_id = win_getid()
  let job = termopen(cmd, {
        \ 'on_exit': funcref('s:complete', [cmd, original_win_id, term_win_id])
        \ })
  call win_gotoid(original_win_id)
endfunction

function! s:complete(cmd, original_win_id, term_win_id, id, status, event_type)
  call win_gotoid(a:term_win_id)
  if a:status == '0'
    bdelete
    echo 'Test command `' . a:cmd . '` completed successfully'
    call win_gotoid(a:original_win_id)
  else
    startinsert
  endif
endfunction

nmap <silent> <leader>t :call RunTests()<cr>

if exists('g:vscode')
  nmap gcc <Plug>VSCodeCommentaryLine

  nmap <silent> <leader>gs :<C-u>call VSCodeNotify('workbench.view.scm')<cr>
  nmap <silent> <leader>gp :<C-u>call VSCodeNotify('git.push')<cr>
  nmap <silent> <leader>gl :<C-u>call VSCodeNotify('git.pull')<cr>
  nmap <silent> <leader>gf :<C-u>call VSCodeNotify('git.fetch')<cr>

  nmap <silent> <leader>a :<C-u>call VSCodeNotify('editor.action.quickFix')<cr>
  vmap <silent> <leader>a :<C-u>call VSCodeNotify('editor.action.quickFix')<cr>

  nmap <leader>o :call VSCodeNotify('workbench.action.quickOpen')<cr>

  nnoremap <silent> <c-o> :call VSCodeCall('workbench.action.navigateBack')<cr>
  nnoremap <silent> <c-i> :call VSCodeCall('workbench.action.navigateForward')<cr>

  nmap <silent> <leader>wq :call VSCodeNotify('workbench.action.closeEditorsAndGroup')<cr>
  nmap <silent> <leader>ws :sp<cr>
  nmap <silent> <leader>wv :vsp<cr>

  nmap <silent> <leader>wh <c-w>h<cr>
  nmap <silent> <leader>wj <c-w>j<cr>
  nmap <silent> <leader>wk <c-w>k<cr>
  nmap <silent> <leader>wl <c-w>l<cr>

  nmap <silent> <a-h> <c-w>h<cr>
  nmap <silent> <a-j> <c-w>j<cr>
  nmap <silent> <a-k> <c-w>k<cr>
  nmap <silent> <a-l> <c-w>l<cr>

  nmap <silent> <leader>wH <c-w>H<cr>
  nmap <silent> <leader>wJ <c-w>J<cr>
  nmap <silent> <leader>wK <c-w>K<cr>
  nmap <silent> <leader>wL <c-w>L<cr>

  nmap <silent> <a-H> <c-w>H<cr>
  nmap <silent> <a-J> <c-w>J<cr>
  nmap <silent> <a-K> <c-w>K<cr>
  nmap <silent> <a-L> <c-w>L<cr>

  nmap <silent> <leader>w= <c-w>=<cr>

  nmap <silent> <leader>T :call VSCodeNotify('workbench.action.createTerminalEditor')<cr>

  nmap <silent> <leader>kt :call VSCodeNotify('workbench.action.selectTheme')<cr>

  nmap <silent> gd :call VSCodeNotify('editor.action.revealDefinition')<cr>
  nmap <silent> gD :call VSCodeNotify('editor.action.goToTypeDefinition')<cr>
  nmap <silent> gr :call VSCodeNotify('editor.action.goToReferences')<cr>
  nmap <silent> gi :call VSCodeNotify('editor.action.goToImplementation')<cr>

  nmap <silent> <leader>rn :call VSCodeNotify('editor.action.rename')<cr>

  nmap <silent> gj :call VSCodeNotify('editor.action.marker.next')<cr>
  nmap <silent> gk :call VSCodeNotify('editor.action.marker.prev')<cr>

  nmap <silent> ) :call VSCodeNotify('workbench.action.editor.nextChange')<cr>
  nmap <silent> ( :call VSCodeNotify('workbench.action.editor.previousChange')<cr>
endif

" Text Objects
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)

xmap ie <Plug>(textobj-entire-i)
omap ie <Plug>(textobj-entire-i)
xmap ae <Plug>(textobj-entire-a)
omap ae <Plug>(textobj-entire-a)

xmap iu <Plug>(textobj-url-i)
omap iu <Plug>(textobj-url-i)
xmap au <Plug>(textobj-url-a)
omap au <Plug>(textobj-url-a)

xmap iv <Plug>(textobj-variable-i)
omap iv <Plug>(textobj-variable-i)
xmap av <Plug>(textobj-variable-a)
omap av <Plug>(textobj-variable-a)

xmap ih <Plug>(signify-motion-inner-visual)
omap ih <Plug>(signify-motion-inner-pending)
xmap ah <Plug>(signify-motion-outer-visual)
omap ah <Plug>(signify-motion-outer-pending)

" Go to next/prev word segment
" creates visual selection and then goes to beginning/end of that selection
nmap ]v viv<esc>`>l
nmap [v hviv<esc>`<

" Like the default pattern, but it allows <> in function name for type
" arguments
let g:dsf_function_pattern = '[a-zA-Z.#<>_]\+[?!]\='
let g:dsf_brackets = '('
let g:dsf_no_mappings = 1
nmap dsF <Plug>DsfDelete
nmap csF <Plug>DsfChange
omap iF <Plug>DsfTextObjectI
xmap iF <Plug>DsfTextObjectI

nmap R <Plug>ReplaceWithRegisterOperator
nmap RR <Plug>ReplaceWithRegisterLine
xmap R <Plug>ReplaceWithRegisterVisual

" delete previous word with ctrl-backspace (terminal sees it as c-h)
imap <C-h> <C-W>
imap <C-BS> <C-W>

autocmd FileType typescript,typescriptreact,json setlocal commentstring=//\ %s
au BufRead,BufNewFile *.cjs set filetype=javascript
au BufRead,BufNewFile *.mts,*.cts set filetype=typescript
au BufRead,BufNewFile *.mdx set filetype=mdx
au BufRead,BufNewFile *.twig set filetype=html
au BufRead,BufNewFile *.sage set filetype=python
au BufRead,BufNewFile *.astro set filetype=astro
au BufRead,BufNewFile *.djot set filetype=djot
autocmd FileType djot setlocal commentstring={%\ %s\ %}
autocmd FileType typst setlocal commentstring=//\ %s

let g:yankwin_default_mappings = 0

nnoremap <silent> <leader>wd  :call yankwin#Delete({'path_type': 'relative', 'with_line_number': 0})<cr>
nnoremap <silent> <leader>wgd :call yankwin#Delete({'path_type': 'absolute', 'with_line_number': 0})<cr>
nnoremap <silent> <leader>wD  :call yankwin#Delete({'path_type': 'relative', 'with_line_number': 1})<cr>
nnoremap <silent> <leader>wgD :call yankwin#Delete({'path_type': 'absolute', 'with_line_number': 1})<cr>

nnoremap <silent> <leader>wy  :call yankwin#Yank({'path_type': 'relative', 'with_line_number': 0})<cr>
nnoremap <silent> <leader>wgy :call yankwin#Yank({'path_type': 'absolute', 'with_line_number': 0})<cr>
nnoremap <silent> <leader>wY  :call yankwin#Yank({'path_type': 'relative', 'with_line_number': 1})<cr>
nnoremap <silent> <leader>wgY :call yankwin#Yank({'path_type': 'absolute', 'with_line_number': 1})<cr>

nnoremap <silent> <leader>wR  :call yankwin#Paste({'edit_command': 'edit'})<cr>
nnoremap <silent> <leader>wp  :call yankwin#Paste({'edit_command': 'rightbelow split'})<cr>
nnoremap <silent> <leader>wP  :call yankwin#Paste({'edit_command': 'leftabove split'})<cr>
nnoremap <silent> <leader>wgp :call yankwin#Paste({'edit_command': 'tab split'})<cr>
nnoremap <silent> <leader>wgP :call yankwin#Paste({'edit_command': (tabpagenr() - 1).'tab split'})<cr>

" save file
nmap <leader>s :w<cr>

lua <<EOF
local term_clear = function()
  vim.fn.feedkeys("", 'n')
  local sb = vim.bo.scrollback
  vim.bo.scrollback = 1
  vim.bo.scrollback = sb
end

vim.keymap.set('t', '<C-l>', term_clear)

require('spectre').setup({
  live_update = true,
  open_cmd = 'tabnew',
  highlight = {
    ui = "Keyword",
    search = "Search",
    replace = "DiffDelete"
  },
})
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
EOF

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

lua <<EOF

local neogit = require('neogit')
neogit.setup {}

require("diffview").setup({
  use_icons = false,
  enhanced_diff_hl = true,
})

local window_picker = require('window-picker')
window_picker.setup()
function focus_window()
    local window = window_picker.pick_window({
        show_prompt = false,
        hint = 'floating-big-letter',
        selection_chars = 'FJKSLA;CMRUEIWOQP',
        -- For excluding windows like treesitter-context window
        filter_func = function(windows, rules)
          local function predicate(wid)
            cfg = vim.api.nvim_win_get_config(wid)
            if not cfg.focusable then
              return false
            end
            return true
          end
          local filtered = vim.tbl_filter(predicate, windows)

          local dfilter = require("window-picker.filters.default-window-filter"):new()
          dfilter:set_config(rules)
          return dfilter:filter_windows(filtered)
        end,
    })
    if window then
      vim.api.nvim_set_current_win(window)
    end
end

vim.keymap.set('n', '<leader>w<leader>w', focus_window)
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript", "tsx", "jsdoc", "regex", "c", "cpp", "rust", "svelte", "html", "css", "json", "astro", "markdown", "zig", "lua", "vim", "yaml", "bash", "sql", "djot", "typst" },
  highlight = {
    enable = not vim.g.vscode,
  },
  indent = {
    enable = true
  },
  -- Expanding selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>c",
      node_incremental = "<leader>c",
      scope_incremental = false,
      node_decremental = "<leader>v",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aF"] = "@call.outer",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["a,"] = "@parameter.outer",
        ["i,"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>l"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>h"] = "@parameter.inner",
      },
    },
  },
}

vim.treesitter.language.register('markdown', 'mdx')

require'treesitter-context'.setup{
  enable = true,
  line_numbers = true,
  mode = 'topline',
}
EOF

lua require('leap').add_default_mappings()
lua vim.keymap.set('o', 'z', '<Plug>(leap-forward-to)', {})
lua vim.keymap.set('o', 'Z', '<Plug>(leap-backward-to)', {})

" reload vimrc leader kr
if exists('g:vscode')
  noremap <leader>kr :source $MYVIMRC<cr>
else
  noremap <leader>kr :source $MYVIMRC \| call InstallPlugins()<cr>
endif

noremap <leader>; :

if !exists('g:vscode')
  " use hex colors
  if (has("termguicolors"))
    set termguicolors
  endif

  set background=dark

  colorscheme one_dark
  set colorcolumn=80

  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWriteLock
  augroup END

  nnoremap <leader>u :Telescope undo<cr>

  " Visual Multi Cursor
  let g:VM_default_mappings = 1
  let g:VM_maps = {}
  let g:VM_maps["Find Under"] = '' " force remove the <c-n> mapping
  let g:VM_maps["Find Subword Under"] = '' " force remove the <c-n> mapping

  " alt-up alt-down for moving this line up or down
  nnoremap <a-up> :m .-2<cr>
  nnoremap <a-down> :m .+1<cr>
  " alt-up alt-down for moving this line up or down
  imap <a-up> <esc>:m .-2<cr>i
  imap <a-down> <esc>:m .+1<cr>i

  " alt-up alt-down for moving visual selection up or down
  vnoremap <a-up> :m '<-2<cr>gv
  vnoremap <a-down> :m '>+1<cr>gv

  let g:signify_sign_change = '~'
  let g:signify_sign_delete = '-'

  nmap ) <plug>(signify-next-hunk)
  nmap ( <plug>(signify-prev-hunk)

  set signcolumn=number

  " quit
  noremap <silent> <c-q> :qall<cr>

  " auto-refresh vimrc
  augroup vimrc
    au!
    au BufWritePost vimrc,.vimrc source $MYVIMRC | call InstallPlugins()
  augroup END

  nmap <c-z> u
  imap <c-z> <esc>u

  " window mappings
  noremap <leader>w <c-w>
  noremap <a-h> <c-w>h
  noremap <a-j> <c-w>j
  noremap <a-k> <c-w>k
  noremap <a-l> <c-w>l
  tnoremap <a-h> <c-\><c-n><c-w>h
  tnoremap <a-j> <c-\><c-n><c-w>j
  tnoremap <a-k> <c-\><c-n><c-w>k
  tnoremap <a-l> <c-\><c-n><c-w>l

  nmap <c-/> gcc
  vmap <c-/> gc gv
  imap <c-/> <ESC>gcc gi

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
  nmap <silent> <leader>gs :Neogit kind=tab<cr>
  " nmap <silent> <leader>gp :Git push<cr>
  " nmap <silent> <leader>gP :Git push -u origin HEAD<cr>
  " nmap <silent> <leader>gl :Git pull<cr>
  " nmap <silent> <leader>gf :Git fetch<cr>
  nmap <silent> <leader>gh :SignifyHunkDiff<cr>
  nmap <silent> <leader>gd :tabnew %<cr> :Gdiffsplit!<cr>
  nmap <silent> <leader>gS :diffput<cr>
  nmap <silent> <leader>gb :Telescope git_branches<cr>

  map <silent><C-n> :NERDTreeToggle<cr>
  let NERDTreeQuitOnOpen=1

  " open url under cursor
  nmap go yiu :!open $(command -v xsel &> /dev/null && xsel -b \|\| pbpaste) <cr><cr>

  " tabs
  nmap g1 1gt
  nmap g2 2gt
  nmap g3 3gt
  nmap g4 4gt
  nmap g5 5gt
  nmap g6 6gt
  nmap g7 7gt
  nmap g8 8gt
  nmap g9 9gt

  " Fish has too slow a startup time. Using bash speeds up git plugins
  set shell=/bin/bash

  " Make <c-w> in terminal go out of terminal "insert" mode so
  " window-switching commands can be used
  tmap <silent> <esc> <c-\><c-n>

  nmap <leader>T :te $SHELL<cr>

  augroup custom_term
      autocmd!
      autocmd TermOpen * setlocal bufhidden=hide nonumber norelativenumber winfixwidth winfixheight
  augroup END

  nmap <silent> <leader><leader> :Telescope lsp_document_symbols<cr>

  nmap <silent> gr :Telescope lsp_references<cr>
  nmap <silent> gd :Telescope lsp_definitions<cr>
  autocmd FileType markdown nnoremap <buffer> <silent> gd :ObsidianFollowLink<cr>
  nmap <silent> gD :Telescope lsp_type_definitions<cr>
  set completeopt=menu,menuone,noselect

  lua << EOF

  require "lsp_signature".setup({})

  local on_attach = function(client)
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})

    vim.api.nvim_buf_set_keymap(0, 'n', 'gk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', 'gj', '<cmd>lua vim.diagnostic.goto_next()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})

    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})

    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    if client.server_capabilities.documentHighlightProvider then
      vim.cmd([[
        autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      ]])
    end
  end

  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
  require('mason-tool-installer').setup {
    ensure_installed = { 'prettier', 'prettierd', 'biome', 'typst-lsp' },
    auto_update = true,
  }
  require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      javascriptreact = { require 'formatter.defaults.prettierd' },
      javascript = { require 'formatter.defaults.prettierd' },
      typescriptreact = { require 'formatter.defaults.prettierd' },
      typescript = { require 'formatter.defaults.prettierd' },
      json = { require 'formatter.defaults.prettierd' },
      markdown = { require 'formatter.defaults.prettierd' },
      html = { require 'formatter.defaults.prettierd' },
      css = { require 'formatter.defaults.prettierd' },
      rust = { require('formatter.filetypes.rust').rustfmt },
      svelte = { require 'formatter.defaults.prettierd' },
    }
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = true,
      signs = true,
    }
  )

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  local lspconfig = require("lspconfig")
  lspconfig.typst_lsp.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.astro.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.eslint.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
  }
  lspconfig.remark_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "markdown", "mdx" },
    single_file_support = false
  }
  lspconfig.vimls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.cssls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.lua_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
  lspconfig.sqlls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.zls.setup{ -- zig
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.svelte.setup{
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
        cargo = {
          allFeatures = true,
        },
        completion = {
          postfix = {
            enable = false,
          },
        },
      },
    },
  }

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<c-j>'] = function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end,
      ['<s-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = function(fallback)
        if cmp.visible() then
          fallback()
        else
          cmp.select_next_item()
        end
      end,
    }),
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
      },
      {
        {
          name = 'buffer',
          keyword_length = 4,
          option = {
          }
        },
        { name = 'vsnip' },
      },
      {
        {
          name = 'look',
          keyword_length = 5,
          option = {
            convert_case = true,
            loud = true
          }
        },
        }
    ),
    experimental = {
      ghost_text = true,
    },
  })
EOF


  " autocmd CursorHold * lua vim.diagnostic.open_float()
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  " inoremap <silent><expr> <TAB>
  "       \ pumvisible() ? "\<C-n>" :
  "       \ <SID>check_back_space() ? "\<TAB>" :
  "       \ coc#refresh()
  " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction

  " " Use <c-space> to trigger completion.
  " inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

  " Delay before highlighting word under cursor (and writing swap files)
  set updatetime=10

  " Allow comments in json
  autocmd FileType json syntax match Comment +\/\/.\+$+

  " open a file
  nmap <silent> <leader>o :Telescope find_files<cr>
  nmap <silent> <leader>O :Telescope file_browser<cr>

lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
    undo = {
      side_by_side = true,
      diff_context_lines = 5,
      mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").restore,
        },
      },
    }
  }
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")
EOF



  nmap <leader>kt :Telescope colorscheme<cr>
endif

" disable the default highlight group
let g:conflict_marker_highlight_group = ''
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
