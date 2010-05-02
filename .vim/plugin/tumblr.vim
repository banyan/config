" tumblr.vim - Tumblr
" Maintainer:   Travis Jeffery <eatsleepgolf@gmail.com>
" Time-stamp: <Mon Sep  1 15:50:46 EDT 2008 Travis Jeffery>
"
"Exit quickly when:
"- this plugin was already loaded (or disabled)
"- when 'compatible' is set
if (exists("g:loaded_tumblr") && g:loaded_tumblr) || &cp
    finish
endif

let g:loaded_tumblr = 1

"let s:cpo_save = &cpo
"set cpo&vim

" Code {{{1
command! -nargs=0 TumblrNew exec("py new_post()")
command! -nargs=0 TumblrPost exec("py post_normal()")
command! -range TumblrPostRange exec('py post_range(<f-line1>, <f-line2>)')
" }}}1

" let &cpo = s:cpo_save

python <<EOF
import vim
from urllib import urlencode, urlopen

def new_post():
    cb = vim.current.buffer
    cb[0] = "Title: "
    cb.append("-- Post follows this line --")
    vim.command("set ft=html")

def get_body():
    body = "\n".join(vim.current.buffer[2:])
    return body

def get_title():
    first_line = vim.current.buffer[0]
    title = first_line.strip("Title :")
    return title

def post_normal():
    title = get_title()
    body = get_body()
    send_post(title, body)

def send_post(title, body):
    url = "http://www.tumblr.com/api/write"
    email = vim.eval("g:tumblr_email")
    password = vim.eval("g:tumblr_password")
    data = urllib.urlencode({"email" : email, "password" : password, "title" : title, "body" : body})
    res = urllib.urlopen(url, data)

def post_range(line1, line2):
    range = vim.current.buffer.range(int(line1), int(line2))
    if len(range) < 2:
        print "Range can't be less than two lines."
    else:
        title = range[0]
        body = "\n".join(range[1:])
        send_post(title, body)

EOF

" vim:set ft=vim ts=8 sw=4 sts=4:
