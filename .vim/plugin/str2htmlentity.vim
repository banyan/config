" Convert from HTML String to HTML Entity.
"
" file created in 2008/11/07 20:52:40.
" LastUpdated :2008/11/07 21:28:01.
" author iNo
"
"

function! s:char2entity(str)
    let result = a:str
    let result = substitute(result, '&', '\\&amp;', 'g')
    let result = substitute(result, '<', '\&lt;', 'g')
    let result = substitute(result, '>', '\&gt;', 'g')
    let result = substitute(result, '"', '\&quot;', 'g')
    return result
endfunction

function! s:entity2char(str)
    let result = a:str
    let result = substitute(result, "\&lt;", "<", 'g')
    let result = substitute(result, "\&gt;", '>', 'g')
    let result = substitute(result, "\&quot;", '"', 'g')
    let result = substitute(result, "\&amp;", '\&', 'g')
    return result
endfunction

function! s:range2HtmlEntity() range
    silent execute "normal! gv:s/\\%V\&\\|<\\|>\\|\"/\\= s:char2entity(submatch(0)) /g\<CR>"
endfunction

function! s:range2HtmlString() range
    silent execute "normal! gv:s/\\%V\&amp;\\|\&lt;\\|\&gt;\\|&quot;/\\= s:entity2char(submatch(0)) /g\<CR>"
endfunction

" for range command
command! -range Str2HtmlEntity :<line1>,<line2>call s:range2HtmlEntity()
command! -range Entity2HtmlString :<line1>,<line2>call s:range2HtmlString()

" vim:fdl=0 fdm=marker:ts=4 sw=4 sts=0:
