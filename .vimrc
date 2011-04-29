""" vundle
"-----------------------------------------------------------------------------
"{{{
set nocompatible " Use Vim defaults instead of 100% vi compatibility
" vundle.vim で ftdetect などを load させるために一度ファイルタイプ判定を off にする
filetype off

set rtp+=~/.vim/vundle/ 
call vundle#rc()

" vim-scripts repos
Bundle 'cucumber.zip'
Bundle 'endwise.vim'
Bundle 'haml.zip'
Bundle 'git-commit'
Bundle 'rails.vim'
Bundle 'sudo.vim'
Bundle 'yanktmp.vim'
Bundle 'YankRing.vim'
Bundle 'mru.vim'
Bundle 'quickrun.vim'
Bundle 'Smooth-Scroll'
Bundle 'JavaScript-syntax'
Bundle 'php.vim'
Bundle 'The-NERD-Commenter'
Bundle 'eregex.vim'
Bundle 'Align'

" original repos on github
Bundle 'vim-ruby/vim-ruby'
Bundle 'motemen/git-vim'
Bundle 'Shougo/neocomplcache'
Bundle 'h1mesuke/vim-alignta'
Bundle 'Shougo/unite.vim'
Bundle 'tsukkee/unite-help'
Bundle 'h1mesuke/unite-outline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'thinca/vim-guicolorscheme'
Bundle 'thinca/vim-ref'
Bundle 'bdd/vim-scala'
Bundle 'banyan/banyan.vim'
Bundle 'banyan/recognize_charcode.vim'

" filetype 判定を戻す
filetype plugin indent on
"}}}

""" encoding
"-----------------------------------------------------------------------------
"{{{
let mapleader = ' k'
nnoremap <Leader>u :set fileencoding=utf-8<CR>
nnoremap <Leader>6 :set fileencoding=ucs-2le<CR>
nnoremap <Leader>e :set fileencoding=euc-jp<CR>
nnoremap <Leader>s :set fileencoding=cp932<CR>
nnoremap <Leader>j :set fileencoding=iso-2022-jp<CR>
nnoremap <Leader>n :set fileformat=unix<CR>
nnoremap <Leader>r :set fileformat=mac<CR>
nnoremap <Leader>rn :set fileformat=dos<CR>
let mapleader = ' r'
nnoremap <Leader>u :e ++enc=utf-8<CR>
nnoremap <Leader>6 :e ++enc=ucs-2le<CR>
nnoremap <Leader>e :e ++enc=euc-jp<CR>
nnoremap <Leader>s :e ++enc=cp932<CR>
nnoremap <Leader>j :e ++enc=iso-2022-jp<CR>
nnoremap <Leader>n :e ++fileformat=unix<CR>
nnoremap <Leader>r :e ++fileformat=mac<CR>
nnoremap <Leader>rn :e ++fileformat=dos<CR>

" 文字コードの自動認識プラグインを読み込む
" http://d.hatena.ne.jp/shizu9/20090402/1238697718
" source ~/.vim/bundle/recognize_charcode/plugin/recognize_charcode.vim
"}}}

""" search
"-----------------------------------------------------------------------------
"{{{
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan
" 検索中にインクリメンタルサーチをする
set incsearch
" 検索語が画面の真ん中に来るようにする
nmap n nzz
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" 検索結果文字列のハイライトを有効にする
set hlsearch
" 検索後のハイライトをクリアする
nnoremap <Space>l :noh<C-L><CR>

" / ? を自動でエスケープする
cnoremap <expr> /  getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ?  getcmdtype() == '?' ? '\?' : '?'

"}}}

""" edit
"-----------------------------------------------------------------------------
"{{{
set tabstop=4
set expandtab
set autoindent
" バックスペースでいろいろ削除
set backspace=2
" 括弧入力時の対応する括弧を表示
set showmatch
" 勝手にインデントする
set smartindent
set wildmenu
"set formatoptions+=mM
"set formatoptions-=ro
set ambiwidth=double
set shiftwidth=4
set wildmode=longest,list
let format_allow_over_tw = 1  " ぶら下り可能幅

set virtualedit+=block " 短形選択で自由に移動する

" 編集中のファイルをリネームする
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread
" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif"}}}

""" show
"-----------------------------------------------------------------------------
"{{{
" 行番号はつける派
set nu
" ルーラー(右下に表示される行・列の番号)を表示する
set ruler
" タブや改行を表示しない
set nolist
set nowrap
set laststatus=1
set cmdheight=1
set showcmd
set title
set titlestring=Vim:\ %f\ %h%r%m
set scrolljump=5
set scrolloff=3
set t_Co=256

" カーソルライン表示 重いので止めてる
" set cul
" 現在行をhighlight
" set updatetime=1
" autocmd CursorHold * :match Search /^.*\%#.*$/

"シンタックスハイライトを有効にする
syntax on

filetype plugin indent on

 """ Indent
autocmd FileType apache       setlocal sw=4 sts=4 ts=4 et
autocmd FileType aspvbs       setlocal sw=4 sts=4 ts=4 noet
autocmd FileType c            setlocal sw=4 sts=4 ts=4 et
autocmd FileType cpp          setlocal sw=4 sts=4 ts=4 et
autocmd FileType cs           setlocal sw=4 sts=4 ts=4 et
autocmd FileType css          setlocal sw=4 sts=4 ts=4 noet
autocmd FileType diff         setlocal sw=4 sts=4 ts=4 noet
autocmd FileType eruby        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType html         setlocal sw=4 sts=4 ts=4 noet
autocmd FileType java         setlocal sw=4 sts=4 ts=4 et
autocmd FileType javascript   setlocal sw=4 sts=4 ts=4 noet
autocmd FileType perl         setlocal sw=4 sts=4 ts=4 et
autocmd FileType php          setlocal sw=4 sts=4 ts=4 et
autocmd FileType python       setlocal sw=4 sts=4 ts=4 et
autocmd FileType ruby         setlocal sw=2 sts=2 ts=2 et
autocmd FileType sh           setlocal sw=4 sts=4 ts=4 et
autocmd FileType sql          setlocal sw=4 sts=4 ts=4 et
autocmd FileType vb           setlocal sw=4 sts=4 ts=4 noet
autocmd FileType vim          setlocal sw=2 sts=2 ts=2 et
autocmd FileType wsh          setlocal sw=4 sts=4 ts=4 et
autocmd FileType xhtml        setlocal sw=4 sts=4 ts=4 noet
autocmd FileType xml          setlocal sw=4 sts=4 ts=4 noet
autocmd FileType yaml         setlocal sw=2 sts=2 ts=2 et
autocmd FileType zsh          setlocal sw=4 sts=4 ts=4 et
autocmd FileType scala        setlocal sw=2 sts=2 ts=2 et

set nobackup
set clipboard=unnamed

"actionscript,mxml setting
autocmd BufNewFile,BufRead *.as set filetype=actionscript
autocmd BufNewFile,BufRead *.mxml set filetype=mxml

" 改行後に自動的にコメントを挿入するのをやめさせる
" http://vimwiki.net/?faq/9
autocmd FileType * set formatoptions-=ro"

" 行数の非表示を toggle
nnoremap <Space>n
      \  :<C-u>setlocal nu!
      \ \|     setlocal nonu?<CR>}}}

""" colorscheme
"-----------------------------------------------------------------------------
"{{{
" https://github.com/banyan/banyan.vim
colorscheme banyan
"}}}

""" misc
"-----------------------------------------------------------------------------
"{{{
" screen にファイル名を表示
if $TERM == 'screen'
  autocmd BufEnter * silent! exe '!echo -n "k%\\"'
endif

"表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" ポップアップメニューの色
hi Pmenu     ctermbg=8
hi PmenuSel  ctermbg=4
hi PmenuSbar ctermbg=8

" http://d.hatena.ne.jp/kasahi/20070902/1188744907
" 半角を別色表示に
highlight WhitespaceEOL ctermbg=8 guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

" 全角スペースを別色表示に
autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
autocmd VimEnter,WinEnter * match

" ステイタス行に文字コードと改行コードを表示。
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" バッファの移動
map <F5> <ESC>:bp<CR>
map <F6> <ESC>:bn<CR>
map <F7> <ESC>:bw<CR>
map <F8> <ESC>:bd<CR>

"insert mode時にc-jで抜けてかつ IME off
imap <C-j> <esc>
"imap <C-j> <ESC>:set iminsert=0<CR>
"inoremap <C-j> <Esc>:set iminsert=0<CR>
"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

nmap <Space>w :w<CR>
nmap <Space>d :diffthis<CR>
nmap <Space>c :q<CR>

"function! InsertTabWrapper()
    "if pumvisible()
        "return "\<c-n>"
    "endif
    "let col = col('.') - 1
    "if !col || getline('.')[col -1] !~ '\k\|<\|/'
        "return "\<tab>"
    "elseif exists('&omnifunc') && &omnifunc == ''
        "return "\<c-n>"
    "else
        "return "\<c-x>\<c-o>"
    "endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"カーソルがある行をハイライトする
"http://peace-pipe.blogspot.com/2006/05/vimrc-vim.html
nnoremap <silent> ,ha :HighlightCurrentLine Search<cr>
nnoremap <silent> ,hb :HighlightCurrentLine DiffAdd<cr>
nnoremap <silent> ,hc :HighlightCurrentLine Error<cr>
command! -nargs=1 HighlightCurrentLine execute 'match <args> /<bslash>%'.line('.').'l/'

nnoremap <silent> ,H :UnHighlightCurrentLine<cr>
command! -nargs=0 UnHighlightCurrentLine match

"CTRL-kでクリップボードから貼り付け
imap <C-k> <ESC>"+gPa

"Ruby用入力最適化。ブロック関連のワードの後にEnterを自動挿入
autocmd FileType ruby imap <buffer> begin begin<Enter>
autocmd FileType ruby imap <buffer> end  <Esc>:call SmartEnd()<CR>a
autocmd FileType ruby imap <buffer> then then<Enter>
autocmd FileType ruby imap <buffer> ensure ensure<Enter>
autocmd FileType ruby imap <buffer> else else<Enter>
autocmd FileType ruby inoremap <buffer> ; <Esc>:call SmartSemicolon()<CR>a
"autocmd FileType ruby imap <buffer> eacho each do \|\|<Enter>end<ESC>k$h

" Vimで"gf"をスラッシュで始まる相対URLに対応させる
" http://hail2u.net/blog/software/support-slash-started-relative-url-in-vim-gf.html
autocmd FileType html :setlocal path+=;/

"挿入モード時のC-uはundoできないので間違えたときに怖い。
"http://ujihisa.nowa.jp/entry/26372573d5
inoremap <C-u> <C-g>u<C-u>

"paste を toggle
nnoremap <Space>p
      \  :<C-u>setlocal paste!
      \ \|     setlocal nopaste?<CR>

" .swp に設定
set directory^=~/.tmp//

" XMLの閉じタグを補完する
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"折りたたみを保存する
set foldmethod=marker

"スワップファイルを作らない
set noswapfile

" C-h で help を引く
nnoremap <C-h> :<C-u>h<Space>

" help を 日本語、英語
nnoremap <Space>hj :setlocal helplang=ja
nnoremap <Space>he :setlocal helplang=en

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine ctermfg=255 ctermbg=39
autocmd InsertLeave * highlight StatusLine ctermfg=37 ctermbg=15
augroup END

" ディレクトリが存在しなくてもディレクトリつくってファイル作成
function! s:newFileOpen(file)
    let dir = fnamemodify(a:file, ':h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
    execute 'edit ' . a:file
endfunction
command! -nargs=1 -complete=file New call s:newFileOpen(<q-args>)

"}}}

""" window
"-----------------------------------------------------------------------------
"{{{
"window 関係"
nnoremap ss <C-W>s
nnoremap sc <C-W>c
nnoremap so <C-W>o

nnoremap sj <C-W>j
nnoremap sk <C-W>k
nnoremap <silent> sh <C-W>h:call <SID>good_width()<CR>
nnoremap <silent> sl <C-W>l:call <SID>good_width()<Cr>
" ウィンドウの幅をいい感じにする
function! s:good_width()
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

" ウィンドウの大きさを最大化する
function! s:big()
    wincmd _ | wincmd |
endfunction
nnoremap <silent> s<CR> :<C-u>call <SID>big()<CR> " 最大化
nnoremap s0 1<C-W>_ " 最小化
nnoremap s. <C-W>=  " 全部同じ大きさにする

"}}}

""" tab
"-----------------------------------------------------------------------------
"{{{
"タブ関係"
let mapleader = ' t'
nmap <S-t> :tab
nmap <Leader>c :tabnew 
nmap <Leader>n :tabn<CR>
nmap <Leader>p :tabp<CR>
nmap <Leader>d :tabc<CR>
nmap <Leader>a :tabonly<CR>
nmap <Leader>s :tabs<CR>
nmap <Leader>e :tabe<CR>
nmap <Leader>b :tab ball<CR>

"hi TabLine     term=reverse cterm=reverse ctermfg=38 ctermbg=15
"hi TabLineSel  term=bold cterm=bold ctermfg=15 ctermbg=5
"hi TabLineFill term=reverse cterm=reverse ctermfg=250 ctermbg=250

hi TabLine     term=reverse cterm=reverse ctermfg=162 ctermbg=253
hi TabLineSel  term=bold cterm=bold ctermfg=15 ctermbg=38
hi TabLineFill term=reverse cterm=reverse ctermfg=162 ctermbg=162

set showtabline=2

"}}}

""" plugin
"-----------------------------------------------------------------------------
"{{{

 " taglist.vim
let mapleader = ' t'
nnoremap <Leader>l     : Tlist<CR>
nnoremap <Leader><C-l> : Tlist<CR>
nnoremap <Leader>o     : TlistClose<CR>
nnoremap <Leader><C-o> : TlistClose<CR>

" NERD_commenter
" http://www.vim.org/scripts/script.php?script_id=1218
let g:NERDCreateDefaultMappings = 0 " デフォルトのマッピングを無効にする
let g:NERDSpaceDelims = 1           " 行頭に1スペースを作ってコメントアウトする
let mapleader = ','
map <Leader>x  <Plug>NERDCommenterToggle
map <Leader>s  <Plug>NERDCommenterSexy
map <Leader>m  <Plug>NERDCommenterMinimal
map <Leader>ad <Plug>NERDCommenterAltDelims
map <Leader>al <Plug>NERDCommenterAlignLeft
map <Leader>ab <Plug>NERDCommenterAlignBoth

" AlignPlugin.vim
let mapleader = ' h'
vnoremap <Leader>= :Align=<CR>
vnoremap <Leader>> :Align=><CR>
vmap     <Leader>: <Space><Space>tsp

" Ctags, tablist, etc
nmap <silent> <F4>
    \ :!ctags-ex -f %:p:h/tags
    \ --langmap="php:+.inc"
    \ -h ".php.inc" -R --totals=yes
    \ --tag-relative=yes --PHP-kinds=+cf-v %:p:h<CR>
"set tags=~/.tags,tags
set tags=~/.tags

" タグファイルを指定する
" set tags
" from id:secondlife
if has("autochdir")
    set autochdir
    set tags=tags;
else
    set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif

" quickrun.vim
let mapleader = ' e'
au Filetype ruby       nnoremap <buffer><leader> :!ruby %<Space> 
au Filetype php        nnoremap <buffer><leader> :!php %<Space> 
au Filetype perl       nnoremap <buffer><leader> :!perl %<Space> 
au Filetype python     nnoremap <buffer><leader> :!python %<Space>
au Filetype sh         nnoremap <buffer><leader> :!sh %<Space>
au Filetype scala      nnoremap <buffer><leader> :!scala %<Space>
au Filetype zsh        nnoremap <buffer><leader> :!zsh %<Space>
au Filetype haskell    nnoremap <buffer><leader> :!runghc %<Space>
au Filetype scheme     nnoremap <buffer><leader> :!gosh %<Space>
au Filetype javascript nnoremap <buffer><leader> :!js %<Space>
au Filetype vim        nnoremap <silent><leader> :source %<Return

" neocomplcache.vim
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

"mru.vim
"http://www.vim.org/scripts/script.php?script_id=521
let MRU_Max_Entries=25

"バインド(<tab>)を変更したい場合
"imap <unique> <C-b> <Plug>Jumper
"smap <unique> <C-b> i<BS><C-b>
let g:snippetsEmu_key = "<C-I>"

"yankring.vim
if has('viminfo')
    set vi^=!
endif

" yanktmp.vim
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

" sudo.vim
nmap <silent> sudo :call YanktmpPaste_P()<CR>

" str2htmlentity.vim
vmap <silent> sx :Str2HtmlEntity<cr>
vmap <silent> sr :Entity2HtmlString<cr>

" ref.vim
let g:ref_phpmanual_path        = $HOME . '/git/config/doc/phpmanual'
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

"}}}

""" local
"-----------------------------------------------------------------------------
"{{{

" local 用の設定を行う
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
