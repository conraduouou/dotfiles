" ======================
" Normal mode
" ======================

nnoremap <leader>h :nohlsearch<CR>

" Alt scrolling
nnoremap <C-d> <C-d>zz
vnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
vnoremap <C-u> <C-u>zz
" nnoremap <C-e> <C-e>
" vnoremap <C-e> <C-e>
" nnoremap <C-y> <C-y>
" vnoremap <C-y> <C-y>

nnoremap G Gzz

" Jump list
" nnoremap <A-o> <C-o>
" nnoremap <A-i> <C-i>

"Window navigation
nnoremap <C-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <C-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <C-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <C-l> :<C-U>TmuxNavigateRight<cr>

" CoC navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap K :call CocActionAsync('doHover')<CR>


" ======================
" Visual mode
" ======================

vnoremap > >gv
vnoremap < <gv


" ======================
" Insert mode completion
" ======================

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"


" ======================
" Escape remaps
" ======================

inoremap jk <Esc>
vnoremap jk <Esc>
xnoremap jk <Esc>
snoremap jk <Esc>


" ======================
" Move lines (moved from Alt to Ctrl)
" ======================

" nnoremap <C-k> :<C-u>execute 'move .-' . (v:count1 + 1)<CR>==
" nnoremap <C-j> :<C-u>execute 'move .+' . v:count1<CR>==

" inoremap <C-j> <Esc><Cmd>m .+1<CR>==gi
" inoremap <C-k> <Esc><Cmd>m .-2<CR>==gi

" vnoremap <C-j> :<C-u>execute "'<,'>move '>+" . v:count1<CR>gv=gv
" vnoremap <C-k> :<C-u>execute "'<,'>move '<-" . (v:count1 + 1)<CR>gv=gv


" ======================
" Leader mappings (namespaces)
" ======================

" For fzf
nnoremap <C-p> :Files<CR>

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fr :Rg<Space>
nnoremap <leader>fh :History<CR>

nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fL :Lines<CR>

nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fT :BTags<CR>

nnoremap <leader>mm :Maps<CR>
nnoremap <leader>mk :Marks<CR>

nnoremap <leader>cc :Commands<CR>

nnoremap <leader>: :History:<CR>

" For fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log<CR>

nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gA :Git add .<CR>

nnoremap <leader>gc :Git commit<CR>

nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git pull<CR>

nnoremap <leader>ge :Gedit<CR>

" For diagnostics (CoC at this time)
nnoremap <leader>dp <Plug>(coc-diagnostic-prev)
nnoremap <leader>dn <Plug>(coc-diagnostic-next)
nnoremap <leader>dl :CocList diagnostics<CR>
nnoremap <leader>dh :CocCommand diagnostics.showLineDiagnostics<CR>


" ======================
" Miscellaneous
" ======================

" increment
" nnoremap <A-a> <C-a>
" vnoremap <A-a> <C-a>

" decrement
" nnoremap <A-x> <C-x>
" vnoremap <A-x> <C-x>

" redo
" nnoremap <A-r> <C-r>
