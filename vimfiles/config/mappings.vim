" ======================
" Normal mode
" ======================
nnoremap <leader>h :nohlsearch<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap G Gzz
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap K :call CocActionAsync('doHover')<CR>

" ======================
" Diagnostics (CoC)
" ======================
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>d :CocList diagnostics<CR>
nmap <leader>e :CocCommand diagnostics.showLineDiagnostics<CR>

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
" Leader mappings (for functions)
" ======================
nnoremap <leader>f :call FormatFile()<CR>
nnoremap <leader>r :call RunFile()<CR>
