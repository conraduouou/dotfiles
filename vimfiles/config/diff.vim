" For vimdiff
if exists('g:loaded_my_diff')
  finish
endif

let g:loaded_my_diff = 1

function! SetupDiffMode()
  if !&diff
    return
  endif

  " Diff behavior
  syntax off
  set scrollbind
  set cursorbind
  set foldmethod=diff
  set diffopt+=vertical

  " Diff colors
  highlight DiffAdd    term=bold cterm=bold ctermfg=NONE ctermbg=22 gui=bold guifg=NONE guibg=#204020
  highlight DiffDelete term=bold cterm=bold ctermfg=NONE ctermbg=52 gui=bold guifg=NONE guibg=#502020
  highlight DiffChange term=bold cterm=bold ctermfg=NONE ctermbg=17 gui=bold guifg=NONE guibg=#202050
  highlight DiffText   term=bold cterm=bold ctermfg=NONE ctermbg=24 gui=bold guifg=NONE guibg=#205080

  highlight Normal     guifg=#d0d0d0 guibg=#101010
  highlight LineNr     guifg=#666666 guibg=#101010
  highlight CursorLine guibg=#202020
  highlight SignColumn guibg=#101010
endfunction

augroup MyDiff
  autocmd!
  autocmd VimEnter * call SetupDiffMode()
  autocmd OptionSet diff call SetupDiffMode()
augroup END
