set nocompatible
set encoding=utf-8

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Leader
let mapleader=","

set updatecount=0   " Disable swap files. Systems don't crash much these days.
set history=200     " Remember more Ex commands
set showcmd         " show partial commands below the status line
set ruler           " show cursor position at all times
set cursorline      " highlight the line of the cursor
set autoread        " Auto-reload buffers when file changed on disk
set scrolloff=3     " have some context around current line always on screen

"" Searching
set hlsearch   " highlight matches
set incsearch  " do incremental searching
set ignorecase " searches are case insensitive
set smartcase  " unless they contain at least one capital letter
" clear search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
set gdefault   " have :s///g flag on by default

"" Whitespace
set tabstop=2 shiftwidth=2 " a tab is two spaces
" set softtabstop=2
set expandtab              " use spaces, not tabs
set list
set backspace=indent,eol,start " backspace through everything in insert mode
set formatoptions+=j " Delete comment char when joining commented lines
set nojoinspaces     " Use only one space after "." when joining lines, not 2
" display extra whitespace
" set list listchars=tab:»·,trail:·
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮
set showbreak=↪\

" Time out on key codes but not on mappings.
set notimeout
set ttimeout
set ttimeoutlen=100

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Avoid showing trailing whitespace when in insert mode
  au InsertEnter * :set listchars-=trail:•
  au InsertLeave * :set listchars+=trail:•

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,txt} setf markdown
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript

  " Enable spell checking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd BufRead,BufNewFile *.markdown.erb setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('rg')
  " Use ripgrep over Grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l%m

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

filetype plugin indent on     " required
" Set colour scheme and turn on syntax highlighting
syntax enable
set background=dark

if has('termguicolors')
  " set Vim-specific sequences for RGB colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors

  colorscheme tender
  let g:airline_theme = 'tender'
else
  colorscheme solarized8
  let g:airline_theme = 'solarized'
endif

" Comments are in italicized font
highlight Comment cterm=italic

" Make it obvious where 80 characters is
set textwidth=79
set colorcolumn=+1

" Numbers
set number
set numberwidth=4
set relativenumber

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

" Open new split panes to right and bottom, which feels more natural
set splitbelow

" Quicker window movement
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

let g:html_indent_tags = 'li\|p'

"" Status line
set laststatus=2    " Always show statusline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" vim-test config.
let test#strategy = "tslime"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Clear tslime variables
nmap <C-c>r <Plug>SetTmuxVars
