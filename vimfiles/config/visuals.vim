" Must-have
set termguicolors

" For configuring cursor
if &term == 'win32' || &term =~ 'xterm'
    let &t_SI = "\e[6 q"   " steady beam (Insert)
    let &t_SR = "\e[4 q"   " steady underline (Replace)
    let &t_EI = "\e[2 q"   " steady block (Normal)
    let &t_ti .= "\e[2 q"  " block on startup
    let &t_te .= "\e[0 q"  " restore terminal default on exit
endif

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

" Folding
set foldcolumn=1
set fillchars=fold:\ ,foldopen:,foldclose:,foldsep:\ ,eob:\ 

" Keep Vim's default fold text (shows the first line)
set foldtext=

" Fold colors
highlight FoldColumn guibg=NONE guifg=#555555
highlight Folded guifg=#b5b5b5 guibg=#2d2d2d gui=NONE
