" banyan's .vimrc file
" Kohei Hasegawa <ameutau@gmail.com>
" https://github.com/banyan/config
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE

" Using vundle.vim for easy bundling like as Ruby Bundler, Thanx!
" https://github.com/gmarik/vundle

" Vundle {{{
  set nocompatible " we're running Vim, not Vi!
  filetype off     " disable file type detection

  set rtp+=~/.vim/vundle/
  call vundle#rc()

  """ repos on vim.org {{{
    Bundle 'yanktmp.vim'
    Bundle 'mru.vim'
    Bundle 'The-NERD-Commenter'
    Bundle 'eregex.vim'
    Bundle 'Align'
    Bundle 'endwise.vim'
  """ }}}

  """ repos on github {{{
    Bundle 'h1mesuke/vim-alignta'
    Bundle 'Shougo/neocomplcache'
    Bundle 'thinca/vim-visualstar'
    Bundle 'vim-es6'
    Bundle 'tsaleh/vim-tmux'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'L9'
    Bundle 'ctrlpvim/ctrlp.vim'
    Bundle 'banyan/banyan.vim'
    Bundle 'banyan/recognize_charcode.vim'
    Bundle 'hallison/vim-markdown'
    Bundle 'elzr/vim-json'
    Bundle 'bling/vim-airline'
    Bundle 'dyng/ctrlsf.vim'
    Bundle 'maxbrunsfeld/vim-yankstack'
    Bundle 'cespare/vim-toml'
    Bundle 'vim-airline/vim-airline-themes'
    Bundle 'leafgarland/typescript-vim'
    Bundle "mxw/vim-jsx"
  " }}}

  syntax on
  filetype on        " enable filetype detection
  filetype indent on " enable filetype-specific indenting
  filetype plugin on " enable filetype-specific plugins
" }}}

" Envelopment {{{
  if has('win32') || has ('win64')
      let $VIMHOME = $VIM."/vimfiles"
  else
      let $VIMHOME = $HOME."/.vim"
  endif
" }}}

" Encoding {{{
  let mapleader = ' k'
  nnoremap <Leader>u  :set fileencoding=utf-8       <CR>
  nnoremap <Leader>6  :set fileencoding=ucs-2le     <CR>
  nnoremap <Leader>e  :set fileencoding=euc-jp      <CR>
  nnoremap <Leader>s  :set fileencoding=cp932       <CR>
  nnoremap <Leader>j  :set fileencoding=iso-2022-jp <CR>
  nnoremap <Leader>n  :set fileformat=unix          <CR>
  nnoremap <Leader>r  :set fileformat=mac           <CR>
  nnoremap <Leader>rn :set fileformat=dos           <CR>
  let mapleader = ' r'
  nnoremap <Leader>u  :e ++enc=utf-8       <CR>
  nnoremap <Leader>6  :e ++enc=ucs-2le     <CR>
  nnoremap <Leader>e  :e ++enc=euc-jp      <CR>
  nnoremap <Leader>s  :e ++enc=cp932       <CR>
  nnoremap <Leader>j  :e ++enc=iso-2022-jp <CR>
  nnoremap <Leader>n  :e ++fileformat=unix <CR>
  nnoremap <Leader>r  :e ++fileformat=mac  <CR>
  nnoremap <Leader>rn :e ++fileformat=dos  <CR>
" }}}

" Searching {{{
  set ignorecase " ignore case when searching
  set smartcase  " case sensitive only if capitals in search term
  set incsearch  " search incrementally instead of waiting for me to hit Enter
  set hlsearch   " search highlighting

  " clearing highlighted search, like as clear(1)
  nnoremap <Space>l :noh<C-L><CR>

  " search terms toward the middle of the screen
  nmap n nzz
  nmap N Nzz
  nmap * *zz
  nmap # #zz
  nmap g* g*zz
  nmap g# g#zz

  " escape automatically / ?
  cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
  cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'
" }}}

" Formatting {{{
  " by default, all indent/tab stuff is 4 spaces, as God intended.
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4

  " use bash-like tab completion in Vim command line
  set wildmenu
  set wildmode=longest,list

  set hidden                   " other files can be opened in the editing buffer
  set autoread                 " once the file is changed automatically reread editing in external editor
  set expandtab                " use spaces for tabs
  set autoindent               " automatically indent based on current filetype
  set backspace=2              " allow backspacing over everything in insert mode
  set showmatch                " cursor shows matching ) and }
  set smartindent              " when you start a new line to the same location as the new current line's indentation.
  set ambiwidth=double         " tells Vim to display correctly with characters with East Asian Width Class Ambiguous
  set virtualedit+=block       " enable to move the cursor to the place without character
  set formatoptions+=tcroqnlM1 " Vim list of options to determine how to format text.

  " enables to rename a file being edited
  command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

  " move cursor to the end of last line
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" }}}

" Appearance {{{
  set number       " show line numbers
  set ruler        " show the cursor position all the time
  set nolist       " don't display tabs or line breaks
  set nowrap       " no wrap long line
  set cmdheight=1  " number of screen lines to use for the command-line
  set showcmd      " Show (partial) command in the last line of the screen
  set showmatch    " Breifly show matching brace/parenthese/bracket
  set scrolljump=5 " Minimal number of lines to scroll when the cursor gets off the screen
  set scrolloff=3  " scroll before the border
  set laststatus=2 " Set the window to display a status line
  set t_Co=256     " 256 colors!
  set visualbell   " no beep

  " set terminal title
  set title
  set titlestring=Vim:\ %f\ %h%r%m

  " Indent
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType jade       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType slim       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType handlebars setlocal sw=2 sts=2 ts=2 et
  autocmd FileType hbs        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=2 sts=2 ts=2 noet
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

  set nobackup   " do not keep backup files
  set noswapfile " do not write annoying intermediate swap files,
  set nowritebackup

  " Cease to automatically insert a comment into a new line http://vimwiki.net/?faq/9
  autocmd FileType * set formatoptions-=ro"

  " toggle lines show or not
  nnoremap <Space>n
        \  :<C-u>setlocal nu!
        \ \|     setlocal nonu?<CR>
" }}}

" Color {{{
  colorscheme banyan

  highlight Pmenu       ctermfg=195 ctermbg=236
  highlight PmenuSel    ctermfg=233 ctermbg=154
  highlight PmenuSbar   ctermbg=15

  highlight TabLine     term=reverse cterm=reverse ctermfg=162 ctermbg=253
  highlight TabLineSel  term=bold    cterm=bold ctermfg=15 ctermbg=38
  highlight TabLineFill term=reverse cterm=reverse ctermfg=162 ctermbg=162

  " Highlight the line containing the cursor
  " http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
  nnoremap <silent> ,ha :HighlightCurrentLine Search<cr>
  nnoremap <silent> ,hb :HighlightCurrentLine DiffAdd<cr>
  nnoremap <silent> ,hc :HighlightCurrentLine Error<cr>

  command! -nargs=1 HighlightCurrentLine execute 'match <args> /<bslash>%'.line('.').'l/'
  nnoremap <silent> ,H :UnHighlightCurrentLine<cr>
  command! -nargs=0 UnHighlightCurrentLine match

  " distinguish half-width http://d.hatena.ne.jp/kasahi/20070902/1188744907
  highlight WhitespaceEOL ctermfg=3 ctermbg=3 guibg=darkgray
  match WhitespaceEOL /\s\+$/
  autocmd WinEnter * match WhitespaceEOL /\s\+$/

  " distinguish full-width
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=3 guibg=DarkGreen
  autocmd VimEnter,WinEnter * match
" }}}

" Aliases {{{
  nmap <Space>w :w<CR>
  nmap <Space>a :qa!<CR>
  nmap <Space>c :q<CR>

  nmap 0 ^
  nmap 9 $

  " yank
  nnoremap Y  y$<CR>
  nnoremap y1 y^<CR>
  nnoremap y0 y$<CR>

  " Move the line by line display
  nmap j gj
  nmap k gk
  vmap j gj
  vmap k gk
" }}}

" Misc {{{
  " screen display file names
  if $TERM == 'screen'
    autocmd BufEnter * silent! exe '!echo -n "k%\\"'
  endif

  function! InsertTabWrapper()
      if pumvisible()
          return "\<c-n>"
      endif
      let col = col('.') - 1
      if !col || getline('.')[col -1] !~ '\k\|<\|/'
          return "\<tab>"
      elseif exists('&omnifunc') && &omnifunc == ''
          return "\<c-n>"
      else
          return "\<c-x>\<c-o>"
      endif
  endfunction
  inoremap <tab> <c-r>=InsertTabWrapper()<cr>

  " 挿入モード時のC-uはundoできないので間違えたときに怖い。
  "http://ujihisa.nowa.jp/entry/26372573d5
  inoremap <C-u> <C-g>u<C-u>

  " toggle paste
  nnoremap <Space>p
        \  :<C-u>setlocal paste!
        \ \|     setlocal nopaste?<CR>

  " when leave Insert mode, set nopaste
  autocmd InsertLeave * set nopaste

  " .swp
  set directory^=~/.tmp//

  " complement XML
  augroup MyXML
    autocmd!
    autocmd Filetype xml   inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype html  inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  augroup END

  " preserve folding
  set foldmethod=marker

  " help <C-h>

  " Create a file directory without having to make a directory exists
  function! s:newFileOpen(file)
      let dir = fnamemodify(a:file, ':h')
      if !isdirectory(dir)
          call mkdir(dir, 'p')
      endif
      execute 'edit ' . a:file
  endfunction
  command! -nargs=1 -complete=file New call s:newFileOpen(<q-args>)

  " Open current file in vscode
  " command! Code silent! execute '!code ' . expand("%:p") | redraw!
  command! Code silent! execute '!code ' . "'" . expand("%:p") . "'" | redraw!
  cabbrev code Code

  " sudo
  cmap w!! w !sudo tee % >/dev/null

  " keep a persistent backup file from Vim7.3
  if v:version >= 730
      set undofile
      set undodir=~/.vim/.undo,~/tmp-vim,/tmp-vim
  endif

  " Tame the quickfix window (open/close using ,f)
  nmap <silent> ,c :QFix<CR>

  " editing, reloading .vimrc immediately
  command! EV edit   $MYVIMRC
  command! RV source $MYVIMRC

  set ttyfast " High-speed connections to the terminal

  " Remove trailing spaces when saving
  autocmd BufWritePre * :%s/\s\+$//ge

  if has('conceal')
    set conceallevel=1 concealcursor=
  endif
" }}}

" Window {{{
  nnoremap ss <C-W>s  " split horizontally
  nnoremap sv <C-W>v  " split vertically
  nnoremap sn <C-W>n  " create new window
  nnoremap sc <C-W>c  " close window
  nnoremap sq <C-W>q  " quit current window
  nnoremap sQ <C-W>q! " quit current window
  nnoremap so <C-W>o  " close all window except current window
  nnoremap sT <C-w>T  " move the current window to a new tab page
  nnoremap sR <C-w>R  " rotate windows upwards/leftwards

  " move between window using vi keys 'hjkl'
  nnoremap sh <C-W>h
  nnoremap sj <C-W>j
  nnoremap sk <C-W>k
  nnoremap sl <C-W>l

  " resize window using vi keys 'hjkl' with <SPACE>
  nnoremap s<SPACE>h <C-W>18>
  nnoremap s<SPACE>j <C-W>18+
  nnoremap s<SPACE>k <C-W>18-
  nnoremap s<SPACE>l <C-W>18<

  " move the current window to be at vi keys 'hjkl' positon
  nnoremap sH <C-w>H
  nnoremap sJ <C-w>J
  nnoremap sK <C-w>K
  nnoremap sL <C-w>L

  nnoremap <silent> s<CR> :<C-u>call <SID>maximize()<CR> " maximize
  nnoremap s. <C-W>=                                     " flat
  nnoremap s= <C-W>=                                     " flat

  " open github
  command! -nargs=* -range GitBrowseRemote !git browse-remote --rev -L<line1>,<line2> <f-args> -- %

  nnoremap <SPACE>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

  function! s:maximize()
      wincmd _ | wincmd |
  endfunction
" }}}

" Tab {{{
  set showtabline=2 " always show tab line

  let mapleader = ' t'
  nmap <S-t> :tab
  nmap <Leader>c :tabnew<Space>
  nmap <Leader>n :tabnext<CR>
  nmap <Leader>p :tabprevious<CR>
  nmap <Leader>d :tabclose<CR>
  nmap <Leader>s :tabs<CR>
  nmap <Leader>e :tabedit<CR>
  nmap <Leader>b :tab ball<CR>
" }}}

" Plugins {{{
  " NERD_commenter {{{
    let g:NERDCreateDefaultMappings = 0 " デフォルトのマッピングを無効にする
    let g:NERDSpaceDelims = 1           " 行頭に1スペースを作ってコメントアウトする
    let mapleader = ','
    map <Leader>x  <Plug>NERDCommenterToggle
    map <Leader>s  <Plug>NERDCommenterSexy
    map <Leader>m  <Plug>NERDCommenterMinimal
    map <Leader>ad <Plug>NERDCommenterAltDelims
    map <Leader>al <Plug>NERDCommenterAlignLeft
    map <Leader>ab <Plug>NERDCommenterAlignBoth
  " }}}
  " Align.vim {{{
    let mapleader = ' h'
    let g:Align_xstrlen = 3 " for Japanese Environment
    vnoremap <Leader>=  :Align =<CR>
    " vnoremap <Leader>=> :Align =><CR>
    vnoremap <Leader>,  :Align ,<CR>
    vnoremap <Leader>:  :Align :<CR>
    vnoremap <Leader>"  :Align "<CR>
    vnoremap <Leader>'  :Align '<CR>

  " }}}
  " neocomplcache.vim {{{
    let g:acp_enableAtStartup                        = 0 " Disable AutoComplPop.
    let g:neocomplcache_enable_at_startup            = 1 " Use neocomplcache.
    let g:neocomplcache_enable_smart_case            = 1 " Use smartcase.
    let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion
    let g:neocomplcache_enable_underbar_completion   = 1 " Use underbar completion.
    let g:neocomplcache_min_syntax_length            = 3 " Set minimum syntax keyword length.
    let g:neocomplcache_lock_buffer_name_pattern     = '\*ku\*'
    " let g:neocomplcache_enable_auto_select           = 1 " AutoComplPop like behavior.

    " Recommended key-mappings.
    " inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" " doesn't work o_O
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()
    " inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-l> neocomplcache#complete_common_string()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
  " }}}
  " ctrlp.vim {{{
    nmap <C-j> [ctrlp]
    let g:ctrlp_map = '<Nop>'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png
    let g:ctrlp_custom_ignore = '\v[\/](node_modules|build)$'
    let g:ctrlp_prompt_mappings = {
          \ 'AcceptSelection("e")': ['<c-t>'],
          \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
          \ }
    let g:ctrlp_prompt_mappings = {
          \ 'PrtSelectMove("j")':   ['<c-j>', '<c-n>'],
          \ 'PrtSelectMove("k")':   ['<c-k>', '<c-p>'],
          \ 'PrtHistory(-1)':       ['<down>'],
          \ 'PrtHistory(1)':        ['<up>'],
          \ }
    nmap [ctrlp]<C-p> :CtrlP<CR>
    nmap [ctrlp]<C-i> :CtrlPCurFile<CR>
    nmap [ctrlp]<C-j> :CtrlPMixed<CR>
    nmap [ctrlp]<C-m> :CtrlPMRUFiles<CR>
    nmap [ctrlp]<C-k> :CtrlPCurWD<CR>
  " }}}
  " mru.vim {{{
    "http://www.vim.org/scripts/script.php?script_id=521
    let MRU_Max_Entries=25
  " }}}
  " yanktmp.vim {{{
    map <silent> sy :call YanktmpYank()<CR>
    map <silent> sp :call YanktmpPaste_p()<CR>
    map <silent> sP :call YanktmpPaste_P()<CR>
  " }}}
  " vim-indent-guides {{{
    " https://github.com/nathanaelkane/vim-indent-guides
      nnoremap <Space>i  :<C-u>IndentGuidesToggle<Enter>
      let g:indent_guides_guide_size            = 1
      let g:indent_guides_start_level           = 2
      let g:indent_guides_auto_colors           = 0
      autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=60
      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=250
  " }}}
  " vundle.vim {{{
      cmap BI  BundleInstall
      cmap BU  BundleInstall!
      cmap BC  BundleClean
      cmap BS  BundleSearch<Space>
  "
  " vim-airline
      let g:airline_theme='solarized'
  "
  " }}}
  " ctrlsf.vim {{{
    nnoremap <C-h> :<C-u>CtrlSF<Space>
  " }}}
" }}}

" Local {{{
  if filereadable(expand('~/.vimrc.local'))
      source ~/.vimrc.local " for local .vimrc
  endif
" }}}
