" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'romainl/vim-cool'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'yggdroot/indentLine'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', {'do': 'npm install'}

" Initialize plugin system
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

colorscheme gruvbox
syntax on
highlight ColorColumn ctermbg=236
filetype plugin on
filetype indent on

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:airline_theme='minimalist'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '.git$\|models$\|data$\|__pycache__$\|node_modules$\|DS_Store$',
  \ 'file': '\v\.(png|jpg|jpeg|gif|pdf)'
  \ }
let g:ctrlp_use_caching=0
let g:ctrlp_show_hidden=1
let g:NERDSpaceDelims=1
let g:indentLine_setConceal=2
let g:indentLine_concealcursor=""

let mapleader=" "
let NERDTreeShowHidden=1

set nocompatible
set t_Co=256
set notermguicolors
set clipboard+=unnamedplus
set noshowmode
set updatetime=50
set timeout ttimeout  " separate mapping and keycode timeouts
set timeoutlen=500  " mapping timeout
set ttimeoutlen=20  " keycode timeout
set number
set relativenumber
set laststatus=2
set ruler
set smartindent
set autoindent
set scrolloff=5
set colorcolumn=80
set encoding=utf-8
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set showmatch
set noerrorbells visualbell t_vb=
set mouse+=a
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set splitbelow
set splitright
set conceallevel=2
set bg=dark

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '^screen'
    set ttymouse=xterm2
endif

nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <Leader>; :CtrlP<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>S :CocSearch<space>
nnoremap <C-x> :set rnu!<CR>

vnoremap < <gv
vnoremap > >gv

nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
nmap <Leader>k :NERDTreeToggle<CR>
nmap <silent> <Leader>GD :Gdiff<CR>
nmap <Leader>gs :G<CR>

autocmd filetype cpp nnoremap <Leader>r :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <Leader>r :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype python nnoremap <Leader>r :w <bar> exec '!python '.shellescape('%')<CR>
autocmd BufWritePre * :call TrimWhitespace()

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
