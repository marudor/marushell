set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'airblade/vim-gitgutter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomasr/molokai'
Plugin 'ervandew/supertab'
Plugin 'shougo/neocomplete.vim'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ConradIrwin/vim-bracketed-paste'


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set laststatus=2
set history=1000
set cursorline
set linespace=0
set backspace=indent,eol,start
set showmatch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set foldenable
set vb
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2

