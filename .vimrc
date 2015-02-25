"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc (yoichiwo7)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------
" Plugins (NeoBundle)
"   - not Cygwin
"   - vim version must be 7.2.051 or above
"---------------------------------------------------------------------------
"if !has("win32unix") && version >= 702
if version >= 702
    set nocompatible               " Be iMproved
    filetype off                   " Required!
    
    if has('vim_starting')
        set runtimepath+=$HOME/.vim/bundle/neobundle.vim
        call neobundle#begin(expand('$HOME/.vim/bundle'))
    endif
    
    """ Neobundle
    NeoBundle 'Shougo/neobundle.vim'
    
    """ Plugins -> General
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'scrooloose/nerdtree'

    """ Plugins -> Display
    NeoBundle 'vim-scripts/Wombat'
    NeoBundle 'vim-scripts/wombat256.vim'
    NeoBundle 'Yggdroot/indentLine'

    """ Plugins -> Unite
    "NeoBundle 'Shougo/unite.vim'
    "NeoBundle 'Shougo/vimproc'
    "NeoBundle 'Shougo/vimshell'
    "NeoBundle 'Shougo/neocomplcache'
    
    """ Plugins -> Python
    "NeoBundle 'davidhalter/jedi-vim'
    
    call neobundle#end()
    
    filetype plugin indent on     " Required!
    syntax on
    
    " Installation check.
    if neobundle#exists_not_installed_bundles()
        echomsg 'Not installed bundles : ' .
            \ string(neobundle#get_not_installed_bundle_names())
        echomsg 'Please execute ":NeoBundleInstall" command.'
    endif
endif    

"-------------------------------------------------------------------------
" GUI Settings
"---------------------------------------------------------------------------
if has("gui_running")
    """ general
    lan mes en
    set guioptions-=T
    
    """ font
    set guifont=MS_Gothic:h11:::cSHIFTJIS
    
    """ ime
    set iminsert=0
    set imsearch=0
    
    """cursor color
    if has('multi_byte_ime')
        hi Cursor guifg=bg guibg=Yellow gui=NONE
        hi CursorIM guifg=NONE guibg=Red gui=NONE
    endif

    """ cursor
    set cursorline
endif

"-------------------------------------------------------------------------
" General Settings
"---------------------------------------------------------------------------
syntax on
set nocompatible

""" color scheme
colorscheme desert " default
if has("gui_running")
    colorscheme wombat
else
    set t_Co=256
    colorscheme wombat256mod
endif

""" vim-cmd
set shellslash
set showmatch
set showcmd
set wildmenu
set wildmode=full:list

""" formats
set backspace=indent,eol,start
set formatoptions+=m

""" status line
set laststatus=2
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m
"set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L


""" sound 
set noerrorbells
set novisualbell
set t_vb=

""" japanese encoding
set encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set fenc=utf-8
set iminsert=0
set imsearch=0

""" tab, indent
set ts=4 sw=4
set softtabstop=4
set expandtab
set smartindent
set smarttab
"let g:indentLine_faster = 1

""" searh
set incsearch
set nowrapscan
set ignorecase
set smartcase        " If first char is capital, don't ignorecase
set hlsearch

""" file-related
set nobackup
set autoread
set noswapfile
set hidden

""" vimgrep
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn .hg .git'
let Grep_Cygwin_Find = 1


"-------------------------------------------------------------------------
" Key Settings
"---------------------------------------------------------------------------
""" map leader
let mapleader = ","
let g:mapleader = ","

""" general
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

""" buffer switch
map <C-l>    <ESC>:bn<CR>
map <C-h>    <ESC>:bp<CR>

""" multiwindow switch
map <C-down>   <C-W>j
map <C-up>     <C-W>k
map <C-left>   <C-W>h
map <C-right>  <C-W>l

""" quickfix(vimgrep, make, etc...)
au QuickfixCmdPost make,grep,grepadd,vimgrep copen
map <C-j> <ESC>:cn<CR>
map <C-k>   <ESC>:cp<CR>

""" ctags
let Tlist_WinWidth = 25
map <F7> :TlistToggle<CR>
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""" language-specific
autocmd FileType python :nmap <F5> :w<CR>:!python %<CR>
autocmd FileType perl :nmap <F5> :w<CR>:!perl %<CR>

