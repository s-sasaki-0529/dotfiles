"---------------------------------------------------------
" NeoBundle ここから
"---------------------------------------------------------
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

"---------------------------------------------------------
" 自動補完
"---------------------------------------------------------
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neocomplcache-rsense.vim'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:rsenseHome = expand("~/.vim/bundle/rsense")
let g:rsenseUseOmniFunc = 1

"---------------------------------------------------------
" シンタックスチェック
"---------------------------------------------------------
NeoBundle 'scrooloose/syntastic.git'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"---------------------------------------------------------
" 括弧の自動入力
"---------------------------------------------------------
NeoBundle 'Townk/vim-autoclose'
autocmd FileType ruby setlocal commentstring=#\ %s

"---------------------------------------------------------
" 一括コメントアウト gc
"---------------------------------------------------------
NeoBundle 'tpope/vim-commentary'

"---------------------------------------------------------
" HTMLの自動入力 <C-t>,
"---------------------------------------------------------
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-t>'

"---------------------------------------------------------
" ディレクトリツリー <C-n>
"---------------------------------------------------------
NeoBundle 'scrooloose/nerdtree'
nmap <silent><C-n> :NERDTreeToggle<CR>

"---------------------------------------------------------
" シンタックスハイライト
"---------------------------------------------------------
NeoBundle 'slim-template/vim-slim'
NeoBundle 'othree/yajs.vim'
NeoBundle 'maxmellon/vim-jsx-pretty'
NeoBundle 'posva/vim-vue'
highlight Search term=bold,reverse ctermfg=15 ctermbg=233 gui=bold,reverse

"---------------------------------------------------------
" ステータスラインの装飾
"---------------------------------------------------------
NeoBundle 'itchyny/lightline.vim'

"---------------------------------------------------------
" Helpの日本語化
"---------------------------------------------------------
NeoBundle 'vim-jp/vimdoc-ja'

"---------------------------------------------------------
" NeoBundle ここまで
"---------------------------------------------------------
NeoBundleCheck
call neobundle#end()

"----------------------------------------------------------
" 配色設定
"----------------------------------------------------------
set t_Co=256
highlight StatusLine   cterm=NONE ctermfg=white ctermbg=233
highlight StatusLineNC cterm=NONE ctermfg=white ctermbg=233
highlight VertSplit    cterm=NONE ctermfg=233   ctermbg=233
highlight Pmenu     ctermbg=4
highlight PmenuSel  ctermbg=1
highlight PmenuSbar ctermbg=4
syntax on

"---------------------------------------------------------
" 文字コード関係
"---------------------------------------------------------
set encoding=utf-8
set fenc=utf-8
set fileformats=unix,dos,mac

"---------------------------------------------------------
" エディタの見た目関係
"---------------------------------------------------------
set number
set laststatus=2
set list
set showmatch
set display=lastline
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P]']'}

"---------------------------------------------------------
" インデント関係
"---------------------------------------------------------
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set listchars=tab:>-,trail:.
set softtabstop=2
set backspace=indent,eol,start

"---------------------------------------------------------
" 検索関係
"---------------------------------------------------------
set incsearch
set hlsearch

"---------------------------------------------------------
" その他
"---------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,]
set filetype=html
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末スペースを削除
autocmd InsertEnter * set nohlsearch " 挿入モードではハイライトを無効
autocmd InsertLeave * set hlsearch " 挿入モード以外ではハイライトを有効

"---------------------------------------------------------
" その他 キーバインド
"---------------------------------------------------------
inoremap <silent> jj <ESC>:w<CR>:noh<CR>
inoremap <silent> <C-j> <ESC><ESC>
inoremap <silent> <C-l> <CR>
inoremap <silent> <C-;> <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>
nnoremap <Down> gj
nnoremap <Up>   gk
