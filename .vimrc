" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}

" 自動補完 {{{
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

" 括弧の自動入力
NeoBundle 'Townk/vim-autoclose'

" 一括コメントアウト
NeoBundle 'tpope/vim-commentary'

" HTMLの自動入力
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-t>'

" Slimのシンタックスハイライト
NeoBundle 'slim-template/vim-slim'

" JSXのシンタックスハイライト
NeoBundle 'othree/yajs.vim'
NeoBundle 'maxmellon/vim-jsx-pretty'

" Helpの日本語化
NeoBundle 'vim-jp/vimdoc-ja'

NeoBundleCheck
call neobundle#end()

" コード補完の自動化
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
endfor

syntax on " ソースコードハイライトON
set encoding=utf-8 "文字コード関連"
set fenc=utf-8
set fileformats=unix,dos,mac
set t_Co=256 " 256色使用
set number " 行番号を表示
set cursorline " カーソルラインを表示 "
set tabstop=2 " ２タブ
set shiftwidth=2 " オートインデント時２タブ
set softtabstop=2 " 連続した空白に対して２文字ずつカーソル移動
set autoindent " インデントの自動挿入
set smartindent " インデントの自動挿入
set expandtab " タブをスペース扱い
set whichwrap=b,s,h,l,<,>,[,] " 行を跨いだ左右カーソル移動
set showmatch " 閉じ括弧入力時に対応する開き括弧を一瞬表示
set display=lastline " 末尾の行が収まらない場合もできるだけ表示
set laststatus=2 " 画面下にステータスバーを表示
set incsearch  " 検索時に１文字入力ごとに検索を実行する
set hlsearch   " 検索結果をハイライトする
set filetype=html " ファイルの種類を特定できない場合HTML扱い
set backspace=indent,eol,start " バックスペースがきかなくなる対策
set list  " 不可視文字を表示する
set listchars=tab:>-,trail:.  " タブを >--- 半スペを . で表示する
