" A little modification from Steve Francia's vimrc
" https://github.com/spf13/spf13-vim
"
" This is only my personal use. So use at your own risk
"
" Cheers,
"   Novrian - k4k1_c0der

set nocompatible                " be iMproved
filetype on                     " required!
filetype indent on              " Enable filetype-specific indenting
filetype plugin indent on       " required!


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
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-obsession'
Bundle 'tomasr/molokai'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'othree/html5.vim'
Bundle 'vim-ruby/vim-ruby.git'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'ervandew/supertab'
Bundle 'php-doc-upgrade'
Bundle 'tetsuo13/Vim-PHP-Doc'
Bundle 'godlygeek/tabular'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'taglist.vim'
Bundle 'delimitMate.vim'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

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
    set backspace=2
    set backspace=indent,eol,start
" }

" Leader Map {
let g:EasyMotion_leader_key = '@'
" } "

" php-doc upgrade map
autocmd FileType php inoremap <C-p> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-p> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-p> :call PhpDocRange()<CR>

autocmd FileType ruby compiler ruby

" Encoding Settings {
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif
" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T " Remove the toolbar
        set lines=40 " 40 lines of text instead of 24
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 10,Menlo\ Regular\ 10,Consolas\ Regular\ 10,Courier\ New\ Regular\ 10
        elseif has("gui_mac")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h12,Consolas\ Regular:h12,Courier\ New\ Regular:h12
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
    set expandtab
    set smartindent
    set shiftwidth=4
    set softtabstop=4
    set nowrap                      " Wrap long lines
" }

" SuperTab Config {
    let g:SuperTabDefaultCompletionType = ""
" }

" Tab page settings {
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" }

" Status Line {  
    set laststatus=2                                " always show statusbar  
    set statusline=  
    set statusline+=%-10.3n\                        " buffer number
    set statusline+=%f\                             " filename   
    set statusline+=%h%m%r%w                        " status flags
    set statusline+=\[%{strlen(&ft)?&ft:'none'}]    " file type  
    set statusline+=%=                              " right hlign remainder  
    set statusline+=0x%-8B                          " character value  
    set statusline+=%-14(%l,%c%V%)                  " line, character  
    set statusline+=%<%P                            "filel position
"}  
