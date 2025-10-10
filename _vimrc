" General
set number
set rnu
set clipboard=unnamed
set autowrite
set showcmd
set termguicolors
set shell=cmd.exe

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
highlight CocErrorHighlight cterm=underline gui=undercurl guisp=Red
highlight CocWarningHighlight cterm=underline gui=undercurl guisp=Orange
highlight CocInfoHighlight cterm=underline gui=undercurl guisp=Blue
highlight CocHintHighlight cterm=underline gui=undercurl guisp=Gray

" Jump to next diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Open diagnostics list
nmap <leader>d :CocList diagnostics<CR>

" Show details of diagnostic under cursor
nmap <leader>e :CocCommand diagnostics.showLineDiagnostics<CR>

" Normal mode
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap G Gzz

" Formatter
function! s:FormatFile()
  " If Neoformat knows this filetype, use it
  if exists('g:neoformat_enabled_' . &filetype)
    execute 'Neoformat'
  else
    echo "No formatter configured for " . &filetype
  endif
endfunction
nnoremap <leader>f :call <SID>FormatFile()<CR>

" For pwsh (PowerShell Core)
" Remove in the future
nnoremap <leader>r :w<CR>:!pwsh -ExecutionPolicy Bypass -File %<CR>

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
call plug#begin()

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'sbdchd/neoformat'

  Plug 'tpope/vim-commentary'

  " Custom colors:
  highlight Conceal ctermfg=239 guifg=#555555 ctermbg=NONE guibg=NONE
  Plug 'Yggdroot/indentLine'

call plug#end()
