set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'micha/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'


call vundle#end()

filetype plugin indent on


" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

set background=dark
" colorscheme solarized
set laststatus=2

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


syntax on

autocmd VimEnter * NERDTree
autocmd VimEnter * NERDTreeMirror
autocmd VimEnter * NERDTreeFocusToggle
map <F10> :NERDTreeFocusToggle<CR>
