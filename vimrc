set nocompatible

" Leader
let mapleader=" "

set backspace=2     " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler           " show cursor position at all times
set showcmd
set incsearch       " do incremental searching
set laststatus=2
set cursorline
set autowrite

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set tabstop=2 shiftwidth=2 " a tab is two spaces
set softtabstop=2
set expandtab              " use spaces, not tabs

" display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects
  " .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Set colour scheme and turn on syntax highlighting
syntax enable
set background=dark
if !has('gui_running')
  let g:solarized_termcolors=256
  let g:solarized_visibility="high"
endif
colorscheme solarized
" highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will inset tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow

" Quicker window movement
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

set backspace=indent,eol,start

let g:syntastic_check_on_open=1
