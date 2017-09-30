let g:lintlangs = [
      \ 'bash',
      \ 'sh',
      \ 'zsh',
      \ 'vim',
      \ 'javascript',
      \ 'typescript',
      \ 'python',
      \ 'css',
      \ 'sugarss',
      \ 'json',
      \ 'markdown',
      \ 'yaml'
      \ ]

Plug 'w0rp/ale', {'for': g:lintlangs}

let g:ale_linter_aliases = {}
let g:ale_linter_aliases['sugarss'] = 'css'
let g:ale_lint_delay = 0

let g:ale_javascript_prettier_executable = 'prettier'
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_typescript_prettier_executable = 'prettier_d'
let g:ale_typescript_eslint_executable = 'eslint_d'
let g:ale_typescript_prettier_use_local_config = 1

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['python'] = ['yapf', 'isort', 'autopep8']

let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_linters['typescript'] = ['tsserver', 'eslint']
let g:ale_linters['css'] = ['stylelint']
let g:ale_fix_on_save = 1

nmap <silent> <c-k> <plug>(ale_previous_wrap)
nmap <silent> <c-j> <plug>(ale_next_wrap)
