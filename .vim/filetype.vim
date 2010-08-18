" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.scala        setfiletype scala
  au! BufRead,BufNewFile *.haml         setfiletype haml
  au! BufRead,BufNewFile *.scaml        setfiletype haml
augroup END

