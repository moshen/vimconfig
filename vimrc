set nocompatible
filetype off 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" Plugins
" vim-scripts
Plugin 'SelectBuf'
Plugin 'Wombat'
Plugin 'wombat256.vim'
Plugin 'genutils'
" github
Plugin 'groenewege/vim-less'
Plugin 'plasticboy/vim-markdown'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-git'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'Lokaltog/vim-easymotion'

call vundle#end()

set backupskip=/tmp/*,/private/tmp/*"

try
  colorscheme wombat256mod
catch
endtry

set background=dark
filetype plugin on
syntax on

" Autosettings
augroup mkd " MarkDown
  autocmd FileType mkd setlocal ai spell nofoldenable colorcolumn=80
augroup END

augroup commit
  autocmd FileType gitcommit,cvs setlocal spell textwidth=72 colorcolumn=73
augroup END

" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Enable the status bar
set laststatus=2

if $POWERLINE_FONT
  let g:airline_powerline_fonts = 1
endif

set hlsearch
set number
set tabstop=2
set wrap
set autoindent
set backspace=indent,eol,start

" GUI

if has("gui_running")
  colorscheme wombat

  if has("gui_win32") || has("gui_win32s")
    set guifont=Ubuntu_Mono_derivative_Powerlin:h18
    let g:airline_powerline_fonts = 1
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8
  endif
endif

" Mappings

"   Tab nav
map ;] :tabnext<cr>
map ;[ :tabprevious<cr>

" Work

set expandtab
set shiftwidth=2

let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|CVS$\|\.svn$\|target$',
  \ 'file': '\.class$\|\.so$',
  \ }
let g:ctrlp_extensions = ['dir', 'mixed']
let g:vundle_default_git_proto = 'git'

