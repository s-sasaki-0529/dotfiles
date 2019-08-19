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
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
	call dein#add('SirVer/ultisnips')                 " スニペット
  call dein#add('w0rp/ale')
	call dein#add('fatih/vim-go')
	call dein#add('AndrewRadev/splitjoin.vim')
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
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('thoughtbot/vim-rspec')
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
" Dein ここまで

" 前回のビューの状態を再現できるように
autocmd BufWinLeave *.* silent mkview
autocmd BufWinEnter *.* silent loadview

" deoplete
let g:python3_host_prog='/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1

" go-vim
let g:go_fmt_command = "goimports" "ファイル保存時にimportを調整
let g:go_fmt_fail_silently = 1 "gofmt失敗時にquickfixを表示しない
let g:go_auto_type_info = 1
let g:go_metalinter_enabled = []

" fzf
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,F :GFiles?<CR>
nnoremap <silent> ,b :Buffers<CR>
nnoremap <silent> ,l :Lines<CR>
nnoremap <silent> ,h :History<CR>
nnoremap <silent> ,m :Mark<CR>

" rspec
nnoremap <silent> ,r :call RunNearestSpec()<CR>
nnoremap <silent> ,R :call RunCurrentSpecFile()<CR>
let g:rspec_command = "!bundle exec rspec --format doc {spec}"

" ALE
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'vue': ['eslint']
\}
let g:ale_open_list = 0
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '⚡︎'
let g:ale_set_highlights = 1
highlight ALEError ctermbg=54
highlight ALEWarning ctermbg=62
command Fix ALEFix
command Ale call ale#toggle#Toggle()

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

" 配色設定
set t_Co=256
highlight StatusLine   cterm=NONE ctermfg=white ctermbg=233
highlight StatusLineNC cterm=NONE ctermfg=white ctermbg=233
highlight VertSplit    cterm=NONE ctermfg=233   ctermbg=233
highlight Pmenu     ctermbg=4
highlight PmenuSel  ctermbg=1
highlight PmenuSbar ctermbg=4
highlight SpecialKey ctermfg=235
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
set autoindent
set listchars=tab:>-,trail:.
set backspace=indent,eol,start
autocmd BufNewFile,BufRead * call EnableSpaceIndent()
autocmd BufNewFile,BufRead *.go call EnableTabIndent()
function EnableTabIndent()
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
endfunction
function EnableSpaceIndent()
  set expandtab
  set tabstop=2
  set shiftwidth=2
endfunction

" 検索関係
set incsearch
set hlsearch

" その他
set whichwrap=b,s,h,l,<,>,[,]
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末スペースを削除
autocmd InsertEnter * set nohlsearch " 挿入モードではハイライトを無効
autocmd InsertLeave * set hlsearch " 挿入モード以外ではハイライトを有効
filetype plugin indent on
nnoremap <silent> ,d :bd<CR>
set updatetime=1000
autocmd CursorHold * call AutoSave()
function AutoSave()
  if &modified && !&readonly && bufname('%') !=# '' && &buftype ==# '' && expand("%") !=# ''
    call feedkeys(":w\<CR>", "in")
  endif
endfunction

" その他コマンド
command Fn echo expand("%:p")

" その他 キーバインド
nnoremap <C-C> :w<CR>
inoremap <silent> jj <ESC>:noh<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <Esc><Esc> :noh<CR>
nnoremap <Down> gj
nnoremap <Up>   gk
inoremap <silent> {<CR> {<CR>}<ESC><S-o>
inoremap <silent> [<CR> [<CR>]<ESC><S-o><TAB>
inoremap <silent> (<CR> (<CR>)<ESC><S-o><TAB>
" ドキュメントコメント入れる。ひどいゴリ押し
inoremap <silent> ###<CR> ###<Left><Left><CR><Right><CR><Right><Up><Space>
