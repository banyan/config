"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buftabs (C) 2006 Ico Doornekamp
"
" This program is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation; either version 2
" of the License, or (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" Introduction
" ------------
" This is a simple script that shows a tabs-like list of buffers in the bottom
" of the window. The biggest advantage of this script over various others is
" that it does not take any lines away from your terminal, leaving more space
" for the document you're editing. The tabs are only visible when you need
" them - when you are switchin between buffers.
"
" Usage
" -----
" This script draws buffer tabs on vim startup, when a new buffer is created
" and when switching between buffers.
"
" It might be handy to create a few maps for easy switching of buffers in your
" .vimrc file. For example, using F1 and F2 keys:
"
"   noremap <f1> :bprev<CR> 
"   noremap <f2> :bnext<CR>
"
" or using control-left and control-right keys:
"
"   :noremap <C-left> :bprev<CR>
"   :noremap <C-right> :bnext<CR>
"
"
" The following extra configuration variables are availabe:
" 
" * g:buftabs_only_basename
"
"   Define this variable to make buftabs only print the filename of each buffer,
"   omitting the preceding directory name. Add to your .vimrc:
"
"   :let g:buftabs_only_basename=1
"
"
" * g:buftabs_in_statusline
"
"   Define this variable to make the plugin show the buftabs in the statusline
"   instead of the command line. It is a good idea to configure vim to show
"   the statusline as well when only one window is open. Add to your .vimrc:
"
"   set laststatus=2
"   :let g:buftabs_in_statusline=1
"    
"
" Bugs
" ----
"
" Vim's 'set hidden' option is known to break this plugin - for some reason
" vim will overwrite the buftabs when this option is enabled. 
"
"
" Changelog
" ---------
" 
" 0.1	 2006-09-22	 Initial version	
"
" 0.2	 2006-09-22  Better handling when the list of buffers is longer then the
"                  window width.
"
" 0.3	 2006-09-27  Some cleanups, set 'hidden' mode by default
"
" 0.4	 2007-02-26  Don't draw buftabs until VimEnter event to avoid clutter at
"                  startup in some circumstances
"
" 0.5	 2007-02-26  Added option for showing only filenames without directories
"                  in tabs
"
" 0.6	 2007-03-04  'only_basename' changed to a global variable.  Removed
"                  functions and add event handlers instead.  'hidden' mode 
"                  broke some things, so is disabled now. Fixed documentation
"
" 0.7  2007-03-07	 Added configuration option to show tabs in statusline
"                  instead of cmdline
"
" 0.8  2007-04-02	 Update buftabs when leaving insertmode
"
" 0.9  2007-08-22	 Now compatible with older Vim versions < 7.0
"
" 0.10 2008-01-26	 Added GPL license
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" Called on VimEnter event
"

let s:buftabs_enabled = 0

function! Buftabs_enable()
	let s:buftabs_enabled = 1
endfunction


"
" Draw the buftabs
"

function! Buftabs_show()

	let l:i = 1
	let l:list = ''
	let l:start = 0
	let l:end = 0
	if ! exists("s:from") 
		let s:from = 0
	endif

	if s:buftabs_enabled != 1 
		return
	endif

	" Walk the list of buffers

	while(l:i <= bufnr('$'))

		" Only show buffers in the list, and omit help screens
	
		if buflisted(l:i) && getbufvar(l:i, "&modifiable") 

			" Append the current buffer number and name to the list. If the buffer
			" is the active buffer, it is enclosed in square brackets. If it is
			" modified, it is appended with an exclaimation mark

			if bufwinnr(l:i) != -1
				let l:list = l:list . '['
				let l:start = strlen(l:list)
			else
				let l:list = l:list . ' '
			endif
				
			let l:list = l:list . l:i . "-" 

			if exists("g:buftabs_only_basename")
				let l:list = l:list . fnamemodify(bufname(l:i), ":t")
			else
				let l:list = l:list . bufname(l:i)
			endif

			if getbufvar(l:i, "&modified") == 1
				let l:list = l:list . "!"
			endif
			
			if bufwinnr(l:i) != -1
				let l:list = l:list . ']'
				let l:end = strlen(l:list)
			else
				let l:list = l:list . ' '
			endif
		end

		let l:i = l:i + 1
	endwhile

	" If the resulting list is too long to fit on the screen, chop
	" out the appropriate part

	let l:width = winwidth(0) - 12

	if(l:start < s:from) 
		let s:from = l:start - 1
	endif
	if l:end > s:from + l:width
		let s:from = l:end - l:width 
	endif
		
	let l:list = strpart(l:list, s:from, l:width)

	" Show the list. The buftabs_in_statusline variable determines of the list
	" is displayed in the command line (volatile) or in the statusline
	" (persistent)

	if exists("g:buftabs_in_statusline")
		let g:buftabs_list = l:list
		set statusline=\ %{g:buftabs_list}%=%l,%c\ 
	else
		redraw
		echon l:list
	end

endfunction


" Hook to events to show buftabs at startup, when creating and when switching
" buffers

autocmd VimEnter * call Buftabs_enable()
autocmd VimEnter,BufNew,BufEnter,BufWritePost * call Buftabs_show()
if version >= 700
	autocmd InsertLeave,VimResized * call Buftabs_show()
end

" vi: ts=2 sw=2

