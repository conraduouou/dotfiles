" ======================
" Formatter
" ======================
function! FormatFile()
  " Save the current buffer to disk first
  write

  let l:filetype = &filetype
  let l:filepath = expand('%:p')

  " If file is PowerShell
  if l:filetype ==# 'powershell' || l:filetype ==# 'ps1'
    " Escape single quotes safely
    let l:pspath = substitute(l:filepath, "'", "''", 'g')
    let l:pspathq = "'" . l:pspath . "'"

    " Create a temporary PowerShell script file
    let l:tmpfile = tempname() . '.ps1'
    call writefile([
          \ 'if (-not (Get-Command Invoke-Formatter -ErrorAction SilentlyContinue)) {',
          \ '  Write-Error "Invoke-Formatter not found. Please install PSScriptAnalyzer."',
          \ '  exit 1',
          \ '}',
          \ '$s = Get-Content -Raw -LiteralPath ' . l:pspathq,
          \ '# Normalize line endings to CRLF to avoid mixed-line-ending errors',
          \ '$s = $s -replace "(\r\n|\r|\n)", "`r`n"',
          \ '$formatted = Invoke-Formatter -ScriptDefinition $s',
          \ 'if (-not $formatted) { $formatted = $s }',
          \ '[System.IO.File]::WriteAllText(' . l:pspathq . ', $formatted, [System.Text.Encoding]::UTF8)',
          \ ], l:tmpfile)
    
    " Run it with PowerShell
    let l:cmd = 'pwsh -NoProfile -ExecutionPolicy Bypass -File ' . shellescape(l:tmpfile)
    let l:res = system(l:cmd)
    
    " Check the result; keep the temp file if it failed so the user can inspect it
    if v:shell_error
      echohl ErrorMsg
      echom "PowerShell formatting failed (" . v:shell_error . ")"
      echohl None
      echom l:res
      echom "Temp script remains at: " . l:tmpfile
    else
      " success -> remove temp script
      call delete(l:tmpfile)
      echom "Formatted with Invoke-Formatter!"
      silent! edit!
    endif
  endif

  " Fallback: Neoformat if configured
  if exists('g:neoformat_enabled_' . l:filetype)
    execute 'Neoformat'
  else
    echo "No formatter configured for " . l:filetype
  endif
endfunction

" ======================
" Runner
" ======================
function! RunFile()
  write
  let l:filetype = &filetype
  let l:filepath = expand('%:p')

  if l:filetype ==# 'python'
    execute '!python3 ' . shellescape(l:filepath)
  elseif l:filetype ==# 'javascript'
    execute '!node ' . shellescape(l:filepath)
  elseif l:filetype ==# 'typescript'
    execute '!ts-node ' . shellescape(l:filepath)
  elseif l:filetype ==# 'lua'
    execute '!lua ' . shellescape(l:filepath)
  elseif l:filetype ==# 'powershell' || l:filetype ==# 'ps1'
    execute '!pwsh -ExecutionPolicy Bypass -File ' . shellescape(l:filepath)
  elseif l:filetype ==# 'bash'
    execute '!bash ' . shellescape(l:filepath)
  elseif l:filetype ==# 'cpp'
    execute '!g++ ' . shellescape(l:filepath) . ' -o %:r && ./%:r'
  elseif l:filetype ==# 'c'
    execute '!gcc ' . shellescape(l:filepath) . ' -o %:r && ./%:r'
  else
    echo "No run command configured for filetype: " . l:filetype
  endif
endfunction
