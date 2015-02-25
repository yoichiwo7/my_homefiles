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
    
    """ Plugins -> Filer
    NeoBundle 'scrooloose/nerdtree'

    """ Plugins -> Syntax check
    NeoBundle 'scrooloose/syntastic'

    """ Plugins -> Display
    NeoBundle 'vim-scripts/Wombat'
    NeoBundle 'vim-scripts/wombat256.vim'
    NeoBundle 'Yggdroot/indentLine'

    """ Plugins -> Fuzzy access
    NeoBundle 'kien/ctrlp.vim'

    """ Plugins -> Clojure
    NeoBundle 'guns/vim-clojure-static'  "Clojure mode
    "NeoBundle 'clojure-emacs/cider-nrepl'
    "NeoBundle 'tpope/vim-fireplace'
    "NeoBundle 'tpope/vim-leiningen'

    """ Plugins -> Not yet..
    "NeoBundle 'Shougo/unite.vim'
    "NeoBundle 'Shougo/vimproc'
    "NeoBundle 'Shougo/vimshell'
    "NeoBundle 'Shougo/neocomplcache'
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
    set guifont=Ricty_Diminished:h12:::cSHIFTJIS
    
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
    " disable italic font in GUI mode
    hi StatusLine gui=none
    hi Comment    gui=none
    hi String     gui=none
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

""" tab, indent
set ts=4 sw=4
set softtabstop=4
set expandtab
set smartindent
set smarttab
"let g:indentLine_faster = 1

""" line
set display=lastline

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
" Japanese Settings
"---------------------------------------------------------------------------
set iminsert=0
set imsearch=0
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " check if iconv supports eucJP-ms
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " check if iconv supports JISX0213
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " build fileencodings
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
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
    " relase constant
    unlet s:enc_euc
    unlet s:enc_jis
endif
" use 'encoding' as fileencoding if no there is no japanese
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif


"-------------------------------------------------------------------------
" Plugin Settings
"---------------------------------------------------------------------------
""" scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


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


