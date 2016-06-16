set nocompatible
filetype off

if !$VIMHOME
  let $VIMHOME=$HOME."/.vim"
endif
set rtp+=$VIMHOME/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" Plugins
" vim-scripts
Plugin 'Wombat'
Plugin 'wombat256.vim'
Plugin 'genutils'
" github
Plugin 'groenewege/vim-less'
Plugin 'plasticboy/vim-markdown'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-git'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'embear/vim-localvimrc'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()

try
  colorscheme wombat256mod
catch
endtry

set background=dark
filetype plugin on
syntax on

" Autosettings
augroup mkd " MarkDown
  autocmd FileType markdown setlocal ai spell nofoldenable colorcolumn=80
augroup END

augroup commit
  autocmd FileType gitcommit,cvs setlocal spell textwidth=72 colorcolumn=73
augroup END

" JSON files masquerading as other files
autocmd BufRead,BufNewFile
  \ .bowerrc,.jscsrc,.jshintrc,.eslintrc
  \ setfiletype json

" Enable the mouse
if has('mouse')
  set mouse=a
endif

" Enable the status bar
set laststatus=2

if $POWERLINE_FONT
  let g:airline_powerline_fonts = 1
else
  let g:airline_left_sep = '▚'
  let g:airline_left_alt_sep = '▘'
  let g:airline_right_sep = '▞'
  let g:airline_right_alt_sep = '▝'
endif

set hidden
set hlsearch
set number
set tabstop=2
set expandtab
set shiftwidth=2
set wrap
set autoindent
set backspace=indent,eol,start

" Grep accross all files in local directory
set grepprg=grep\ -nR\ $*\ .

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

" Map more <Leader>
let mapleader = " "
map \ <Leader>

"   Copy
map <Leader>y "+y
"   Paste
map <Leader>p "+p

" Grep operator
nnoremap <Leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <Leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  silent! execute "grep! -F " . shellescape(@@)
  copen
endfunction

" Plugin Settings
let g:localvimrc_persistence_file=$VIMHOME."/localvimrc_persist"
let g:localvimrc_persistent=1

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|CVS$\|\.svn$\|target$\|node_modules\|bower_components',
  \ 'file': '\.class$\|\.so$\|\.swp$',
  \ }
let g:ctrlp_extensions = ['dir', 'mixed']

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:vundle_default_git_proto = 'git'

