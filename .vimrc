filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set backupskip=/tmp/*,/private/tmp/*"

colorscheme wombat256mod

set background=dark
filetype plugin on
syntax on

 augroup mkd

  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;

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

map ;] :tabnext<cr>
map ;[ :tabprevious<cr>

" Work

set expandtab
set shiftwidth=2

