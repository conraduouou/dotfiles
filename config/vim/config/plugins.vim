" ======================
" Plugins
" ======================

" Determine OS
if has('win32') || has('win64')
    call plug#begin()
else
    call plug#begin(expand('~/.config/vim/plugged'))
endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'matze/vim-move'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
