set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'VundleVim/Vundle.vim'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'digitaltoad/vim-pug'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
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
if v:version < 800
  Plugin 'vim-syntastic/syntastic'
else
  Plugin 'w0rp/ale'
endif
Plugin 'editorconfig/editorconfig-vim'

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

if v:version < 800
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif



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

