set nocompatible
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

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

" SuperStatus
let g:superstatus_arrows = 'compatible'
let g:superstatus_statusline = 'COMPATIBLE'

" Mappings

"   Tab nav
map ;] :tabnext<cr>
map ;[ :tabprevious<cr>

"   FuzzyFinder
map fb :FufBuffer<cr>
map fn :FufFile<cr>
map fd :FufDir<cr>

" Work

set expandtab
set shiftwidth=2

