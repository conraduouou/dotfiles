" ======================
"  Master _vimrc
" ======================
let mapleader = " "
let maplocalleader = " "

set runtimepath^=$HOME/vimfiles

for file in split(globpath('~/vimfiles/config', '*.vim'), '\n')
  execute 'source' file
endfor

# For vim-move to use ctrl instead of alt
let g:move_key_modifier = 'C'
