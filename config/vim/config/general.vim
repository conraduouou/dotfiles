" General
set number
set nowrap
set rnu
set clipboard=unnamed
set autowrite
set showcmd

" Determine OS
if has('win32') || has('win64')
    set shell=cmd.exe
else
    set shell=zsh
endif

set autoread
set updatetime=50
set tabstop=4
set shiftwidth=4
set softtabstop=1
set expandtab
set ignorecase
set smartcase
syntax on
