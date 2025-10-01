" General
set number
set rnu
set clipboard=unnamed
set autowrite
set showcmd
set termguicolors
set shell=pwsh.exe

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

" Errors
highlight CocErrorHighlight gui=undercurl guisp=Red
highlight CocWarningHighlight gui=undercurl guisp=Orange
highlight CocInfoHighlight gui=undercurl guisp=Blue
highlight CocHintHighlight gui=undercurl guisp=Gray

" Normal mode
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap G Gzz

" Visual mode
vnoremap > >gv
vnoremap < <gv

" Insert mode
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"


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
highlight Conceal ctermfg=239 guifg=#555555 ctermbg=NONE guibg=NONE
Plug 'Yggdroot/indentLine'

call plug#end()
