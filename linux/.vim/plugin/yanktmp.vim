" yanktmp.vim - Yank string write to tmpfile and read from tmpfile
" Author:       secondlife <hotchpotch@NOSPAM@gmail.com>
" Last Change:  2006 July 05
" Version: 0.1, for Vim 7.0

" DESCRIPTION:
"  This plugin enables vim to yank and paste through the multi processes.
"
"  If :call YanktmpYank(), yank string write to tmpfile.
"  And :call YanktmpPaste_p() or YanktmpPaste_P(), paste string from tmpfile.
"  
"  Default tmp file is '/tmp/vimyanktmp'
"  If you want to change tmp file.
"  let g:yanktmp_file = '/tmp/example_tmp_file'
"
" ==================== file yanktmp.vimrc ====================
" map <silent> sy :call YanktmpYank()<CR>
" map <silent> sp :call YanktmpPaste_p()<CR>
" map <silent> sP :call YanktmpPaste_P()<CR>
" ==================== end: yanktmp.vimrc ====================

if v:version < 700 || (exists('g:loaded_yanktmp') && g:loaded_yanktmp || &cp)
  finish
endif
let g:loaded_yanktmp = 1

if !exists('g:yanktmp_file')
  let g:yanktmp_file = '/tmp/vimyanktmp'
endif

function! YanktmpYank() range
  call writefile(getline(a:firstline, a:lastline), g:yanktmp_file, 'b')
endfunction

function! YanktmpPaste_p() range
  let pos = getpos('.')
  call append(a:firstline, readfile(g:yanktmp_file, "b"))
  call setpos('.', [0, pos[1] + 1, 1, 0])
endfunction

function! YanktmpPaste_P() range
  let pos = getpos('.')
  call append(a:firstline - 1, readfile(g:yanktmp_file, "b"))
  call setpos('.', [0, pos[1], 1, 0])
endfunction

