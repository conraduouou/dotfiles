" ======================
" Plugins
" ======================

" Remove function argument on Windows
call plug#begin(expand('~/.config/vim/plugged'))

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sbdchd/neoformat'
  Plug 'tpope/vim-commentary'
  Plug 'Yggdroot/indentLine'
  Plug 'matze/vim-move'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'

call plug#end()
