set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml.git'
Bundle 'mattn/zencoding-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'othree/html5.vim'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
	if has("gui_gtk2")
            set guifont=Consolas\ Regular\ 11,Andale\ Mono\ Regular\ 11,Menlo\ Regular\ 11,Courier\ New\ Regular\ 11
        else
            set guifont=Consolas\ Regular:h11,Andale\ Mono\ Regular:h11,Menlo\ Regular:h11,Courier\ New\ Regular:h11
        endif
        if has('gui_macvim')
            set transparency=5          " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Theme Config by ME!
colorscheme molokai

" Custom Formatting {
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set autoindent
    set nowrap                      " Wrap long lines
" }

" Status Line {  
    set laststatus=2                                " always show statusbar  
    set statusline=  
    set statusline+=%-10.3n\                        " buffer number
    set statusline+=%f\                             " filename   
    set statusline+=%h%m%r%w                        " status flags
    set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type  
    set statusline+=%=                              " right align remainder  
    set statusline+=0x%-8B                          " character value  
    set statusline+=%-14(%l,%c%V%)                  " line, character  
    set statusline+=%<%P                            "filel position
"}  
