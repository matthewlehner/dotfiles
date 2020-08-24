set nocompatible    " Vim specific. Neovim is always nocompatible
set encoding=utf-8  " Vim specific. Neovim defaults to UTF-8

" Load extentions
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Leader
let mapleader=","

set hidden          " Abandon buffer when unloaded. For CoC
set updatecount=0   " Disable swap files. Systems don't crash much these days.
set history=200     " Remember more Ex commands
set showcmd         " show partial commands below the status line
set cmdheight=2     " Give more space for displaying messages
set ruler           " show cursor position at all times
set cursorline      " highlight the line of the cursor
set autoread        " Auto-reload buffers when file changed on disk
set scrolloff=3     " have some context around current line always on screen
set updatetime=300  " Changed from default 4s for a better experience
set shortmess+=c    " Don't pass messages to |ins-completion-menu|

" Merge sign column and number column if possible
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use c-space to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
  autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ babylon

  autocmd FileType graphql setlocal formatprg=prettier\ --stdin\ --parser\ graphql

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

" Use RipGrep https://github.com/BurntSushi/ripgrep
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

  let g:one_allow_italics = 1
endif

let g:airline_theme = 'one'
colorscheme one

" Comments are in italicized font
highlight Comment cterm=italic

" Make it obvious where 80 characters is
set textwidth=79
set colorcolumn=+1

" Numbers
set number
set numberwidth=4
set relativenumber

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


" Clear tslime variables
nmap <C-c>r <Plug>SetTmuxVars


