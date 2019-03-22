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
      NeoBundle 'ujihisa/unite-colorscheme'
      NeoBundle 'inkarkat/vim-mark'
      NeoBundle 'inkarkat/vim-ingo-library' "for vim-mark
      NeoBundle 'Shougo/neocomplete.vim'
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
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

"------------------------------------------------
"Netrw
"------------------------------------------------
let g:netrw_altv = 1 "'v'�ŉE���ɊJ��(�f�t�H���g�͍�)
let g:netrw_alto = 1 "'o'�ŉ����ɊJ��(�f�t�H���g�͏�)
let g:netrw_winsize = 85 "�����̂Ƃ���85%�̃T�C�Y
let g:netrw_liststyle = 3 "�c���[�\��
let g:netrw_preview   = 1 "�v���r���[�𐂒�����

"------------------------------------------------
" �����n
"------------------------------------------------
set ignorecase "���������񂪏������Ƃ�,�啶������������ʂȂ�����
set smartcase  "���������񂪑啶���̂Ƃ�,��ʂ��Č���
set incsearch  "������������͎��ɏ����Ώە�����Ƀq�b�g������
set wrapscan   "�������ɍŌ�܂ōs������ŏ��ɖ߂�
set hlsearch   "��������n�C���C�g�\��
"ESC�A�łŃn�C���C�g����
nnoremap <ESC><ESC> :nohl<CR>

"------------------------------------------------
"window�֘A
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
"�L�[���蓖��
"------------------------------------------------
nnoremap j gj
nnoremap k gk
set nobackup "�o�b�N�A�b�v�t�@�C�������Ȃ�
nnoremap gn :<C-u>tabnew<CR> "�V�����^�u
"�r�W���A�����[�h����$�ŉ��s���܂߂Ȃ�
vnoremap $ $h
"���s���܂߂Ȃ��R�s�[
nnoremap yu 0v$hy
"�ŏI�s�̍s���܂ňړ�
nnoremap G G$
xnoremap G G$
"���̌��Ɉړ����Ȃ�
"nnoremap F *N
nnoremap F yiwk$/<C-r><S-0><CR>
"grep
nnoremap ,g yiw:vim <C-r><S-0> % <Bar> cw<CR><S-g><C-w>k<C-o>

"------------------------------------------------
"����,�F�֘A
"------------------------------------------------
set list  " �s��������\������
set listchars=tab:>-,trail:.  " �^�u�� >--- ���X�y�� . �ŕ\������
set tabstop=4
"�S�p�X�y�[�X�̉���
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd VimEnter,WinEnter * match IdeographicSpace /�@/
"augroup END

"------------------------------------------------
"Others
"------------------------------------------------
set viminfo='1000,f1,<500 "viminfo
set noswapfile "�X���b�v�t�@�C�������Ȃ�
set noundofile ".un~ �t�@�C�������Ȃ�
set scrolloff=1 "�J�[�\���O�ɕ\������s���̗]�T
set foldmethod=marker "{{{��}}}��,�͂܂ꂽ�͈͂�܂���
set visualbell t_vb= "�r�[�v�����ׂĂ𖳌��ɂ���
set noerrorbells "�G���[���b�Z�[�W�̕\�����Ƀr�[�v��炳�Ȃ�
set autochdir "�����I�ɃJ�����g�f�B���N�g����ύX
set number "�s���̕\��
set autoindent " ���s���ɑO�̍s�̃C���f���g���p������
set smartindent " �O�̍s�̍\�����`�F�b�N�����̍s�̃C���f���g�𑝌�����
set shiftwidth=4 " smartindent�ő������镝
set linebreak "�P��P�ʂŐ܂�Ԃ�

"------------------------------------------------
"�X�y���`�F�b�N
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
