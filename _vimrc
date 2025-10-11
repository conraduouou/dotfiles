" ======================
"  Master _vimrc
" ======================
let mapleader = " "
let maplocalleader = " "

for file in split(globpath('~/vimfiles/config', '*.vim'), '\n')
  execute 'source' file
endfor
