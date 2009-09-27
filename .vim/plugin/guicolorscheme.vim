" guicolorscheme.vim: Convert GUI only color schems
"
" Maintainer:    Aaron Griffin <aaron@archlinux.org>
" Modified By:   thinca <thinca@gmail.com>
" Last Modified: 2009-03-27T22:06:11+09:00
" Version:       1.2
" URL:           http://www.vim.org/script.php?script_id=1809
"
" Convert a GUI-only colorscheme to support 88 and 256 color terminals
" This should also work on the GUI, so using it 100% of the time, assuming
" you always have a non 8/16 color terminal should work fine

if exists('g:loaded_guicolorscheme') || has('gui_running')
    finish
endif
let g:loaded_guicolorscheme = 1

let s:save_cpo = &cpo
set cpo&vim


" conversion functions {{{
" canibalized from desert256.vim

function! s:greynum(x) "{{{
    if &t_Co == 88
        if a:x < 23
            return 0
        elseif a:x < 69
            return 1
        elseif a:x < 103
            return 2
        elseif a:x < 127
            return 3
        elseif a:x < 150
            return 4
        elseif a:x < 173
            return 5
        elseif a:x < 196
            return 6
        elseif a:x < 219
            return 7
        elseif a:x < 243
            return 8
        else
            return 9
        endif
    else
        if a:x < 14
            return 0
        else
            let l:n = (a:x - 8) / 10
            let l:m = (a:x - 8) % 10
            if l:m < 5
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfunction "}}}
function! s:greylvl(n) "{{{
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 46
        elseif a:n == 2
            return 92
        elseif a:n == 3
            return 115
        elseif a:n == 4
            return 139
        elseif a:n == 5
            return 162
        elseif a:n == 6
            return 185
        elseif a:n == 7
            return 208
        elseif a:n == 8
            return 231
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 8 + (a:n * 10)
        endif
    endif
endfunction "}}}
function! s:grey(n) "{{{
    if &t_Co == 88
        if a:n == 0
            return 16
        elseif a:n == 9
            return 79
        else
            return 79 + a:n
        endif
    else
        if a:n == 0
            return 16
        elseif a:n == 25
            return 231
        else
            return 231 + a:n
        endif
    endif
endfunction "}}}

function! s:rgbnum(x) "{{{
    if &t_Co == 88
        if a:x < 69
            return 0
        elseif a:x < 172
            return 1
        elseif a:x < 230
            return 2
        else
            return 3
        endif
    else
        if a:x < 75
            return 0
        else
            let l:n = (a:x - 55) / 40
            let l:m = (a:x - 55) % 40
            if l:m < 20
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfunction "}}}
function! s:rgblvl(n) "{{{
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 139
        elseif a:n == 2
            return 205
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 55 + (a:n * 40)
        endif
    endif
endfunction "}}}
function! s:rgb(r, g, b) "{{{
    if &t_Co == 88
        return 16 + (a:r * 16) + (a:g * 4) + a:b
    else
        return 16 + (a:r * 36) + (a:g * 6) + a:b
    endif
endfunction "}}}

function! s:color(r, g, b) "{{{
    " get the closest grey
    let l:gx = s:greynum(a:r)
    let l:gy = s:greynum(a:g)
    let l:gz = s:greynum(a:b)

    " get the closest color
    let l:x = s:rgbnum(a:r)
    let l:y = s:rgbnum(a:g)
    let l:z = s:rgbnum(a:b)

    let l:level = (a:r * a:r) + (a:g * a:g) + (a:b * a:b)
    if l:gx == l:gy && l:gy == l:gz
        " there are two possibilities
        let l:dgr = s:greylvl(l:gx)
        let l:dgg = s:greylvl(l:gy)
        let l:dgb = s:greylvl(l:gz)
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb) - l:level

        let l:dr = s:rgblvl(l:gx)
        let l:dg = s:rgblvl(l:gy)
        let l:db = s:rgblvl(l:gz)
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db) - l:level

        if l:dgrey < l:drgb
            " use the grey
            return s:grey(l:gx)
        else
            " use the color
            return s:rgb(l:x, l:y, l:z)
        endif
    else
        " only one possibility
        return s:rgb(l:x, l:y, l:z)
    endif
endfunction "}}}
function! s:cindex(rgb) "{{{
    "convert RRGGBB to a terminal (numeric) index
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return s:color(l:r, l:g, l:b)
endfunction "}}}

"}}}

" Completion Helpers {{{
function! s:Colorscheme_Complete(A,L,P)
    let l:files = split(globpath(&runtimepath, "colors/" . a:A . "*"), "\n")
    let l:retlist = []
    for file in l:files
        let l:basename = substitute(file, ".*/", "", "")
        let l:basename = substitute(l:basename, "\.vim", "", "")
        call add(l:retlist, l:basename)
    endfor
    return l:retlist
endfunction

function! s:GetColorschemeFile(fname)
    let l:files = split(globpath(&runtimepath, "colors/" . a:fname . ".vim"), "\n")
    if len(l:files) == 0
        echoerr "Colorscheme ".a:fname." not found"
        return ""
    else
        return l:files[0]
    endif
endfunction

command! -complete=customlist,s:Colorscheme_Complete -nargs=1 GuiColorScheme :call s:GuiColorScheme(<q-args>)
" }}}

function! s:removeLineContinuation(lines)
    let lines = a:lines
    let i = 1
    while i < len(lines)
        if lines[i] =~ '^\s*\\'
            let lines[i - 1] .= substitute(lines[i], '\s*\\', '', '')
            unlet lines[i]
        else
            let i += 1
        endif
    endwhile
    return lines
endfunction

function! s:getRuntimeSource(line)
    let rt = matchlist(a:line, '\v^\s*:?\s*ru%[ntime]>(!?)\s+(.+)$')
    let res = []
    for f in split(globpath(&rtp, rt[2]), "\n")[0:0 - strlen(rt[1])]
        let res += readfile(f)
    endfor
    return s:expandRuntime(res)
endfunction

function! s:expandRuntime(lines)
    let lines = s:removeLineContinuation(a:lines)
    let i = 0
    while i < len(lines)
        if lines[i] =~ '^\s*:\?\s*ru\%[ntime]\>'
            let s = s:getRuntimeSource(lines[i])
            let lines = lines[:i - 1] + s + lines[i + 1:]
            let i += len(s) - 1
        endif
        let i += 1
    endwhile
    return lines
endfunction

function! s:GuiColorScheme(fname)
    let l:file = s:GetColorschemeFile(a:fname)
    if l:file == ""
        return 1
    endif

    if has("gui_running")
        exec "colorscheme " . l:file
        return 0
    endif

    let lines = s:expandRuntime(readfile(file))

    let i = 0
    while i < len(lines)
        let hi = matchstr(lines[i], '^\s*:\?\s*hi\%[ghlight]\>.*')
        if hi == ''
            let i += 1
            continue
        endif

        " Split to parts.
        " 'hi Normal    guifg=#ffffff     guibg=#050505'
        " => ['hi', 'Normal', 'guifg=#ffffff', 'guibg=#050505']
        let parts = split(hi, '\v%(\S+\s*\=\s*%(''[^'']*''|\S+)|\w+)\zs\s*')

        " gui => cterm
        for type in ['bg', 'fg', '']
            let pos = match(parts, '^gui' . type . '\s*=')
            if pos < 0
                continue
            endif
            let rhs = matchstr(parts[pos], '^\w*\s*=\s*\zs.*')
            " Convert the name that there is not in cterm.
            let rhs = get(g:guicolorscheme_color_table, tolower(rhs), rhs)
            if rhs =~ '#\x\{6}'
                let rhs = s:cindex(rhs[1:])
            endif
            let pos = match(parts, '^cterm' . type . '\s*=')
            if 0 <= pos
                unlet parts[pos]
            endif
            call add(parts, 'cterm' . type . '=' . rhs)
        endfor

        let lines[i] = join(parts)
        let i += 1
    endwhile

    " execute
    let [save_z, @z] = [@z, join(lines, "\n")]
    @z
    let @z = save_z
endfunction

" read rgb.txt (may be heavy).
function! s:readRGBtxt()
    let table = {}
    let txt = globpath(&rtp, '**/rgb.txt')
    if empty(txt)
        return table
    endif
    for line in readfile(split(txt, "\n")[0])
        if line =~ '^\s*!'
            continue
        endif
        let r = split(line)
        let rgb = call('printf', ['#%02X%02X%02X'] + r[:2])
        for name in r[3:]
            let table[tolower(name)] = rgb
        endfor
    endfor
    return table
endfunction

let g:guicolorscheme_color_table = extend(s:readRGBtxt(),
  \ exists('g:guicolorscheme_color_table') ?
  \ g:guicolorscheme_color_table : {})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ft=vim:fdl=0:fdm=marker:ts=4:sw=4
