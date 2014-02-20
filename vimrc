" bootstrap {{{

  set nocompatible               " Be iMproved
  filetype off

  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  let g:neobundle_default_git_protocol = 'https'
  call neobundle#rc(expand('~/.vim/bundle/'))

  " Let NeoBundle manage NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Recommended to install
  " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
  NeoBundle 'Shougo/vimproc'

  " My Bundles here:
  "
  " Note: You don't set neobundle setting in .gvimrc!
  " Original repos on github
  NeoBundle 'myusuf3/numbers.vim'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'ervandew/supertab'
  NeoBundle 'tpope/vim-bundler'
  NeoBundle 'tpope/vim-dispatch'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'altercation/vim-colors-solarized'
  " NeoBundle 'skammer/vim-css-color'  " This guy slows everything down
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'plasticboy/vim-markdown'
  NeoBundle 'jistr/vim-nerdtree-tabs'
  NeoBundle 'tangledhelix/vim-octopress'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'evanmiller/nginx-vim-syntax'
  NeoBundle 'godlygeek/tabular'
  NeoBundle 'Lokaltog/powerline'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'Shougo/vimfiler', { 'depends': 'Shougo/unite.vim' }
  NeoBundle 'tpope/vim-fugitive', { 'augroup': 'fugitive' }
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'vim-ruby/vim-ruby'

	" vim-scripts repos
  NeoBundle 'rails.vim'
  NeoBundle 'ack.vim'
  NeoBundle 'ctrlp.vim'
  NeoBundle 'delimitMate.vim'
  NeoBundle 'CursorLineCurrentWindow'

  " if v:version >= 703 && has('patch584') && has('python') && (filereadable('/usr/lib/libclang.dylib') || filereadable('/usr/local/lib/libclang.so') || filereadable('/opt/local/lib/libclang.so') || filereadable('/usr/lib64/libclang.so') || filereadable('/usr/lib/libclang.so'))
  "   NeoBundle 'Valloric/YouCompleteMe', { 'build': { 'mac': 'EXTRA_CMAKE_ARGS="-DUSE_SYSTEM_LIBCLANG=ON" ./install.sh --clang-completer', 'unix': 'EXTRA_CMAKE_ARGS="-DUSE_SYSTEM_LIBCLANG" ./install.sh --clang-completer' } }
  " endif


  filetype plugin indent on     " Required!

  " Brief help
  " :NeoBundleList          - list configured bundles
  " :NeoBundleInstall(!)    - install(update) bundles
  " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

  " Installation check.
  NeoBundleCheck
" }}}

" basic config {{{
  syntax on

  set shell=/bin/zsh
  :imap jj <Esc>
  " Allow saving of files as sudo when I forgot to start vim using sudo.
  :cmap w!! w !sudo tee > /dev/null %
  map <C-n> :NERDTreeToggle<CR>
  set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

	set nobackup
	set nowritebackup
	set noswapfile
	set autochdir
  " set clipboard=unnamed
  if $TMUX == ''
    set clipboard+=unnamed
  endif
  nnoremap <F2> :set invpaste paste?<CR>
  imap <F2> <C-O>:set invpaste paste?<CR>
  set pastetoggle=<F2>

  if exists('+undofile')
    if !isdirectory(expand('~/.vim/tmp')) && exists('*mkdir')
      call mkdir(expand('~/.vim/tmp'), 'p', 0700)
    endif

    set undofile
    set undodir=~/.vim/tmp
  endif

  set fileformats=unix,dos
  set fileformat=unix

  set showmatch
  set matchpairs+=<:>
  set matchtime=5

  set backspace=indent,eol,start
  set shortmess=flmnrxoOrTI
  set iskeyword+=_,$,@,%,#
  set hidden
  set encoding=utf-8
  set termencoding=utf-8
  set title
  set autoread
  set autowrite
  set report=0

	let mapleader = ','
	" swap backtick with apostrophe {{{
	  nnoremap ' `
	  nnoremap ` '
	" }}}
	" make shift-tab work {{{
	  map <Esc>[Z <S-Tab>
	  ounmap <Esc>[Z
	" }}}

  set wildmenu
  set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.dylib,*.dmg,*.pdf
  set wildmode=full
" }}}

" UI options {{{
  " highlight unwanted whitespace {{{
    au ColorScheme * highlight ExtraWhitespace ctermbg=52 guibg=52
    au BufWinEnter * let w:extra_whitespace=matchadd('ExtraWhitespace', '\s\+$', -1)
  " }}}

  " adjust gutter color {{{
    au ColorScheme * highlight SignColumn ctermbg=NONE
  " }}}

  " color scheme {{{
    set background=dark
    set t_Co=256
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    colorscheme solarized
  " }}}

  " restore screen {{{
    set restorescreen
    set t_ti=[?1049h
    set t_te=[?1049l
  " }}}

  set mouse=nv
  set ttyfast
  set laststatus=2
  set number
  set numberwidth=5
  set ruler
  set cursorline
  set showcmd
  set showmode
  set virtualedit=block
  set confirm
  set updatetime=4000
  set history=1000
  set undolevels=1000
  set viminfo='1000,h,s1000
  set diffopt+=context:3
  set statusline=%(%{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %)%F%m%r%h%w\ [%{&ff}%(/%{&ft}%)]%(\ %#warningmsg#%{exists('g:loaded_syntastic_plugin')?SyntasticStatuslineFlag():''}%*%)%=\ [%03.3b/0x%02.2B]\ [line:%4l,\ col:%4c]\ [%p%%\ of\ %L]
  execute 'set listchars=eol:'.nr2char(172).',trail:'.nr2char(183).',tab:'.nr2char(187).'\ ,extends:'.nr2char(8250).',precedes:'.nr2char(8249).',nbsp:'.nr2char(171)

  if exists('+relativenumber')
    set relativenumber
  endif

  " scrolling {{{
    set scrolloff=5
    set sidescrolloff=5
    set scrolljump=5
    set sidescroll=5
  " }}}

	set splitbelow splitright
	set noequalalways
" }}}

" text options {{{
  set autoindent
  set smartindent
  set nowrap
  set textwidth=80
  set formatoptions=roqwnlmB1
  set linebreak
  set nostartofline
  set comments=s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-,b:\"

  " search {{{
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
    set gdefault
  " }}}

  " tabs {{{
    set softtabstop=0
    set shiftround
    set smarttab
    set ts=2 sw=2 expandtab
  " }}}

  " highlight redundant spaces {{{
    hi RedundantSpaces ctermfg=214 ctermbg=160 cterm=bold
    match RedundantSpaces / \+\ze\t/
  " }}}

  " highlight conflict markers {{{
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
    " jump to next conflict
    nmap <silent> <Leader>> /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
  " }}}
" }}}

" folding {{{
  set foldenable
  set foldmethod=marker
  set foldlevel=0
  set foldcolumn=0
" }}}

" tags {{{
  let g:GtagsCscope_Auto_Load=1
  let g:GtagsCscope_Auto_Map=0
  let g:GtagsCscope_Absolute_Path=1
  let g:GtagsCscope_Keep_Alive=1
  let g:GtagsCscope_Quiet=1
" }}}

" auto-complete and syntax checking {{{
  let g:ycm_add_preview_to_completeopt=1
  let g:ycm_confirm_extra_conf=0
  let g:syntastic_check_on_open=1
  let g:syntastic_enable_signs=0
  let g:syntastic_quiet_warnings=1
  highlight SyntasticErrorSign ctermfg=white ctermbg=red guifg=white guibg=red
" }}}

" indent guides {{{
  let g:indent_guides_auto_colors=0
  au VimEnter,ColorScheme * :hi IndentGuidesOdd  ctermbg=234
  au VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=NONE
" }}}

" vimfiler {{{
  let g:vimfiler_as_default_explorer = 1
" }}}

" use local vimrc if available {{{
  if filereadable(expand('$VIM/vimrc.local'))
    source $VIM/vimrc.local
  endif
  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif
" }}}
