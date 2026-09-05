" ======================
" Normal mode
" ======================

nnoremap <Esc> <Esc>

" Navigate wrapped lines
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Muscle memory: remove highlight
nnoremap <leader>h :nohlsearch<CR>

" Scrolling
nnoremap <C-d> <C-d>zz
vnoremap <C-d> <C-d>zz

nnoremap <C-u> <C-u>zz
vnoremap <C-u> <C-u>zz

" Jumps
nnoremap <C-o> <C-o>zz
nnoremap <C-S-o> <C-i>zz

" Buffer switching
nnoremap <C-S-h> :vsc Window.PreviousDocumentWindow<CR>
nnoremap <C-S-l> :vsc Window.NextDocumentWindow<CR>

" Center when going to bottom
nnoremap G Gzz


" ======================
" Visual mode
" ======================

vnoremap > >gv
vnoremap < <gv


" ======================
" Insert mode
" ======================

inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l


" ======================
" Escape remaps
" ======================

inoremap jk <Esc>


" ======================
" Buffers namespace
" ======================

" Visual Studio documents/tabs replace Vim's buffer model.
nnoremap <leader>bp :vsc Window.PreviousDocumentWindow<CR>
nnoremap <leader>bn :vsc Window.NextDocumentWindow<CR>
nnoremap <leader>bb :enew<CR>
nnoremap <leader>bx :vsc Window.CloseDocumentWindow<CR>


" ======================
" Windows namespace
" ======================

nnoremap <leader>w' <C-w>s
nnoremap <leader>w; :vsc Window.MoveToNewTabGroupRight<CR>
nnoremap <leader>we <C-w>=
nnoremap <leader>wx <C-w>q


" ======================
" Window resizing
" ======================

" VsVim supports Vim's resize commands, but the Lua timer /
" vim.on_key repeat mechanism has no direct Vimscript equivalent
" in VsVim.
"
" Fine adjustments
nnoremap <leader>wh :vertical resize -1<CR>
nnoremap <leader>wl :vertical resize +1<CR>
nnoremap <leader>wj :resize +1<CR>
nnoremap <leader>wk :resize -1<CR>

" Coarse adjustments
nnoremap <leader>wH :vertical resize -5<CR>
nnoremap <leader>wL :vertical resize +5<CR>
nnoremap <leader>wJ :resize +5<CR>
nnoremap <leader>wK :resize -5<CR>


" ======================
" fzf
" ======================

nnoremap <leader>ff :vsc Edit.GoToFile<CR>
nnoremap <leader>fb :vsc Window.NextDocumentWindow<CR>
nnoremap <leader>fr :vsc Edit.FindinFiles<CR>

" Search current buffer lines
nnoremap <leader>fl :vsc Edit.Find<CR>

nnoremap <leader>ft :vsc Edit.GoToAll<CR>
nnoremap <leader>fT :vsc Edit.GoToCurrentDocumentSymbol<CR>


" ======================
" Fugitive
" ======================

nnoremap <leader>gs :vsc Team.Git.ShowGitChanges<CR>


" ======================
" Diagnostics (LSP)
" ======================

" Visual Studio/Roslyn owns diagnostics, so use its error navigation.
nnoremap <C-]> :vsc View.NextError<CR>
nnoremap <C-S-]> :vsc View.PreviousError<CR>

" Document/workspace diagnostic lists:
" Visual Studio's Error List combines these concepts.
nnoremap <leader>dl :vsc View.ErrorList<CR>
nnoremap <leader>dL :vsc View.ErrorList<CR>

" Show diagnostic / Quick Info
nnoremap <leader>dd :vsc Edit.QuickInfo<CR>


" ======================
" LSP navigation
" ======================

nnoremap gd :vsc Edit.GoToDefinition<CR>
nnoremap gy :vsc Edit.GoToTypeDefinition<CR>
nnoremap gi :vsc Edit.GoToImplementation<CR>
nnoremap gr :vsc Edit.FindAllReferences<CR>

nnoremap <leader>ll :vsc Edit.QuickInfo<CR>


" ======================
" Miscellaneous
" ======================

cnoremap <C-v> <C-r>+
