" ======================
" Normal mode
" ======================

" Navigate wrapped lines
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Muscle memory: remove highlight
nnoremap <leader>h :nohlsearch<CR>

" Scrolling
nnoremap <C-d> <C-d>zz
vnoremap <C-d> <C-d>zz

nnoremap <C-u> <C-u>zz
vnoremap <C-u> <C-u>zz

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
nnoremap <leader>bp :vsc Window.PreviousTab<CR>
nnoremap <leader>bn :vsc Window.NextTab<CR>
nnoremap <leader>bb :enew<CR>
nnoremap <leader>bx :vsc Window.CloseDocumentWindow<CR>


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

" Document/workspace diagnostic lists
nnoremap <leader>dl :vsc View.ErrorList<CR>

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
" Editor
" ======================

nnoremap <leader>ea :vsc View.QuickActions<CR>
vnoremap <leader>ea :vsc View.QuickActions<CR>
vnoremap <leader>ef :vsc Edit.FormatSelection<CR>
nnoremap <leader>eF :vsc Edit.FormatDocument<CR>
nnoremap <leader>er :vsc Refactor.Rename<CR>


" ======================
" Code operations
" ======================

nnoremap <leader>cd :vsc Debug.Start<CR>
nnoremap <leader>cD :vsc Debug.Restart<CR>
nnoremap <leader>cb :vsc Build.BuildSolution<CR>
nnoremap <leader>cB :vsc Build.RebuildSolution<CR>


" ======================
" Copilot
" ======================

nnoremap <leader>aa :vsc View.GitHub.Copilot.Chat<CR>
nnoremap <leader>an :vsc GitHub.Copilot.Chat.NewThread<CR>
nnoremap <leader>ax :vsc GitHub.Copilot.Chat.DeleteCurrentThread<CR>
nnoremap <leader>ay :vsc Copilot.KeepCurrentChange<CR>
nnoremap <leader>aY :vsc Copilot.KeepAll<CR>
nnoremap <leader>ao :vsc Copilot.Open.Output.Window<CR>


" ======================
" Miscellaneous
" ======================

cnoremap <C-v> <C-r>+
