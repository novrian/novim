" A little modification from Steve Francia's vimrc
" https://github.com/spf13/spf13-vim
"
" This is only my personal use. So use at your own risk
"
" Cheers,
"   Novrian - k4k1_c0der

set nocompatible                " be iMproved
filetype off                    " required!

" Vundle Configuration
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tomasr/molokai'
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

" General Setting {
    syntax on                   " Turn syntax highlighting on
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set clipboard=unnamed
    set number
" }

" GUI Settings {

" GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T " Remove the toolbar
        set lines=40 " 40 lines of text instead of 24
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        elseif has("gui_mac")
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        elseif has("gui_win32")
            set guifont=Andale_Mono:h12,Menlo:h12,Consolas:h12,Courier_New:h12
        endif
        if has('gui_macvim')
            set transparency=5 " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
"set term=builtin_ansi " Make arrow and other keys work
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
