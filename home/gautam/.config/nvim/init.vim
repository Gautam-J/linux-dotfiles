" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Git integration
Plug 'tpope/vim-fugitive'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Undo Tree
Plug 'mbbill/undotree'

" Folder Tree
Plug 'scrooloose/nerdtree'

" Git integration in tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Status bar
Plug 'vim-airline/vim-airline'

" Themes for status bar
Plug 'vim-airline/vim-airline-themes'

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Fuzzy Search
Plug 'kien/ctrlp.vim'

" Pair brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Remove search highlight
Plug 'romainl/vim-cool'

" Git in gutter
Plug 'airblade/vim-gitgutter'

" Surround words with characters
Plug 'tpope/vim-surround'

" Indent Line preview
Plug 'yggdroot/indentLine'

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" enables more useful Vim functionality
set nocompatible

" Disable color from terminal
set t_Co=256
set notermguicolors

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Enable gruvbox theme
colorscheme gruvbox

" Share clipboard contents with system
set clipboard+=unnamedplus

" Set hard contrast for Gruvbox
let g:gruvbox_contrast_dark='hard'

" remove color inversion on selection
let g:gruvbox_invert_selection='0'

" dark mode
set bg=dark

" Default AirLineTheme
let g:airline_theme='minimalist'

" Turn on syntax highlighting
syntax on

" --INSERT-- is unncessary because of airline
set noshowmode

" Having longer updatetime (4sec) leads to delays
set updatetime=50

" faster timeout for escape sequence
set timeout ttimeout  " separate mapping and keycode timeouts
set timeoutlen=500  " mapping timeout
set ttimeoutlen=20  " keycode timeout

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Always show the status line at the bottom
set laststatus=2

" Show file stats
set ruler

" Smart indenting
set smartindent

" Auto indent
set autoindent

" show lines above and below the cursor
set scrolloff=5

" Show column 80 char
set colorcolumn=80
highlight ColorColumn ctermbg=236

" Encoding
set encoding=utf-8

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
set whichwrap+=<,>,h,l

" Enable filetype plugins
filetype plugin on
filetype indent on

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Disable audible bell because it's annoying
set noerrorbells visualbell t_vb=

" Enable mouse support
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '.git$\|models$\|data$\|__pycache__$\|node_modules$\|DS_Store$',
  \ 'file': '\v\.(png|jpg|jpeg|gif|pdf)'
  \ }

let g:ctrlp_use_caching=0
let g:ctrlp_show_hidden=1

" Custom leader key to space key
let mapleader=" "

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" NERD commenting add space after comment symbol
let g:NERDSpaceDelims=1

" Markdown syntax config
set conceallevel=2

let g:indentLine_setConceal=2
let g:indentLine_concealcursor=""

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

" Coc GoTo Code navigation (copied from GitHub)
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" toggle relative numbering
nnoremap <C-x> :set rnu!<CR>

autocmd filetype cpp nnoremap <Leader>r :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

autocmd filetype c nnoremap <Leader>r :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

autocmd filetype python nnoremap <Leader>r :w <bar> exec '!python '.shellescape('%')<CR>

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Helper function to show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

autocmd BufWritePre * :call TrimWhitespace()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Open explorer
nmap <Leader>k :NERDTreeToggle<CR>

" fuzzy search shortcut
nnoremap <Leader>; :CtrlP<CR>

" Show Undo Tree
nnoremap <leader>u :UndotreeToggle<CR>

" Show Git diff
nmap <silent> <Leader>GD :Gdiff<CR>

" Git commit
nnoremap <Leader>gc :Gcommit<CR>

" Show Git status
nmap <Leader>gs :G<CR>

" CocSearch
nnoremap <Leader>S :CocSearch<space>

" Better indenting
vnoremap < <gv
vnoremap > >gv
