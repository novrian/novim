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
Plugin 'gmarik/vundle'
" My Plugins here:
"
" original repos on github
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails.git'
Plugin 'tpope/vim-haml.git'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'othree/html5.vim'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'php-doc-upgrade'
Plugin 'godlygeek/tabular'
Plugin 'garbas/vim-snipmate'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Snipmate Dependency
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'taglist.vim'
Plugin 'delimitMate.vim'
Plugin 'bufexplorer.zip'
" non github repos
Plugin 'git://git.wincent.com/command-t.git'
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
            set guifont=Monaco\ 10,Menlo\ Regular\ 10,Consolas\ Regular\ 10,Courier\ New\ Regular\ 10
            " set guifont=Monaco\ Bold\ 9,Andale\ Mono\ Regular\ 10,Menlo\ Regular\ 10,Consolas\ Regular\ 10,Courier\ New\ Regular\ 10
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

" Tab page settings {
    function NoShortTabLine()
        let ret = ''
        for i in range(tabpagenr('$'))
            " select the color group for highlighting active tab"
            if i + 1 == tabpagenr()
                let ret .= '%#errorMsg#'
            else
                let ret .= '%#TabLine#'
            endif

            " find the buffername for the tablabel "
            let buflist = tabpagebuflist(i + 1)
            let winnr = tabpagewinnr(i + 1)
            let buffername = bufname(buflist[winnr - 1])
            let filename = fnamemodify(buffername, ':t')

            " check if there is no name "
            if filename == ''
                let filename = 'noname'
            endif

            " only show the first 6 letters of the name and "
            " .. if the filename is more than 8 letters long"
            if strlen(filename) >= 16
                let ret .= '[' . filename[0:15] . ']'
            else
                let ret .= '[' . filename . ']'
            endif
        endfor

        " after the last tab fill with TabLineFill and reset tab page "
        let ret .= '%#TabLineFill#%T'
        return ret
    endfunction

	  " set tabline=%!NoShortTabLine()

    function NoShortTabLabel()
        let bufnrlist = tabpagebuflist(v:lnum)
        " show only the first 6 letter of the name + .. "
        let label = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
        let filename = fnamemodify(label, ':h')
        " only add .. if string is more than 8 letters"
        if strlen(filename) >= 8
            let ret = filename[0:5] . '..'
        else
            let ret = filename
        endif

        return ret
    endfunction

    " set guitablabel=%{NoShortTabLabel()}

    nnoremap <C-Down> :tabprevious<CR>
    nnoremap <C-Up> :tabnext<CR>
    nnoremap <silent> <A-Down> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <A-Up> :execute 'silent! tabmove ' . tabpagenr()<CR>
" }

" Emmet Settings {
let g:user_emmet_mode = 'inv'
" }

" Syntastic Settings {

" == General Setting ==
let g:syntastic_aggregate_errors = 1

" == HTML Setting ==
let g:syntastic_html_tidy_exec = 'tidy'

" == PHP Setting ==
let g:syntastic_php_checkers = ['php', 'tidy']
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
" }

" Highlighting Column 80 {
highlight ColorColumn ctermbg=000 guibg=#2c2d27
let &colorcolumn="80,".join(range(81,999),",")
" }

set cursorcolumn
set cursorline

" Bufexplorer Mapping {
nnoremap <M-F12> :BufExplorer<CR>
nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <C-S-Left> :bf<CR>
nnoremap <C-S-Right> :bl<CR>
" }

" Airline Configuration {
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'
" }
