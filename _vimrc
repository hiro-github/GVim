"------------------------------------------------
"NeoBundle
"------------------------------------------------
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=$VIM/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('$VIM/.vim/bundle/'))
      NeoBundleFetch 'Shougo/neobundle.vim'
      NeoBundle 'Shougo/unite.vim'
      NeoBundle 'Shougo/neomru.vim'
      NeoBundle 'Shougo/vimfiler.vim'
      NeoBundle 'ujihisa/unite-colorscheme'
      NeoBundle 'inkarkat/vim-mark'
      NeoBundle 'inkarkat/vim-ingo-library' "for vim-mark
      NeoBundle 'Shougo/neocomplete.vim'
      NeoBundle 'tpope/vim-fugitive'
    call neobundle#end()
endif
filetype plugin indent on

"------------------------------------------------
"Unite.vim
"------------------------------------------------
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 50
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,ud :<C-u>Unite directory_mru<CR>
nnoremap <silent> ,ub :<C-u>Unite bookmark<CR>
call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')
call unite#custom_default_action('source/directory_mru/directory' , 'vimfiler')

"------------------------------------------------
"Netrw
"------------------------------------------------
let g:netrw_altv = 1 "'v'で右側に開く(デフォルトは左)
let g:netrw_alto = 1 "'o'で下側に開く(デフォルトは上)
let g:netrw_winsize = 85 "分割のときに85%のサイズ

"------------------------------------------------
" 検索系
"------------------------------------------------
set ignorecase "検索文字列が小文字とき,大文字小文字を区別なく検索
set smartcase  "検索文字列が大文字のとき,区別して検索
set incsearch  "検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan   "検索時に最後まで行ったら最初に戻る
set hlsearch   "検索語をハイライト表示
"ESC連打でハイライト解除
nnoremap <ESC><ESC> :nohl<CR>

"------------------------------------------------
"window関連
"------------------------------------------------
nnoremap + ,
nnoremap , <Nop>
nnoremap ,j <C-w>j
nnoremap ,k <C-w>k
nnoremap ,l <C-w>l
nnoremap ,h <C-w>h
nnoremap ,J <C-w>J
nnoremap ,K <C-w>K
nnoremap ,L <C-w>L
nnoremap ,H <C-w>H
nnoremap ,; <C-w>+
nnoremap ,- <C-w>-
nnoremap ,, <C-w><
nnoremap ,. <C-w>>

"------------------------------------------------
"カーソル移動
"------------------------------------------------
nnoremap j gj
nnoremap k gk
set nobackup "バックアップファイルを作らない
nnoremap gn :<C-u>tabnew<CR> "新しいタブ
"ビジュアルモード時に$で改行を含めない
vnoremap $ $h
"改行を含めないコピー
nnoremap yu 0v$hy
"一行ビジュアル選択
nnoremap yv 0v$
"最終行の行末まで移動
nnoremap G G$
xnoremap G G$
"次の候補に移動しない
"nnoremap F *N
nnoremap F yiwk$/<C-r><S-0><CR>
"grep
nnoremap ,g yiw:vim <C-r><S-0> % <Bar> cw<CR><S-g><C-w>k<C-o>

"------------------------------------------------
"Others
"------------------------------------------------
set viminfo='1000,f1,<500 "viminfo
set noswapfile "スワップファイルを作らない
set noundofile ".un~ ファイルを作らない
set scrolloff=1 "カーソル外に表示する行数の余裕
set foldmethod=marker "{{{と}}}で,囲まれた範囲を折り畳む
set visualbell t_vb= "ビープ音すべてを無効にする
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない
set autochdir "自動的にカレントディレクトリを変更
set number "行数の表示
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅
set linebreak "単語単位で折り返し
set fileencoding=utf-8 "ファイル保存時の文字コード設定
set fileencodings=utf-8,cp932 "ファイル読込時の文字コード設定
set diffopt=vertical "vimdiffのとき縦に分割

"------------------------------------------------
"スペルチェック 日本語エラー無視
"------------------------------------------------
set spelllang=en,cjk

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

"------------------------------------------------
"NeoComplete
"------------------------------------------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
