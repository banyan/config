""" encoding
"-----------------------------------------------------------------------------

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

""" search
"-----------------------------------------------------------------------------

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

""" edit
"-----------------------------------------------------------------------------

set tabstop=4
set expandtab
set autoindent
set backspace=2
set showmatch
set wildmenu
"set formatoptions+=mM
"set formatoptions-=ro
set ambiwidth=double
set shiftwidth=4
set wildmode=longest,list
let format_allow_over_tw = 1  " ぶら下り可能幅

 " バッファが編集中でもその他のファイルを開けるように
set hidden

" " 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

""" show
"-----------------------------------------------------------------------------

set number
set ruler
set nolist
set wrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set scrolljump=5
set scrolloff=3
"set cul
set t_Co=256

" 重い＞＜
" http://vimwiki.net/?faq%2F3
" ラインカーソル
"set updatetime=1
"sign define Cursor text=>> linehl=Search
"fun! PlaceCursor()
    "sign unplace *
    "exe "sign place 1 line=" . line(".") . " name=Cursor buffer=" . bufnr("%")
"endfun
"au! CursorHold * call PlaceCursor()

"set updatetime=1
"autocmd CursorHold * :match Search /^.*\%#.*$/

"colorscheme deveiate
"colorscheme less
"colorscheme black_angus
"colorscheme xoria256
"colorscheme rdark
"colorscheme relaxedgreen
"colorscheme ps_color
"colorscheme 3dglasses
"colorscheme inkpot
"colorscheme zenburn
"colorscheme colorful256
"colorscheme desert256
colorscheme blacklight

"シンタックスハイライトを有効にする
syntax on

filetype plugin indent on

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
nnoremap <silent> <C-L> :noh<C-L><CR>

 """ file
autocmd FileType css        set sw=4 ts=4 sts=0 noet
autocmd FileType eruby      set ts=4 sw=4 sts=0 noet
autocmd FileType html       set sw=4 ts=4 sts=0 noet
autocmd FileType javascript set sw=4 ts=4 sts=0 noet
autocmd FileType php        set sw=4 ts=4 sts=0 et
autocmd FileType ruby       set sw=2 ts=2 sts=0 et
autocmd FileType sql        set ts=4 sw=4 sts=0 et
set nobackup
set clipboard=unnamed

autocmd FileType * set formatoptions-=ro

""" misc
"-----------------------------------------------------------------------------
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
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=4
hi PmenuSbar ctermbg=8

" http://d.hatena.ne.jp/kasahi/20070902/1188744907 
" 半角を別色表示に
highlight WhitespaceEOL ctermbg=8 guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

 " ステイタス行に文字コードと改行コードを表示。
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

 " バッファの移動
map <F5> <ESC>:bp<CR>
map <F6> <ESC>:bn<CR>
map <F7> <ESC>:bw<CR>
map <F8> <ESC>:bd<CR>

""" plugin
"-----------------------------------------------------------------------------

 " bufferlist.vim
:map <silent> <C-i> :call BufferList()<CR>

 " fuzzyfinder.vim
let mapleader = ' f'
nnoremap <silent> <C-s> :FuzzyFinderBuffer<CR>
nnoremap <silent> <Leader>b :FuzzyFinderBuffer<CR>
nnoremap <silent> <Leader>f :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> <Leader>m :FuzzyFinderMruFile<CR>
nnoremap <silent> <Leader>c :FuzzyFinderMruCmd<CR>
nnoremap <silent> <Leader>v :FuzzyFinderFavFile<CR>
nnoremap <silent> <Leader>d :FuzzyFinderDir <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> <Leader>t :FuzzyFinderTag!<CR>
nnoremap <silent> <Leader>g :FuzzyFinderTaggedFile<CR>
nnoremap <silent> <Leader>a :FuzzyFinderAddFavFile<CR>
"nnoremap <silent> <C-]>     :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>

 " taglist.vim
let mapleader = ' t'
nnoremap <Leader>l       :Tlist<CR>
nnoremap <Leader><C-l>       :Tlist<CR>
nnoremap <Leader>o       :TlistClose<CR>
nnoremap <Leader><C-o>       :TlistClose<CR>

" NERD_commenter
"<Leader>xでコメントをトグル(NERD_commenter.vim)
let mapleader = ','
map <Leader>x ,c<space>
map <Leader>s ,cm<space>

" AlignPlugin.vim  
let mapleader = ' a'
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

