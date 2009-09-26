" File: tagexplorer.vim
" Author: Yegappan Lakshmanan (yegappan AT yahoo DOT com)
" Version: 1.2
" Last Modified: Dec 26, 2002
"
" Overview
" --------
" The "Tag Explorer" plugin provides the following features:
"
" 1. Opens a vertically/horizontally split Vim window with a list of files in
"    a directory. You can list all the tags (functions, classes, structures,
"    variables, etc) defined in a file. You can jump to the location where a
"    tag is defined. You can edit a selected file. You can browse through the
"    directories.
" 2. Groups the tags by their type and displays them in a foldable tree.
" 3. When a tag name is selected from the explorer window, positions the cursor
"    at the definition of the tag in the source file
" 4. Can display the prototype of a tag from the tag explorer window.
" 5. Displays the scope of a tag.
" 6. The displayed tags can be sorted either by name or by line number.
" 7. Supports the following programming language files: Assembly, ASP, Awk, C,
"    C++, Cobol, Eiffel, Fortran, Java, Lisp, Make, Pascal, Perl, PHP, Python,
"    Rexx, Ruby, Scheme, Shell, Slang, Sql, TCL, Verilog, Vim and Yacc.
" 8. Runs in all the platforms where the exuberant ctags utility and Vim are
"    supported (this includes MS-Windows and Unix based systems).
" 9. Runs in both console/terminal and GUI versions of Vim.
"
" This plugin relies on the exuberant ctags utility to generate the tag
" listing. You can download the exuberant ctags utility from
" http://ctags.sourceforge.net. The exuberant ctags utility must be installed
" in your system to use this plugin. Exuberant ctags version 5.3 and above is
" recommended.  There is no need for you to create a tags file to use this
" plugin.
"
" Installation
" ------------
" 1. Copy the tagexplorer.vim script to the $HOME/.vim/plugin directory.
"    Refer to ':help add-plugin', ':help add-global-plugin' and ':help
"    runtimepath' for more details about Vim plugins.
" 2. Set the TE_Ctags_Path variable to point to the exuberant ctags utility
"    path.
" 3. If you are running a terminal/console version of Vim and the terminal
"    doesn't support changing the window width then set the TE_Adjust_Winwidth
"    variable to 0.
" 4. Restart Vim.
" 5. You can use the ":TagExplorer" command to open/close the tag explorer
"    window. 
"
" Usage
" -----
" You can open the tag explorer window using the ":TagExplorer" command.
" Invoking this command will toggle (open or close) the tag explorer window.
" You can map a key to invoke this command:
"
"               nnoremap <silent> <F8> :TagExplorer<CR>
"
" Add the above mapping to your ~/.vimrc file.
"
" You can close the tag explorer window from the tag explorer window by
" pressing 'q' or using the Vim ":q" or using one of the Vim window CTRL-W
" commands.
"
" When the tag explorer window is opened, the names of all the directories
" and files in the current directory will be displayed.
"
" When a directory name is selected by pressing the <Enter> key or by double
" clicking with the mouse, the contents of the selected directory will be
" displayed. You can go to the parent directory by selecting the ".." entry.
"
" When a file name is selected by pressing the <Enter> key or by double
" clicking with the mouse, the selected file will be opened in a window.
"
" You can display all the tags (variable, function, class, etc) defined in a
" file using the 'o' command.  The tag names will grouped by their type
" (variable, function, class, etc) and displayed as a foldable tree using the
" Vim folding support. You can collapse the tree using the 'c' command. You
" can open the tree using the 'o' command.  You can also use the mouse to
" open/close the folds. You can use the '+' and '-' keys to open and close the
" folds for a tag type.
"
" You can select a tag either by pressing the <Enter> key or by double
" clicking the tag name using the mouse.
"
" For tags with scope information (like class members, structures inside
" structures, etc), the scope information will be displayed in square brackets
" "[]" after the tagname.
"
" By default, the tag list will be sorted by the order in which the tags
" appear in the file. You can sort the tags either by name or by order by
" pressing the "s" key in the tag explorer window.
"
" You can display the prototype of a tag by pressing <Spacebar> key when
" the cursor is placed over a tag name.
"
" You can update the tags listed for a file by pressing the 'u' key in the tag
" explorer window.
"
" You can open a different directory by using the 'g' command. You will be
" prompted to enter the name of the directory. You can recall the previously
" entered directory names by pressing the Up and Down arrow keys. The last
" displayed directory name will be the first available name in the history.
"
" To get help on the keys, press the "?" key in the tag explorer window.
"
" This script relies on the Vim "filetype" detection mechanism to determine
" the type of the current file. To turn on filetype detection use
"
"               :filetype on
"
" This script will not work in 'compatible' mode.  Make sure the 'compatible'
" option is not set.
"
" Configuration
" -------------
" By changing the following variables you can configure the behavior of this
" plugin. Set the following variables in your .vimrc file using the 'let'
" command.
"
" The plugin uses the TE_Ctags_Path variable to locate the ctags utility.  By
" default, this is set to ctags. Set this variable to point to the location of
" the ctags utility in your system:
"
"               let TE_Ctags_Path = 'd:\tools\ctags.exe'
"
" By default, the tag names will be listed in the order in which they are
" defined in the file. You can alphabetically sort the tag names by pressing
" the "s" key in the tag explorer window. You can also change the default
" order by setting the variable TE_Sort_Type to "name" or "order":
"
"               let TE_Sort_Type = "name"
"
" By default, all the file names in a directory will be displayed in the
" explorer window. If you want to display only selective filenames, you can
" set the 'TE_Include_File_Pattern' variable. If this variable is set to empty
" string, all the files in the directory will be displayed. You have to set
" this variable to a Vim regular expression pattern value. For example, to
" display only .c and .h files, set this variable to
"
"               let TE_Include_File_Pattern = '.*\.c$\|.*\.h$'
"
" You can set the 'TE_Exclude_File_Pattern' variable to skip file names
" matching a Vim regular expression pattern. For example, to skip the .o, .obj
" .bak, core and tags files, set this variable to
"
"               let TE_Exclude_File_Pattern = '.*\.o$\|.*\.obj$\|.*\.bak$' .
"                                             '\|.*\.swp$\|core\|tags'
"
" By default, all the sub-directory names in a directory will be displayed in
" the explorer window. If you want to display only selective directories, you
" can set the 'TE_Include_Dir_Pattern' variable. If this variable is set to
" empty string, all the sub-directories in the directory will be displayed.
" You have to set this variable to a Vim regular expression pattern value.
" For example, to include only those directories containing vim or unix in the
" name, use
"
"               let TE_Include_Dir_Pattern = '.*vim.*\|.*unix.*'
"
" You can set the 'TE_Exclude_Dir_Pattern' variable to skip directories
" matching a Vim regular expression pattern. By default, this variable is set
" to empty. For example, to exclude all the directories starting with obj or
" containing test, use
"
"               let TE_Exclude_Dir_Pattern = 'obj.*\|.*test.*'
"
" Be default, the tag names will be listed in a vertically split window.  If
" you prefer a horizontally split window, then set the 'TE_Use_Horiz_Window'
" variable to 1. If you are running MS-Windows version of Vim in a MS-DOS
" command window, then you should use a horizontally split window instead of a
" vertically split window.  Also, if you are using an older version of xterm
" in a Unix system that doesn't support changing the xterm window width, you
" should use a horizontally split window.
"
"               let TE_Use_Horiz_Window = 1
"
" By default, the vertically split tag explorer window will appear on the left
" hand side. If you prefer to open the window on the right hand side, you can
" set the TE_Use_Right_Window variable to one:
"
"               let TE_Use_Right_Window = 1
"
" You can also open the tag explorer window on startup using the following
" command line:
"
"               $ vim +TagExplorer
"
" The default width of the vertically split tag explorer window will be 30.
" This can be changed by modifying the TE_WinWidth variable:
"
"               let TE_WinWidth = 20
"
" Note that the value of the 'winwidth' option setting determines the minimum
" width of the current window. If you set the 'TE_WinWidth' variable to a
" value less than that of the 'winwidth' option setting, then Vim will use the
" value of the 'winwidth' option.
"
" By default, when the width of the window is less than 100 and a new tag
" explorer window is opened vertically, then the window width will be
" increased by the value set in the TE_WinWidth variable to accomodate the new
" window.  The value of this variable is used only if you are using a
" vertically split tag explorer window.  If your terminal doesn't support
" changing the window width from Vim (older version of xterm running in a Unix
" system) or if you see any weird problems in the screen due to the change in
" the window width or if you prefer not to adjust the window width then set
" the 'TE_Adjust_Winwidth' variable to 0.  CAUTION: If you are using the
" MS-Windows version of Vim in a MS-DOS command window then you must set this
" variable to 0, otherwise the system may hang due to a Vim limitation
" (explained in :help win32-problems)
"
"               let TE_Adjust_Winwidth = 0
"
" ****************** Do not modify after this line ************************
if exists('loaded_tagexplorer') || &cp
    finish
endif
let loaded_tagexplorer=1

" Location of the exuberant ctags tool
if !exists('TE_Ctags_Path')
    let TE_Ctags_Path = 'ctags'
endif

" Tag list sort control. Valid values are 'order' and 'name'
if !exists('TE_Sort_Type')
    let TE_Sort_Type = 'order'
endif

" Tag explorer window split (horizontal/vertical) control
if !exists('TE_Use_Horiz_Window')
    let TE_Use_Horiz_Window = 0
endif

" Increase Vim window width to display vertically split tag explorer window.
" For MS-Windows version of Vim running in a MS-DOS window, this must be set
" to 0 otherwise the system may hang due to a Vim limitation.
if !exists('TE_Adjust_Winwidth')
    if (has('win16') || has('win95')) && !has('gui_running')
        let TE_Adjust_Winwidth = 0
    else
        let TE_Adjust_Winwidth = 1
    endif
endif

" Vertically split tag explorer window width setting
if !exists('TE_WinWidth')
    let TE_WinWidth = 30
endif

" Open the vertically split tag explorer window on the left or on the right
" side.  This setting is relevant only if TE_Use_Horiz_Window is set to
" zero (i.e.  only for vertically split windows)
if !exists('TE_Use_Right_Window')
    let TE_Use_Right_Window = 0
endif

" Tag explorer will display only those files with names matching the pattern
" specified by the TE_Include_File_Pattern option. If this option is set to
" empty string, then all the files will be displayed. By default, this option
" is set to empty string.
" Use Vim regular expression for specifying this option
if !exists('TE_Include_File_Pattern')
    let TE_Include_File_Pattern = ''
endif

" Tag explorer will display those files with names not matching the pattern
" specified by the TE_Exclude_File_Pattern option. If this option is set to
" empty string, then all the files will be displayed.
" Use Vim regular expression for specifying this option
if !exists('TE_Exclude_File_Pattern')
    let TE_Exclude_File_Pattern = '.*\.o$\|.*\.obj$\|.*\.bak$\|.*\.swp$' .
                                  \ '\|core\|tags\|TAGS\|ID'
endif

" Tag explorer will display only those directories with names matching the
" pattern specified by the TE_Include_Dir_Pattern option. If this option is
" set to empty string, then all the directories will be displayed.  By
" default, this is set to empty string.
" Use Vim regular expression for specifying this option
if !exists('TE_Include_Dir_Pattern')
    let TE_Include_Dir_Pattern = ''
endif

" Tag explorer will display those directories with names not matching the
" pattern specified by the TE_Exclude_Dir_Pattern option. If this option is
" set to empty string, then all the directories will be displayed. By default,
" this is set to empty string.
" Use Vim regular expression for specifying this option
if !exists('TE_Exclude_Dir_Pattern')
    let TE_Exclude_Dir_Pattern = ''
endif

" Script local variable to keep track of the tag explorer state information
let s:current_dirname = ''
let s:te_file_cnt = 0
let s:comments = 3
let s:te_winsize_chgd = 0

" TE_DeleteStateInfo()
" Delete all variables created for a directory
function! s:TE_DeleteStateInfo()
    while s:te_file_cnt != 0
        " For every file listed for the directory, remove all the variables
        " associated with the file
        unlet! b:te_{s:te_file_cnt}_name
        unlet! b:te_{s:te_file_cnt}_start
        unlet! b:te_{s:te_file_cnt}_end

        " Remove all the variables associated with the different tag types
        " displayed for the file
        let var = 'b:te_' . s:te_file_cnt . '_ttype_cnt'
        if exists(var)
            let i = 1
            while i <= b:te_{s:te_file_cnt}_ttype_cnt
                let ttype = b:te_{s:te_file_cnt}_{i}_name
                let j = 1
                " Remove all the tags of this type
                while j <= b:te_{s:te_file_cnt}_{ttype}_cnt
                    unlet! b:te_{s:te_file_cnt}_{ttype}_{j}_tag
                    let j = j + 1
                endwhile

                unlet! b:te_{s:te_file_cnt}_{ttype}_tagnames
                unlet! b:te_{s:te_file_cnt}_{ttype}_cnt
                unlet! b:te_{s:te_file_cnt}_{i}_name
                unlet! b:te_{s:te_file_cnt}_{i}_start
                unlet! b:te_{s:te_file_cnt}_{i}_end
                let i = i + 1
            endwhile
            unlet! b:te_{s:te_file_cnt}_ttype_cnt
        endif
        let s:te_file_cnt = s:te_file_cnt - 1
    endwhile
endfunction

" TE_OpenWindow()
" Create a new tag explorer window. If the window is already present, jump to
" the window
function! s:TE_OpenWindow()
    " Tag explorer window name
    let bname = '__Tag_Explorer__'

    " If the window is already present, jump to the window
    let winnum = bufwinnr(bname)
    if winnum != -1
        " Jump to the existing window
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
        return
    endif

    " Create a new window. If user prefers a horizontal window, then open
    " a horizontally split window. Otherwise open a vertically split
    " window
    if g:TE_Use_Horiz_Window == 1
        " If a single window is used for all files, then open the tag
        " explorer window at the very bottom
        let win_dir = 'botright'
        " Default horizontal window height is 10
        let win_width = 10
    else
        " Increase the window size, if needed, to accomodate the new
        " window
        if g:TE_Adjust_Winwidth == 1 && &columns < (80 + g:TE_WinWidth)
            " one extra column is needed to include the vertical split
            let &columns= &columns + (g:TE_WinWidth + 1)
            let s:te_winsize_chgd = 1
        else
            let s:te_winsize_chgd = 0
        endif

        " Open the window at the leftmost place
        if g:TE_Use_Right_Window == 1
            let win_dir = 'botright vertical'
        else
            let win_dir = 'topleft vertical'
        endif
        let win_width = g:TE_WinWidth
    endif

    " If the tag explorer temporary buffer already exists, then reuse it.
    " Otherwise create a new buffer
    let bufnum = bufnr(bname)
    if bufnum == -1
        " Create a new buffer
        let wcmd = bname
    else
        " Edit the existing buffer
        let wcmd = '+buffer' . bufnum
    endif

    " Create the tag explorer window
    exe 'silent! ' . win_dir . ' ' . win_width . 'split ' . wcmd

    " Mark the buffer as a scratch buffer
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nowrap
    setlocal nobuflisted
    setlocal nonumber

    " Create buffer local mappings for the tag explorer window
    nnoremap <buffer> <silent> <CR> :call <SID>TE_ProcessSelection(0)<CR>
    nnoremap <buffer> <silent> <2-LeftMouse> 
                                  \ :call <SID>TE_ProcessSelection(0)<CR>
    nnoremap <buffer> <silent> O :call <SID>TE_ProcessSelection(1)<CR>
    nnoremap <buffer> <silent> o :call <SID>TE_ListTags()<CR>
    nnoremap <buffer> <silent> c :silent! foldclose!<CR>
    nnoremap <buffer> <silent> + :silent! foldopen<CR>
    nnoremap <buffer> <silent> - :silent! foldclose<CR>
    nnoremap <buffer> <silent> <kPlus> :silent! foldopen<CR>
    nnoremap <buffer> <silent> <kMinus> :silent! foldclose<CR>
    nnoremap <buffer> <silent> u :call <SID>TE_UpdateTags()<CR>
    nnoremap <buffer> <silent> g :call <SID>TE_ChangeDir()<CR>
    nnoremap <buffer> <silent> s :call <SID>TE_SortTags()<CR>
    nnoremap <buffer> <silent> <Space> :call <SID>TE_ShowPrototype()<CR>
    nnoremap <buffer> <silent> ? :call <SID>TE_ShowHelp()<CR>
    nnoremap <buffer> <silent> q :close<CR>

    " Highlight the comments, directories, tag types and tag names
    if has('syntax')
        syntax match TagExplorerComment '^" .*'
        highlight clear TagExplorerComment
        highlight link TagExplorerComment SpecialComment

        syntax match TagExplorerDirectory '^[^"].*/'
        highlight clear TagExplorerDirectory
        highlight link TagExplorerDirectory Directory

        syntax match TagExplorerTagType '^  \S*$'
        highlight clear TagExplorerTagType
        highlight link TagExplorerTagType Type

        highlight clear TagExplorerTagName
        highlight link TagExplorerTagName Search
    endif

    " Folding related settings
    if has('folding')
        setlocal foldenable
        setlocal foldmethod=manual
        setlocal foldcolumn=3
        setlocal foldtext=TE_FoldText()
    endif

    " Define the autocommands
    augroup TagExplorerAutoCmds
        autocmd!
        " Adjust the Vim window width when the tag explorer window is closed
        autocmd BufUnload __Tag_Explorer__ call <SID>TE_CloseWindow()
    augroup end
endfunction

" TE_InitWindow
" Initialize the tag explorer window. Assumes the focus is already on
" the tagexplorer window
function! s:TE_InitWindow()
    " Clean up all the old variables used for the last directory
    call s:TE_DeleteStateInfo()

    " Remove the displayed text in the window

    " Mark the buffer as modifiable
    setlocal modifiable

    " Set report option to a huge value to prevent informational messages
    " about the deleted lines
    let old_report = &report
    set report=99999

    " Delete the contents of the buffer to the black-hole register
    silent! %delete _

    " Restore the report option
    let &report = old_report

    " Add comments at the top of the window
    call append(0, '" Press ? for help')
    call append(1, '" =' . getcwd())
    call append(2, '" Tags sorted by ' . g:TE_Sort_Type)

    " Mark the buffer as not modifiable
    setlocal nomodifiable
endfunction

" TE_CloseWindow()
" Close the tag explorer window and adjust the Vim window width
function! s:TE_CloseWindow()
    " Remove the autocommands for the tag explorer window
    silent! autocmd! TagExplorerAutoCmds

    " Reduce the Vim window width, if needed
    if g:TE_Use_Horiz_Window || g:TE_Adjust_Winwidth == 0 ||
                \ s:te_winsize_chgd == 0 ||
                \ &columns < (80 + g:TE_WinWidth)
        " No need to adjust window width if horizontally split tag explorer
        " window or if columns is less than 101 or if the user chose not to
        " adjust the window width
    else
        " Adjust the Vim window width
        let &columns= &columns - (g:TE_WinWidth + 1)
    endif
endfunction

" TE_FoldText()
" Fold expression for the various folds
function! TE_FoldText()
    let line = getline(v:foldstart)

    let eighty_spaces = '                    '
    let eighty_spaces = eighty_spaces . '                    '
    let eighty_spaces = eighty_spaces . '                    '
    let eighty_spaces = eighty_spaces . '                    '

    let pat = '\s\{' . strlen(line) . '}'
    let sub = substitute(eighty_spaces, pat, line, '')
    return v:folddashes . sub
endfunction

" TE_ShowHelp()
" Display the tag explorer help
function! s:TE_ShowHelp()
    echo 'Tag Explorer keyboard shortcuts'
    echo '-------------------------------'
    echo 'o       : List the tags defined in a file'
    echo 'c       : Close the tag listing for a file'
    echo 'u       : Update the tags listed for a file'
    echo '<Enter> : Jump to the tag definition'
    echo 'O       : Jump to the tag definition in a new window'
    echo '<Space> : Display the tag prototype'
    echo '+       : Open a fold'
    echo '-       : Close a fold'
    echo 's       : Sort the tags by order/name'
    echo 'g       : Goto a directory'
    echo 'q       : Close the tag explorer window'
endfunction

" TE_ListDir()
" List the filenames in the specified directory
function! s:TE_ListDir(dirname)
    exe "lchdir " . a:dirname

    " Store the full path to the current directory
    let s:current_dirname = getcwd()

    " Get a list of all the files in the current directory
    " In the glob() output the last line doesn't end with a \n
    " So add a explicit \n at the end
    let globout = glob("*") . "\n"

    " Add the dot files
    " Remove the link to the current directory '.'
    let globout = globout . substitute(glob(".*"), "\.\n", '', '') . "\n"

    let dir_cnt = 0
    let file_cnt = 0

    " Process all the files in the directory list
    while globout != ''
        " Process one file at a time
        let one_fname = strpart(globout, 0, stridx(globout, "\n"))

        " Remove the extracted file name
        let globout = strpart(globout, stridx(globout, "\n") + 1)

        if one_fname == ''
            continue
        endif

        " For directory names add a / at the end
        if isdirectory(one_fname)
            " If the directory name matches the pattern in the exclude list
            " then skip the directory
            if g:TE_Exclude_Dir_Pattern != ''
                if one_fname =~? g:TE_Exclude_Dir_Pattern
                    continue
                endif
            endif
            " If the directory name does not match the pattern in the include
            " list then skip the directory
            if g:TE_Include_Dir_Pattern != ''
                if one_fname !~? g:TE_Include_Dir_Pattern
                    continue
                endif
            endif
            let dir_cnt = dir_cnt + 1
            let dir_{dir_cnt} = one_fname . "/"
        else
            " If the filename matches the pattern in the exclude list
            " then skip the file
            if g:TE_Exclude_File_Pattern != ''
                if one_fname =~? g:TE_Exclude_File_Pattern
                    continue
                endif
            endif
            " If the filename does not match the pattern in the include list
            " then skip the file
            if g:TE_Include_File_Pattern != ''
                if one_fname !~? g:TE_Include_File_Pattern
                    continue
                endif
            endif
            let file_cnt = file_cnt + 1
            let file_{file_cnt} = one_fname
        endif
    endwhile

    " Sort the directory names (insertion sort)
    let i = 2
    while i <= dir_cnt
        let key = dir_{i}

        let j = i - 1

        while j > 0 && dir_{j} >? key
            let dir_{j + 1} = dir_{j}
            let j = j - 1
        endwhile

        let dir_{j + 1} =  key

        let i = i + 1
    endwhile

    " Sort the file names (insertion sort)
    let i = 2
    while i <= file_cnt
        let key = file_{i}

        let j = i - 1

        while j > 0 && file_{j} >? key
            let file_{j + 1} = file_{j}
            let j = j - 1
        endwhile

        let file_{j + 1} = key

        let i = i + 1
    endwhile

    " Line number in the buffer for the file names
    let linenr = s:comments + 1

    let list_txt = ""

    " Process the directory names
    " Get the starting and ending line numbers for the directory names
    let i = 1
    while i <= dir_cnt
        let list_txt = list_txt . dir_{i} . "\n"

        let s:te_file_cnt = s:te_file_cnt + 1

        let b:te_{s:te_file_cnt}_name = dir_{i}
        let b:te_{s:te_file_cnt}_start = linenr
        let b:te_{s:te_file_cnt}_end = linenr
        let linenr = linenr + 1

        let i = i + 1
    endwhile

    " Process the file names
    " Get the starting and ending line numbers for the file names
    let i = 1
    while i <= file_cnt
        let list_txt = list_txt . file_{i} . "\n"

        let s:te_file_cnt = s:te_file_cnt + 1

        let b:te_{s:te_file_cnt}_name = file_{i}
        let b:te_{s:te_file_cnt}_start = linenr
        let b:te_{s:te_file_cnt}_end = linenr
        let linenr = linenr + 1

        let i = i + 1
    endwhile

    " Clear the previously highlighted name. The line numbers will change
    " after the new directory listing is added. So the wrong name will be
    " highlighted.
    match none

    " Copy the directory list to the buffer
    setlocal modifiable

    " Set report option to a huge value to prevent informations messages
    " while deleting the lines
    let old_report = &report
    set report=99999

    exe 'silent! ' . s:comments . 'put =list_txt'

    " Restore the report option
    let &report = old_report
    setlocal nomodifiable

    " Place the cursor at the first directory name after the header
    exe s:comments + 1

    normal z.
endfunction

" TE_ListTags()
" List the tags defined in a file
function! s:TE_ListTags()
    let filename = getline(".")

    " Skip directories
    if filename =~ '.*/'
        return
    endif

    " Get the file index
    let idx = s:TE_GetFileIndex(line('.'))
    if idx == 0
        return
    endif

    " Is this file already processed?
    let var = "b:te_" . idx . "_ttype_cnt"

    if exists(var)
        if b:te_{idx}_ttype_cnt != 0
            " Open the folded tag listing
            if has('folding')
                let fold_start = b:te_{idx}_start
                let fold_end = b:te_{idx}_end
                exe 'silent! ' . fold_start . ',' . fold_end . 'foldopen!'
            endif
        else
            let msg = 'No tags found for ' . filename
            echohl WarningMsg | echomsg msg | echohl None
        endif

        " No need to do further processing
        return
    endif

    " Exuberant ctags arguments to generate a tag list
    let ctags_args = ' -f - --format=2 --excmd=pattern --fields=nKs '

    " Sort order for the tags
    if g:TE_Sort_Type == 'name'
        let ctags_args = ctags_args . ' --sort=yes '
    else
        let ctags_args = ctags_args . ' --sort=no '
    endif

    " Ctags command to produce output with regexp for locating the tags
    let ctags_cmd = g:TE_Ctags_Path . ctags_args
    let ctags_cmd = ctags_cmd . ' "' . filename . '"'

    " Get the ctags output
    let cmd_output = system(ctags_cmd)

    " Ctags error
    if v:shell_error && cmd_output != ''
        echohl WarningMsg | echomsg cmd_output | echohl None
        return
    endif

    " No tags for current file
    if cmd_output == ''
        let msg = 'No tags found for ' . filename
        echohl WarningMsg | echomsg msg | echohl None
        return
    endif

    " Process the ctags output
    let b:te_{idx}_ttype_cnt = 0

    while cmd_output != ''
        " Extract one line from the ctags output
        let one_line = strpart(cmd_output, 0, stridx(cmd_output, "\n"))

        let cmd_output = strpart(cmd_output, 
                                \ stridx(cmd_output, "\n") + 1)
        if one_line == ''
            continue
        endif

        " Extract the tag type
        let start = strridx(one_line, '/;"' . "\t") + strlen('/;"' . "\t")
        let end = strridx(one_line, 'line:') - 1
        let ttype = strpart(one_line, start, end - start)

        if ttype == ''
            continue
        endif

        " Replace all space characters in the tag type with underscore (_)
        let ttype = substitute(ttype, ' ', '_', 'g')

        " Extract the tag name
        let tname = strpart(one_line, 0, stridx(one_line, "\t"))
        if tname == ''
            continue
        endif

        " Add the tag scope, if it is available. Tag scope is the last
        " field after the 'line:<num>\t' field
        let start = strridx(one_line, 'line:')
        let end = strridx(one_line, "\t")
        if end > start
            let tscope = strpart(one_line, end + 1)
            let tscope = strpart(tscope, stridx(tscope, ':') + 1)
            if tscope != ''
                let tname = tname . ' [' . tscope . ']'
            endif
        endif

        " Store the tagname in the proper tag type list
        let var = 'b:te_' . idx . '_' . ttype . '_cnt'
        if exists(var)
            let tval = b:te_{idx}_{ttype}_cnt + 1
        else
            " Create a new tag type list
            let tval = 1
            let val = b:te_{idx}_ttype_cnt + 1
            let b:te_{idx}_{val}_name = ttype
            let b:te_{idx}_ttype_cnt  = val
            let b:te_{idx}_{ttype}_tagnames = ''
        endif

        let b:te_{idx}_{ttype}_tagnames =
                  \ b:te_{idx}_{ttype}_tagnames . '    ' . tname . "\n"

        let b:te_{idx}_{ttype}_{tval}_tag = one_line

        let b:te_{idx}_{ttype}_cnt = tval
    endwhile

    " No tags defined for this file
    if b:te_{idx}_ttype_cnt == 0
        return
    endif

    let tag_cnt = 0
    let start = 1
    let txt = ''

    " Compute the starting and ending line numbers for the tags
    let i = 1
    while i <= b:te_{idx}_ttype_cnt
        let ttype = b:te_{idx}_{i}_name
        let b:te_{idx}_{i}_start = start
        let b:te_{idx}_{i}_end = start + b:te_{idx}_{ttype}_cnt
        let start = b:te_{idx}_{i}_end + 1
        let txt = txt . '  ' . ttype . "\n"
        let txt = txt . b:te_{idx}_{ttype}_tagnames
        let tag_cnt = tag_cnt + b:te_{idx}_{ttype}_cnt + 1

        let i = i + 1
    endwhile

    " Adjust the end line number for the current file
    let b:te_{idx}_end = b:te_{idx}_end + tag_cnt

    " Clear the previously highlighted name. The line numbers will change
    " after the new directory listing is added. So the wrong name will be
    " highlighted.
    match none

    setlocal modifiable

    " Set report option to a huge value to prevent informations messages
    " while deleting the lines
    let old_report = &report
    set report=99999

    silent! put =txt

    " Restore the report option
    let &report = old_report

    setlocal nomodifiable

    if has('folding')
        " Create and open the fold for the file
        let fold_start = b:te_{idx}_start
        let fold_end = b:te_{idx}_end
        exe fold_start . ',' . fold_end . 'fold'
        exe fold_start . ',' . fold_end . 'foldopen!'

        " Create and open folds for the tags and tag types
        let i = 1
        let fstart = b:te_{idx}_start
        while i <= b:te_{idx}_ttype_cnt
            let fold_start = fstart + b:te_{idx}_{i}_start
            let fold_end = fstart + b:te_{idx}_{i}_end
            exe fold_start . ',' . fold_end . 'fold'
            exe fold_start . ',' . fold_end . 'foldopen!'
            let i = i + 1
        endwhile
    endif

    " Update the start and end line numbers for all the files listed below
    " this file. They are changed now as the tag list for the new file is
    " added.
    let i = idx + 1
    while i <= s:te_file_cnt
        let b:te_{i}_start = b:te_{i}_start + tag_cnt
        let b:te_{i}_end = b:te_{i}_end + tag_cnt
        let i = i + 1
    endwhile
endfunction

" TE_ToggleWindow()
" Open/Close the tag explorer window
function! s:TE_ToggleWindow()
    " Tag explorer buffer name
    let bname = '__Tag_Explorer__'

    " If tag explorer window is open then close it.
    let winnum = bufwinnr(bname)
    if winnum != -1
        if winnr() == winnum
            " Already in the tag explorer window. Close it and return
            close
        else
            " Goto the tag explorer window, close it and then come back to the
            " original window
            let curbufnr = bufnr('%')
            exe winnum . 'wincmd w'
            close
            " Need to jump back to the original window only if we are not
            " already in that window
            let winnum = bufwinnr(curbufnr)
            if winnr() != winnum
                exe winnum . 'wincmd w'
            endif
        endif
        return
    endif

    " Mark the current window as the file window
    let w:te_file_window = "yes"

    " Open the tag explorer window
    call s:TE_OpenWindow()

    " Initialize the window
    call s:TE_InitWindow()

    " List the files in the current directory
    call s:TE_ListDir(".")
endfunction

" TE_GetFileIndex()
" Get the file index based on the specified line number
function! s:TE_GetFileIndex(linenr)
    " If the line number is less than the first entry, then return
    if a:linenr < b:te_1_start
        return 0
    endif

    " Do a binary search to get the file index
    let left = 1
    let right = s:te_file_cnt

    while left < right
        let middle = (right + left + 1) / 2

        if a:linenr >= b:te_{middle}_start && 
                                          \ a:linenr <= b:te_{middle}_end
            return middle
        endif

        if a:linenr < b:te_{middle}_start
            let right = middle - 1
        else
            let left = middle
        endif
    endwhile

    return 0
endfunction

" TE_GetTtypeIndex()
" Get the tag type index based on the specified line number
function! s:TE_GetTtypeIndex(idx, linenr)
    let i = 1

    " Do a linear search
    while i <= b:te_{a:idx}_ttype_cnt
        if a:linenr <= b:te_{a:idx}_start + b:te_{a:idx}_{i}_end
            return i
        endif
        let i = i + 1
    endwhile

    return 0
endfunction

" TE_OpenDir()
" List the contents of the specified directory
function! s:TE_OpenDir(newdir)
    " Default is the current directory
    if s:current_dirname == ''
        let s:current_dirname = getcwd()
    endif

    " Change to the desired directory
    let dirname = s:current_dirname

    " If the selected directory name is not a link to the parent
    " directory, then form the full path to the directory
    if a:newdir != '.'
        if has("unix")
            " If the directory name already has a forward slash at the
            " end, just add the new directory name. Otherwise add a
            " forward slash and the directory name
            if dirname =~ ".*/$"
                let dirname = dirname . a:newdir
            else
                let dirname = dirname . '/' . a:newdir
            endif
        else
            " For MS-Windows systems, if the directory name already has a
            " backward slash at the end, just add the new directory name.
            " Otherwise add a backward slash and the directory name
            if dirname =~ ".*\\\\$"
                let dirname = dirname . a:newdir
            else
                let dirname = dirname . "\\" . a:newdir
            endif
        endif
    endif

    " Initialize the tagexplorer window
    call s:TE_InitWindow()

    " List the directory contents
    call s:TE_ListDir(dirname)
endfunction

" TE_ChangeDir()
" Change the directory to the user specified directory and list the contents
function! s:TE_ChangeDir()
    let newdir = input("Enter new directory: ")
    if newdir == ''
        return
    endif

    echo "\n"

    " Expand the entered path
    let newdir = expand(newdir, ":p")

    " Validate the directory
    if !isdirectory(newdir)
        let msg = "Error: " . newdir . " is not a valid directory"
        echohl WarningMsg | echomsg msg | echohl None
        return
    endif

    " Default is current directory
    if s:current_dirname == ''
        let s:current_dirname = getcwd()
    endif

    " Save the current directory in the input history, so that this
    " can be retrieved later
    call histadd("input", s:current_dirname)

    " Initialize the tag explorer window
    call s:TE_InitWindow()

    " List the contents of the new directory
    call s:TE_ListDir(newdir)

    setlocal nomodifiable
endfunction

" TE_EditFile()
" Open the specified file and jump to the specified pattern
function! s:TE_EditFile(new_window, filename, pat)
    " If the file is opened in one of the existing windows, use that window
    let fwin_num = bufwinnr(a:filename)
    if fwin_num != -1
        " Goto that window
        exe fwin_num . "wincmd w"

        " If the user asked to jump to the tag in a new window, then split the
        " existing window into two.
        if a:new_window
            split
        endif
    else
        " Locate the previously used window for opening a file
        let fwin_num = 0

        let i = 1
        while winbufnr(i) != -1
            if getwinvar(i, 'te_file_window') == "yes"
                let fwin_num = i
                break
            endif
            let i = i + 1
        endwhile

        if fwin_num != 0
            " Jump to the file window
            exe fwin_num . "wincmd w"

            " If the user asked to jump to the tag in a new window, then split
            " the existing window into two.
            if a:new_window
                split
            endif
            exe "edit " . a:filename
        else
            " Open a new window
            if g:TE_Use_Horiz_Window == 1
                exe 'leftabove new ' . a:filename
                " Go to the tag explorer window to change the window size to
                " the user configured value
                wincmd p
                exe 'resize 10'
                " Go back to the file window
                wincmd p
            else
                exe 'rightbelow vnew ' a:filename
                " Go to the tag explorer window to change the window size to
                " the user configured value
                wincmd p
                exe 'vertical resize ' . g:Tlist_WinWidth
                " Go back to the file window
                wincmd p
            endif
            let w:te_file_window = "yes"
        endif
    endif

    if a:pat != ''
        " Search for the pattern
        silent! call search(a:pat, 'w')

        " Bring the line to the middle of the window
        normal! z.
    endif
endfunction

" TE_OpenFile
" Open the selected file
function! s:TE_OpenFile(new_window, fidx)
    " Form the full pathname to the file
    let filename = s:current_dirname . '/' . b:te_{a:fidx}_name

    " Highlight the selecte filename
    match none
    exe 'match TagExplorerTagName /\%' . line('.') . 'l.*/'

    " Edit the file
    call s:TE_EditFile(a:new_window, filename, '')
endfunction

" TE_JumpToTag
" Jump to the selected tag
function! s:TE_JumpToTag(new_window, fidx)
    let tidx = s:TE_GetTtypeIndex(a:fidx, line('.'))
    if tidx == 0
        return
    endif

    let ttype = b:te_{a:fidx}_{tidx}_name
    let offset = line('.') - b:te_{a:fidx}_start - 
                            \ b:te_{a:fidx}_{tidx}_start
    if offset == 0
        return
    endif
    let mtxt = b:te_{a:fidx}_{ttype}_{offset}_tag

    let start = stridx(mtxt, '/^') + 2
    let end = strridx(mtxt, '/;"' . "\t")
    if mtxt[end - 1] == '$'
        let end = end - 1
    endif
    let tagpat = '\V\^' . strpart(mtxt, start, end - start) .
                                        \ (mtxt[end] == '$' ? '\$' : '')

    let filename = s:current_dirname . '/' . b:te_{a:fidx}_name

    " Highlight the selected tagname
    match none
    exe 'match TagExplorerTagName /\%' . line('.') . 'l\s\+\zs.*/'

    call s:TE_EditFile(a:new_window, filename, tagpat)
endfunction

" TE_ProcessSelection
" Process a selected entry (directory, file, or tag)
function! s:TE_ProcessSelection(new_window)
    let ltxt = getline(".")

    " Skip comment lines
    if ltxt[0] == '"'
        return
    endif

    " If inside a fold, then don't try to open the file
    if foldclosed('.') != -1
        return
    endif

    " If a directory name is selected, list the directory contents
    if ltxt =~ '.*/'
        " Remove the forward slash at the end
        let newdir = strpart(ltxt, 0, strlen(ltxt) - 1)

        call s:TE_OpenDir(newdir)
    else
        let fidx = s:TE_GetFileIndex(line('.'))
        if fidx == 0
            return
        endif

        if ltxt =~ '\s'
            " If a tag is selected jump to the tag
            call s:TE_JumpToTag(a:new_window, fidx)
        else
            " Jump to the selected file
            call s:TE_OpenFile(a:new_window, fidx)

        endif
    endif
endfunction

" TE_RemoveTags()
" Remove the tags listed for the specified file.
function! s:TE_RemoveTags(fidx)
    " Remove the currently listed tags for the selected file.  This will
    " affect the stored starting/ending line numbers for all the files listed
    " below this file. Update all of them.  Change the sort type and recreate
    " the tag listing for the selected file

    " Get the starting and ending line numbers for the file
    let start = b:te_{a:fidx}_start + 1
    let end = b:te_{a:fidx}_end

    " Goto the filename
    exe "normal " . b:te_{a:fidx}_start . "G"

    " Mark the buffer as modifiable
    setlocal modifiable

    " Set report option to a huge value to prevent informations messages
    " while deleting the lines
    let old_report = &report
    set report=99999

    " Remove all the folds created for the file
    normal! zD

    " Remove the tag lines displayed for the file
    exe start . "," . end . "delete"

    " Restore the report option
    let &report = old_report
    setlocal nomodifiable

    " Go back to the filename
    exe "normal " . b:te_{a:fidx}_start . "G"

    " Adjust the end line number for the current file
    let cnt = b:te_{a:fidx}_end - b:te_{a:fidx}_start
    let b:te_{a:fidx}_end = b:te_{a:fidx}_start

    " Delete all the variables associated with this file
    let i = 1
    while i <= b:te_{a:fidx}_ttype_cnt
        let ttype = b:te_{a:fidx}_{i}_name
        let j = 1
        while j <= b:te_{a:fidx}_{ttype}_cnt
            unlet! b:te_{a:fidx}_{ttype}_{j}_tag
            let j = j + 1
        endwhile

        unlet! b:te_{a:fidx}_{ttype}_tagnames
        unlet! b:te_{a:fidx}_{ttype}_cnt
        unlet! b:te_{a:fidx}_{i}_name
        unlet! b:te_{a:fidx}_{i}_start
        unlet! b:te_{a:fidx}_{i}_end
        let i = i + 1
    endwhile
    unlet! b:te_{a:fidx}_ttype_cnt

    " Update the start and end line numbers for all the files listed below
    " this file
    let i = a:fidx + 1
    while i <= s:te_file_cnt
        let b:te_{i}_start = b:te_{i}_start - cnt
        let b:te_{i}_end = b:te_{i}_end - cnt
        let i = i + 1
    endwhile
endfunction

" TE_SortTags()
" Change the sort order for a file
function! s:TE_SortTags()
    let ltxt = getline(".")

    " Skip comment lines
    if ltxt[0] == '"'
        return
    endif

    " Get the file index
    let fidx = s:TE_GetFileIndex(line('.'))
    if fidx == 0
        return
    endif

    " Remove all the tags listed for this file. Also update all the
    " state information
    call s:TE_RemoveTags(fidx)

    " Toggle the sort order type
    if g:TE_Sort_Type == 'name'
        let g:TE_Sort_Type = 'order'
    else
        let g:TE_Sort_Type = 'name'
    endif

    " Mark the buffer as modifiable
    setlocal modifiable
    " Update the help with the new sort type
    call setline(3, '" Tags sorted by ' . g:TE_Sort_Type)
    setlocal nomodifiable

    " Display the tags defined in the file
    call s:TE_ListTags()
endfunction

" TE_UpdateTags
" Update/refresh the tags listed for a file
function! s:TE_UpdateTags()
    let ltxt = getline(".")

    " Skip comment lines
    if ltxt[0] == '"'
        return
    endif

    " Get the file index
    let fidx = s:TE_GetFileIndex(line('.'))
    if fidx == 0
        return
    endif

    " Remove all the tags listed for this file. Also update all the
    " state information
    call s:TE_RemoveTags(fidx)

    " Display the tags defined in the file
    call s:TE_ListTags()
endfunction

" TE_ShowPrototype()
" Display the prototype for a tag
function! s:TE_ShowPrototype()
    let ltxt = getline(".")

    " Skip comment lines, directory names and filenames
    if ltxt[0] == '"' || ltxt =~ '.*/' || ltxt[0] != ' '
        return
    endif

    " Get the file index
    let idx = s:TE_GetFileIndex(line('.'))
    if idx == 0
        return
    endif

    " Get the tag type index
    let tidx = s:TE_GetTtypeIndex(idx, line('.'))
    if tidx == 0
        return
    endif

    " Get the tag name
    let ttype = b:te_{idx}_{tidx}_name
    let offset = line('.') - b:te_{idx}_start - 
                            \ b:te_{idx}_{tidx}_start
    if offset == 0
        return
    endif
    let mtxt = b:te_{idx}_{ttype}_{offset}_tag

    " Extract the tag pattern
    let start = stridx(mtxt, '/^') + 2
    let end = strridx(mtxt, '/;"' . "\t")
    if mtxt[end - 1] == '$'
        let end = end - 1
    endif
    let tag_pat = strpart(mtxt, start, end - start)
    let tag_pat = matchstr(tag_pat, '^\s*\zs.*')

    " Display the tag pattern
    echo tag_pat
endfunction

" Define the command to open/close the tag explorer window
command! -nargs=0 TagExplorer :call s:TE_ToggleWindow()

