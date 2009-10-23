"==============================================================
" 文字コードの自動認識プラグイン
" recognize_charcode.vim
"==============================================================
" [参考] (感謝)
" ・コードのほぼ全てを、ずんWikiさんの「文字コードの自動認識」
"   (http://www.kawaz.jp/pukiwiki/?vim#cb691f26)を使用させて頂いている
" ・ずんWikiさんのコードに対する修正は、Heavens hellさんの「vim でたまに文字化け」
"   (http://d.hatena.ne.jp/heavenshell/20080105/1199536148)
" ・プラグインの作り方は、KaoriYa.netさんの「Vim日本語ドキュメント」
"   (http://www.kaoriya.net/vimdoc_j/)からダウンロードしたスナップショット内の
"   runtime/doc/usr_41.jax 41.11節「プラグインを書く」、
"   及び、名無しのVIM使いさんの「1ファイルで構成されるプラグインのテンプレート」
"   (http://nanasi.jp/articles/code/stdplugin/template.html)を参考にした
"
" [このプラグインの実行例]
" (1) このファイルを 任意ディレクトリ/recognize_charcode.vim に保存する
" (2) ~/.vimrc に 
"        source 任意ディレクトリ/recognize_charcode.vim
"     を加える
"     「任意ディレクトリ」 は 「~/.vim」 とするのが標準らしい


"--------------------------------------------------------------

" プラグイン設定
" プラグインが2回読み込まれることを防止
if exists("loaded_recognize_charcode")
  finish
endif
let loaded_recognize_charcode = 1

" ユーザ設定を逃す
let s:save_cpo = &cpo
set cpo&vim

"-------------------- 文字コード認識部 開始 --------------------

if &encoding !=# 'utf-8'
　set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    
    "(A)
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc

    if s:fileencodings_default =~ 'utf-8'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      let &fileencodings = substitute(&fileencodings, "utf-8", "utf-8,cp932", "g")
    else
      let &fileencodings = &fileencodings .',cp932,'. s:fileencodings_default
    endif
    unlet s:fileencodings_default
    "(B)

  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"-------------------- 文字コード認識部 終了 --------------------

" 逃がしていたユーザの設定を修復
let &cpo = s:save_cpo

