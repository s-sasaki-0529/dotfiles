" Dein ここから
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })

  " プラグインのインストール
  call dein#add('Shougo/neocomplcache.vim')         " コード補完
  call dein#add('Shougo/neocomplcache-rsense.vim')  " コード補完
  call dein#add('w0rp/ale')
  call dein#add('Shougo/unite.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('Townk/vim-autoclose')
  call dein#add('tpope/vim-commentary')
  call dein#add('AndrewRadev/switch.vim') " gs
  call dein#add('mattn/emmet-vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('slim-template/vim-slim')
  call dein#add('othree/yajs.vim')
  call dein#add('maxmellon/vim-jsx-pretty')
  call dein#add('itchyny/lightline.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('posva/vim-vue')
  call dein#add('tpope/vim-endwise')
  call dein#add('vim-jp/vimdoc-ja')

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
" Dein ここまで

" neocomplcache コード補完の設定
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

" Unite 汎用インタフェース
" TODO: Deniteに乗り換え
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,f :Unite file_rec/git<CR>
nnoremap <silent> ,g :Unite grep/git<CR>

" ALE
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'vue': ['eslint']
\}
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_open_list = 0
let g:ale_fix_on_save = 0
command Fix ALEFix

" 括弧の自動入力
autocmd FileType ruby setlocal commentstring=#\ %s

" emmet HTMLの自動入力 <C-t>,
let g:user_emmet_leader_key='<c-t>'

" nerdtree ディレクトリツリー <C-n>
nmap <silent><C-n> :NERDTreeToggle<CR>

" シンタックスハイライト
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html
highlight Search term=bold,reverse ctermfg=15 ctermbg=233 gui=bold,reverse
hi! link rubyTodo Comment

" ctag
set tags=${APP}/tags " プロジェクトルートに設定

" 配色設定
set t_Co=256
highlight StatusLine   cterm=NONE ctermfg=white ctermbg=233
highlight StatusLineNC cterm=NONE ctermfg=white ctermbg=233
highlight VertSplit    cterm=NONE ctermfg=233   ctermbg=233
highlight Pmenu     ctermbg=4
highlight PmenuSel  ctermbg=1
highlight PmenuSbar ctermbg=4
syntax on

" 文字コード関係
set encoding=utf-8
set fenc=utf-8
set fileformats=unix,dos,mac

" エディタの見た目関係
set number
set laststatus=2
set list
set showmatch
set display=lastline
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P]']'}

" インデント関係
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set listchars=tab:>-,trail:.
" set softtabstop=2 悪さするほうが多い?
set backspace=indent,eol,start

" 検索関係
set incsearch
set hlsearch

" その他
set whichwrap=b,s,h,l,<,>,[,]
set filetype=html
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末スペースを削除
autocmd InsertEnter * set nohlsearch " 挿入モードではハイライトを無効
autocmd InsertLeave * set hlsearch " 挿入モード以外ではハイライトを有効

" その他コマンド
command Fn echo expand("%:p")

" その他 キーバインド
nnoremap <C-C> :w<CR>
inoremap <silent> jj <ESC>:w<CR>:noh<CR>
inoremap <silent> <C-l> <CR>
inoremap <silent> <C-;> <CR>
nnoremap <silent> <C-x> :bd<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <Esc><Esc> :noh<CR>
nnoremap <Down> gj
nnoremap <Up>   gk
inoremap <silent> {<CR> {<CR>}<ESC><S-o>
inoremap <silent> [<CR> [<CR>]<ESC><S-o><TAB>
inoremap <silent> (<CR> (<CR>)<ESC><S-o><TAB>
" ドキュメントコメント入れる。ひどいゴリ押し
inoremap <silent> ###<CR> ###<Left><Left><CR><Right><CR><Right><Up><Space>
