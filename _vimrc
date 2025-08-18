" General
set number
set rnu
set clipboard=unnamed
set autowrite
set showcmd
set termguicolors

set autoread
set updatetime=50
syntax on

let mapleader = " "
let maplocalleader = " "

" LSP marker column colors
highlight SignColumn ctermbg=NONE guibg=NONE

" Line highlighting
set cursorline
set cursorlineopt=number
highlight CursorLineNr guifg=#000000 guibg=#ffff00 gui=NONE

" Normal mode
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap G Gzz

" Visual mode
vnoremap > >gv
vnoremap < <gv

" Escape remaps
inoremap jk <Esc>
vnoremap jk <Esc>
xnoremap jk <Esc>
snoremap jk <Esc>

" Spacing
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" For vim-plug I guess
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-commentary'

" Custom colors:
let g:indentLine_setColors = 0
let g:indentLine_color_term = 239       " Terminal Vim
let g:indentLine_color_gui = '#555555'  " GUI Vim
let g:indentLine_char = '│'    " character for the line
let g:indentLine_enabled = 1
highlight Conceal ctermfg=239 guifg=#555555 ctermbg=NONE guibg=NONE
Plug 'Yggdroot/indentLine'

call plug#end()
