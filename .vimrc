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
    Bundle 'YankRing.vim'
    Bundle 'mru.vim'
    Bundle 'quickrun.vim'
    Bundle 'Smooth-Scroll'
    Bundle 'The-NERD-Commenter'
    Bundle 'eregex.vim'
    Bundle 'Align'
    Bundle 'endwise.vim'
    Bundle 'haml.zip'
    Bundle 'JavaScript-syntax'
    Bundle 'php.vim'
    Bundle 'fakeclip'
  """ }}}

  """ repos on github {{{
    Bundle 'thinca/vim-ref'
    Bundle 'h1mesuke/vim-alignta'
    " 'Caught deadly signal ABRT' is frequently occuring by vim-rails?? o_O
    " Bundle 'tpope/vim-rails'
    Bundle 'Shougo/neocomplcache'
    Bundle 'm4i/YankRingSync'
    Bundle 'thinca/vim-visualstar'
    " Bundle 'Shougo/vimproc'
    Bundle 'bdd/vim-scala'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'tpope/vim-haml'
    Bundle 'jiangmiao/simple-javascript-indenter'
    Bundle 'tsaleh/vim-tmux'
    Bundle 'briancollins/vim-jst'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'skwp/vim-rspec'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'banyan/eruby.vim'
    " Bundle 'Shougo/unite.vim'
    " Bundle 'tsukkee/unite-help'
    " Bundle 'h1mesuke/unite-outline'
    " Bundle 'ujihisa/neco-look'
    " Bundle 'Shougo/vimfiler'
    Bundle 'L9'
    Bundle 'FuzzyFinder'
    Bundle 'scrooloose/nerdtree'
    Bundle 'motemen/git-vim'
    Bundle 'tpope/vim-fugitive'
    Bundle 'mattn/gist-vim'
    Bundle 'thinca/vim-guicolorscheme'
    Bundle 'banyan/banyan.vim'
    Bundle 'tomasr/molokai'
    Bundle 'banyan/recognize_charcode.vim'
    Bundle 'banyan/Nonopaste.vim'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'glidenote/memolist.vim'
    Bundle 'ajf/puppet-vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'hallison/vim-markdown'
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

  "set formatoptions+=mM
  "set formatoptions-=ro

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

  " set cursorline   " highlight current line
  " set updatetime=1
  " autocmd CursorHold * :match Search /^.*\%#.*$/

  " Indent
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType html       setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 noet
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

  set nobackup   " do not keep backup files
  set noswapfile " do not write annoying intermediate swap files,
  set nowritebackup

  " dependent on fakeclip if we use CUI vim
  set clipboard=unnamed

  "actionscript,mxml setting
  autocmd BufNewFile,BufRead *.as   set filetype=actionscript
  autocmd BufNewFile,BufRead *.mxml set filetype=mxml
  autocmd BufNewFile,BufRead *.erb  set filetype=eruby

  " Cease to automatically insert a comment into a new line http://vimwiki.net/?faq/9
  autocmd FileType * set formatoptions-=ro"

  " toggle lines show or not
  nnoremap <Space>n
        \  :<C-u>setlocal nu!
        \ \|     setlocal nonu?<CR>
" }}}

" Color {{{
  colorscheme banyan
  " colorscheme molokai

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
  nmap <Space>c :q<CR>

  " yank
  nnoremap Y  y$<CR>
  nnoremap y1 y^<CR>
  nnoremap y0 y$<CR>

  " Move the line by line display
  nmap j gj
  nmap k gk
  vmap j gj
  vmap k gk

  " select all like as Windows
  nmap <Space>a ggVG

  " this is a real optimization for almost all Vim commands
  " is it?
  " nnoremap pt :set paste
  " nnoremap ; :
  " nnoremap : ;
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

  " Vim で"gf"をスラッシュで始まる相対URLに対応させる
  " http://hail2u.net/blog/software/support-slash-started-relative-url-in-vim-gf.html
  autocmd FileType html :setlocal path+=;/

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
  nnoremap <C-h> :<C-u>h<Space>

  " help
  nnoremap <Space>hj :setlocal helplang=ja
  nnoremap <Space>he :setlocal helplang=en

  " Create a file directory without having to make a directory exists
  function! s:newFileOpen(file)
      let dir = fnamemodify(a:file, ':h')
      if !isdirectory(dir)
          call mkdir(dir, 'p')
      endif
      execute 'edit ' . a:file
  endfunction
  command! -nargs=1 -complete=file New call s:newFileOpen(<q-args>)

  " sudo
  cmap w!! w !sudo tee % >/dev/null

  " keep a persistent backup file from Vim7.3
  if v:version >= 730
      set undofile
      set undodir=~/.vim/.undo,~/tmp,/tmp
  endif

  " Tame the quickfix window (open/close using ,f)
  nmap <silent> ,c :QFix<CR>

  " editing, reloading .vimrc immediately
  command! EV edit   $MYVIMRC
  command! RV source $MYVIMRC

  set ttyfast " High-speed connections to the terminal

  " Remove trailing spaces when saving
  autocmd BufWritePre * :%s/\s\+$//ge

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

  " ウィンドウの幅をいい感じにする
  " function! s:good_width()
    " if winwidth(0) < 84
      " vertical resize 84
    " endif
  " endfunctio+

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
  nmap <Leader>a :tabonly<CR>
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
  " Ctags etc {{{
    " nmap <silent> <F4>
        " \ :!ctags-ex -f %:p:h/tags
        " \ --langmap="php:+.inc"
        " \ -h ".php.inc" -R --totals=yes
        " \ --tag-relative=yes --PHP-kinds=+cf-v %:p:h<CR>
    " "set tags=~/.tags,tags
    " set tags=~/.tags
    " " タグファイルを指定する
    " " set tags
    " " from id:secondlife
    " if has("autochdir")
        " set autochdir
        " set tags=tags;
    " else
        " set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
    " endif
  " }}}
  " quickrun.vim {{{
    let mapleader = ' e'
    let g:quickrun_config = {}
    let g:quickrun_config._ = {'split': 'below', 'running_mark': '（ ＾ω＾）'}
    " let g:quickrun_config._ = {'runner': 'vimproc', 'split': 'below', 'running_mark': '（ ＾ω＾）'} " vimproc is too slow
    execute 'nnoremap <silent> <leader> :QuickRun -mode n<CR>'
    execute 'vnoremap <silent> <leader> :QuickRun -mode v<CR>'

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
  " AutoComplPop {{{
    " let g:AutoComplPop_IgnoreCaseOption = 1
  " }}}
  " fuf.vim {{{
    nmap <C-j> [fuf]

    let g:fuf_modesDisable     = ['mrucmd']
    let g:fuf_file_exclude     = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
    let g:fuf_mrufile_exclude  = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
    let g:fuf_mrufile_maxItem  = 1000
    let g:fuf_enumeratingLimit = 20
    let g:fuf_keyOpen          = '<Tab>'
    let g:fuf_keyOpenTabpage   = '<CR>'
    " let g:fuf_keyPreview       = '<C-]>'
    " let g:fuf_previewHeight    = 0

    nmap [fuf]<C-b> :FufBuffer<CR>
    " nmap [fuf]<C-j> :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
    nmap [fuf]<C-k> :FufFile<CR>
    nmap [fuf]<C-i> :FufFileWithCurrentBufferDir<CR>
    nmap [fuf]<C-j> :FufFile **/<CR>
    nmap [fuf]<C-m> :FufMruFile<CR>
    nmap [fuf]<C-q> :FufQuickfix<CR>
    nmap [fuf]<C-l> :FufLine<CR>
    nnoremap <silent> <C-]> :FufTag! <C-r>=expand('<cword>')<CR><CR>
  " }}}
  " mru.vim {{{
    "http://www.vim.org/scripts/script.php?script_id=521
    let MRU_Max_Entries=25
  " }}}
  " yankring.vim {{{
    if has('viminfo')
        set vi^=!
    endif
  " }}}
  " yanktmp.vim {{{
    map <silent> sy :call YanktmpYank()<CR>
    map <silent> sp :call YanktmpPaste_p()<CR>
    map <silent> sP :call YanktmpPaste_P()<CR>
  " }}}
  " str2htmlentity.vim {{{
    vmap <silent> sx :Str2HtmlEntity<cr>
    vmap <silent> sr :Entity2HtmlString<cr>
  " }}}
  " ref.vim {{{
    let g:ref_phpmanual_path        = $VIMHOME . '/git/config/doc/phpmanual'
    let g:ref_perldoc_complete_head = 1
    let g:ref_use_vimproc           = 0
    let g:ref_jquery_use_cache      = 1
    let g:ref_alc_use_cache         = 1
    nnoremap <silent> <Space>ra :<C-u>call ref#jump('normal', 'alc')<CR>
    vnoremap <silent> <Space>ra :<C-u>call ref#jump('visual', 'alc')<CR>
    nnoremap <silent> <Space>rp :<C-u>call ref#jump('normal', 'phpmanual')<CR>
    vnoremap <silent> <Space>rp :<C-u>call ref#jump('visual', 'phpmanual')<CR>
    nnoremap <C-f><C-f> :<C-u>Ref<Space>
    nnoremap <C-f><C-p> :<C-u>Ref perldoc<Space>
    nnoremap <C-f><C-l> :<C-u>Ref alc<Space>
    nnoremap <C-f><C-h> :<C-u>Ref phpmanual<Space>
    nnoremap <C-f><C-j> :<C-u>Ref jquery<Space>
  " }}}
  " unite.vim {{{
    " nnoremap          [unite]   <Nop>
    " nmap      <C-j>   [unite]

    " nnoremap          [unite]<C-u> :<C-u>Unite<Space>
    " nnoremap <silent> [unite]<C-j> :<C-u>Unite -buffer-name=files file<CR>
    " nnoremap <silent> [unite]<C-b> :<C-u>Unite buffer<CR>
    " nnoremap <silent> [unite]<C-m> :<C-u>Unite file_mru<CR>
    " nnoremap <silent> [unite]<C-l> :<C-u>Unite buffer file_mru<CR>
    " nnoremap <silent> [unite]<C-k> :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
    " nnoremap <silent> [unite]<C-i> :<C-u>UniteWithBufferDir buffer file_mru file<CR>
    " nnoremap <silent> [unite]<C-o> :<C-u>Unite outline<CR>
    " nnoremap <silent> [unite]<C-p> :<C-u>Unite -auto-preview outline<CR>

    " autocmd FileType unite call s:unite_my_settings()
    " function! s:unite_my_settings()" {{{
      " " Overwrite settings.
      " imap <buffer> jj      <Plug>(unite_insert_leave)
      " nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
      " imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
      " " Start insert.
      " let g:unite_enable_start_insert = 1
      " call unite#custom_default_action('file', 'tabopen')
    " endfunction" }}}

    " let g:unite_source_file_mru_limit = 200
  " }}}
  " git-vim.vim {{{
    " https://github.com/motemen/git-vim
    let g:git_no_map_default = 1
    let g:git_command_edit = 'rightbelow vnew'
    nnoremap <Space>dc  :<C-u>GitDiff --cached<Enter>
    nnoremap <Space>d   :<C-u>GitDiff<Enter>
    nnoremap <Space>gs  :<C-u>GitStatus<Enter>
    nnoremap <Space>gl  :<C-u>GitLog<Enter>
    nnoremap <Space>gL  :<C-u>GitLog -u \| head -10000<Enter>
    nnoremap <Space>ga  :<C-u>GitAdd<Enter>
    nnoremap <Space>gA  :<C-u>GitAdd <cfile><Enter>
    nnoremap <Space>gc  :<C-u>GitCommit<Enter>
    nnoremap <Space>gca :<C-u>GitCommit --amend<Enter>
    nnoremap <Space>gp  :<C-u>Git push
  " }}}
  " vim-fugitive {{{
    " https://github.com/tpope/vim-fugitive
    nnoremap <Space>gd  :<C-u>GitDiff<CR>
  " }}}
  " ack.vim {{{
    " https://github.com/mileszs/ack.vim
      nnoremap ,f :Ack -i<Space>
      nnoremap ,d :AckFromSearch -i<Space>
      " nnoremap ,s :AckFile -i<Space>
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
  " }}}
  " vim-powerline {{{
      let g:Powerline_symbols='fancy'
  " }}}
  " memolist {{{
      let g:memolist_path = $HOME . "/Dropbox/my/memo"
  " }}}
  " Nonopaste {{{
      let g:nonopaste_open_browser_after_post = 1
  " }}}
" }}}

" Local {{{
  if filereadable(expand('~/.vimrc.local'))
      source ~/.vimrc.local " for local .vimrc
  endif
" }}}
