set nocompatible
set guioptions=M
filetype off

if !$VIMHOME
  let $VIMHOME=$HOME."/.vim"
endif
set rtp+=$VIMHOME/dein/repos/github.com/Shougo/dein.vim

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

if dein#load_state(expand($VIMHOME.'/dein'))
  call dein#begin(expand($VIMHOME.'/dein')) " plugins' root path

  " let Dein manage Dein
  call dein#add('Shougo/dein.vim')

  call dein#add('vim-scripts/Wombat')
  call dein#add('vim-scripts/wombat256.vim')
  call dein#add('vim-scripts/genutils')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('tpope/vim-git')
  call dein#add('bling/vim-airline')
  call dein#add('scrooloose/nerdtree', {
  \   'on_cmd': ['NERDTree', 'NERDTreeToggle']
  \ })
  call dein#add('ajh17/VimCompletesMe')
  call dein#add('Lokaltog/vim-easymotion', {
  \   'on_map': {
  \     'nv': ['<Leader><Leader>', '<Space><Space>']
  \   }
  \ })
  call dein#add('embear/vim-localvimrc')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('plasticboy/vim-markdown', {
  \   'on_ft': 'markdown'
  \ })
  call dein#add('mechatroner/rainbow_csv', {
  \   'on_ft': 'csv'
  \ })
  call dein#add('HerringtonDarkholme/yats.vim') " Typescript
  call dein#add('w0rp/ale') " Linting / Fixing / Completion

  call dein#end()
  call dein#save_state()
endif

try
  colorscheme wombat256mod
catch
endtry

set background=dark
filetype plugin on
syntax on

" Autosettings

augroup vimrc
  autocmd!

  autocmd FileType markdown setlocal ai spell nofoldenable colorcolumn=80
  autocmd FileType gitcommit,cvs setlocal spell textwidth=72 colorcolumn=73

  " JSON files masquerading as other files
  autocmd BufRead,BufNewFile
    \ .bowerrc,.jscsrc,.jshintrc,.eslintrc
    \ setfiletype json

  " HTML templates
  autocmd BufRead,BufNewFile
    \ *.vue
    \ setfiletype html
augroup END

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

" GUI

function ConfigureGui()
  try
    colorscheme wombat
  catch
  endtry

  let g:airline_powerline_fonts = 1
  set encoding=utf-8

  if empty($NVIM_GUI)
    set guifont=Ubuntu_Mono_derivative_Powerlin:h12
  else
    Guifont! Ubuntu Mono derivative Powerlin:h12
  endif

  if has("win32") || has("win32s")
    " Turn off powerline for sub-processes
    let $POWERLINE_FONT=""
    set fileencodings=ucs-bom,utf-8
  endif
endfunction

if has("gui_running")
  call ConfigureGui()
endif

" Neovim

if has("nvim")
  augroup nvim_vimrc
    autocmd!
    autocmd TermOpen * setlocal scrollback=100000
    autocmd TermOpen * hi BlackBg cterm=NONE ctermbg=0 guibg=black
    autocmd TermOpen * setlocal winhighlight=Normal:BlackBg
  augroup END

  " Solarized Dark colors for terminal
  let g:terminal_color_0 = "#000000" " Replaced with black
  let g:terminal_color_1 = "#dc322f"
  let g:terminal_color_2 = "#719e07"
  let g:terminal_color_3 = "#b58900"
  let g:terminal_color_4 = "#268bd2"
  let g:terminal_color_5 = "#d33682"
  let g:terminal_color_6 = "#2aa198"
  let g:terminal_color_7 = "#eee8d5"
  let g:terminal_color_8 = "#073642"
  let g:terminal_color_9 = "#cb4b16"
  let g:terminal_color_10 = "#586e75"
  let g:terminal_color_11 = "#657b83"
  let g:terminal_color_12 = "#839496"
  let g:terminal_color_13 = "#6c71c4"
  let g:terminal_color_14 = "#93a1a1"
  let g:terminal_color_15 = "#fdf6e3"
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
let g:ctrlp_user_command = []
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|CVS$\|\.svn$\|target$\|node_modules\|bower_components',
  \ 'file': '\.class$\|\.so$\|\.swp$',
  \ }
let g:ctrlp_extensions = ['dir', 'mixed']

function GrepUseRipgrep()
  set grepprg=rg\ --no-heading\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m

  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = 'rg --color=never --files %s'
endfunction

function GrepUseSilverSearcher()
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m

  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endfunction

function GrepUseGrep()
  if executable('ggrep') " GNU Grep
    " Grep accross all files in local directory
    set grepprg=ggrep\ -nR\ $*\ .
  else
    set grepprg=grep\ -nR\ $*\ .
  endif

  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
  unlet g:ctrlp_user_command
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endfunction

if executable('rg')
  call GrepUseRipgrep()
elseif executable('ag')
  call GrepUseSilverSearcher()
else
  call GrepUseGrep()
endif

" Editorconfig should be installed on the command line
" so we don't revert to the Python version
if executable('editorconfig')
  let g:EditorConfig_core_mode = 'external_command'
endif

" Ale
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%linter%] [%severity%] [%code%] %s'
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['tslint', 'tsserver'],
  \ 'Dockerfile': ['hadolint']
  \ }
