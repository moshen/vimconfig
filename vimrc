set nocompatible
filetype off 

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Bundles
" vim-scripts
Bundle "SelectBuf"
Bundle "SuperTab-continued."
Bundle "The-NERD-tree"
Bundle "Wombat"
Bundle "wombat256.vim"
Bundle "genutils"
Bundle "EasyMotion"
" github
Bundle "groenewege/vim-less"
Bundle "plasticboy/vim-markdown"
Bundle "kien/ctrlp.vim"
Bundle "Lokaltog/vim-powerline"
Bundle "tpope/vim-git"

set backupskip=/tmp/*,/private/tmp/*"

try
  colorscheme wombat256mod
catch
endtry

set background=dark
filetype plugin on
syntax on

" Autosettings
augroup mkd
  autocmd FileType mkd setlocal ai spell nofoldenable colorcolumn=80
  " old options: formatoptions=tcroqn2 comments=n:&gt;
augroup END

augroup commit
  autocmd FileType gitcommit,cvs setlocal spell textwidth=72 colorcolumn=73
augroup END


" Enable the status bar
set laststatus=2

set number
set tabstop=2
set wrap
set autoindent
set backspace=indent,eol,start

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

