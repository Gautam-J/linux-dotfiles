" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/goyo.vim'

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
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:NERDSpaceDelims=1
let g:python3_host_prog='/home/gautam/miniconda3/bin/python3'
let mapleader=" "
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_banner=0

set nocompatible
set t_Co=256
set termguicolors
set hidden
set nowrap
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
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set nohlsearch
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
set signcolumn=yes
set cmdheight=1
set shortmess+=c
set conceallevel=0
set concealcursor=""
set path+=**
set wildmode=longest,list,full
set wildmenu
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=**/.ipynb_checkpoints/*
set wildignore+=**/__pycache__/*

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '^screen'
    set ttymouse=xterm2
endif

lua require 'plug-colorizer'

nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>c "_c
vnoremap <leader>c "_c

vnoremap <leader>p "_dP

nnoremap <C-x> :set rnu!<CR>
vnoremap < <gv
vnoremap > >gv

nnoremap <leader>u :UndotreeToggle<CR>
nmap <Leader>k :Lex <bar> :vertical resize 30<CR>

nmap <silent> <Leader>GD :Gdiff<CR>
nmap <Leader>gs :G<CR>
nnoremap <Leader>gc :Git commit<CR>

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Leader>rp :resize 100<CR>

nnoremap <Leader>s :Goyo<CR>

" nnoremap <Leader>S :CocSearch<space>

" nnoremap <Leader>; :CtrlP<CR>
" nmap <silent> <Leader>gd <Plug>(coc-definition)
" nmap <silent> <Leader>gy <Plug>(coc-type-definition)
" nmap <silent> <Leader>gi <Plug>(coc-implementation)
" nmap <silent> <Leader>gr <Plug>(coc-references)

autocmd filetype cpp nnoremap <Leader>r :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <Leader>r :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype python nnoremap <Leader>r :w <bar> exec '!python '.shellescape('%')<CR>
autocmd BufWritePre * :call TrimWhitespace()

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
" if has('nvim')
  " inoremap <silent><expr> <c-space> coc#refresh()
" else
  " inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Helper function to show documentation
" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " else
    " call CocAction('doHover')
  " endif
" endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
