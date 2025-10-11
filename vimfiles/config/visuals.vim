" Line numbers & cursor highlight
highlight SignColumn ctermbg=NONE guibg=NONE
set cursorline
set cursorlineopt=number
highlight CursorLineNr guifg=#000000 guibg=#ffff00 gui=NONE

" Diagnostic highlights (Coc)
highlight CocErrorHighlight cterm=underline gui=undercurl guisp=Red
highlight CocWarningHighlight cterm=underline gui=undercurl guisp=Orange
highlight CocInfoHighlight cterm=underline gui=undercurl guisp=Blue
highlight CocHintHighlight cterm=underline gui=undercurl guisp=Gray

" Custom colors
highlight Conceal ctermfg=239 guifg=#555555 ctermbg=NONE guibg=NONE
