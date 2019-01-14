execute pathogen#infect()

set nocompatible
set backspace=2

syntax on

" filetype plugin indent on

autocmd FileType javascript JsPreTmpl html
let g:typescript_indent_disable = 1
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

set noshowmode
