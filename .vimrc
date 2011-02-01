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


set nu!
set tabstop=2
set shiftwidth=2
set wrap
set autoindent


