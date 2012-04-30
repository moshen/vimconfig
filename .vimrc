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
Bundle "SuperTab"
Bundle "The-NERD-tree"
Bundle "Wombat"
Bundle "wombat256.vim"
Bundle "genutils"
Bundle "git.zip"
Bundle "L9"
Bundle "FuzzyFinder"
" github
Bundle "itspriddle/vim-lesscss"
Bundle "plasticboy/vim-markdown"

set backupskip=/tmp/*,/private/tmp/*"

colorscheme wombat256mod

set background=dark
filetype plugin on
syntax on

" Autosettings
augroup mkd
  autocmd FileType mkd set ai spell nofoldenable
  " old options: formatoptions=tcroqn2 comments=n:&gt;
augroup END

augroup gitcommit
  autocmd FileType gitcommit set spell
augroup END


set laststatus=2

set nu!
set tabstop=2
set wrap
set autoindent
set backspace=indent,eol,start

" Mappings

"   Tab nav
map ;] :tabnext<cr>
map ;[ :tabprevious<cr>

"   FuzzyFinder
map <C-x>b :FufBuffer<cr>
map <C-x>f :FufFile<cr>
map <C-x>d :FufDir<cr>

" Work

set expandtab
set shiftwidth=2

let g:vundle_default_git_proto = 'git'

