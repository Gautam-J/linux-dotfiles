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
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'airblade/vim-gitgutter'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/goyo.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

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

let mapleader=" "
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='gruvbox'
let g:python3_host_prog='/home/gautam/miniconda3/bin/python3'
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
set wildignore+=*.pyc
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=**/.ipynb_checkpoints/*
set wildignore+=**/__pycache__/*
set completeopt=menu,menuone,noselect

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '^screen'
    set ttymouse=xterm2
endif

lua require 'plug-colorizer'
lua require 'nvim-treesitter.configs'.setup{ highlight = { enable = true } }

lua <<EOF
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local servers = {
    'pyls',
    'vimls',
    'bashls',
    'clangd',
    'cssls',
    'html',
    'tsserver',
    'tailwindcss',
    'jsonls'
  }

  for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup{ capabilities=capabilities }
  end

require('telescope').setup{
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' > ',
        color_devicons = true,
        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        }
    }
}

require('telescope').load_extension('fzy_native')
EOF

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>vca <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files({ hidden = true })<CR>
nnoremap <leader>ps :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })<CR><CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

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

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-x> :set rnu!<CR>
vnoremap < <gv
vnoremap > >gv

nnoremap <leader>u :UndotreeToggle<CR>
nmap <Leader>k :Lex <bar> :vertical resize 30<CR>

nmap <silent> <Leader>gd :Gdiff<CR>
nmap <Leader>gs :G<CR>
nnoremap <Leader>gc :Git commit<CR>

nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Leader>rp :resize 100<CR>

nnoremap <Leader>s :Goyo<CR>

nnoremap <silent> Q <nop>

autocmd filetype cpp nnoremap <Leader>c :w <CR> :!nfn=$(echo % \| sed "s/src\///g" \| sed "s/.cpp//g") && g++ -std=c++17 -fsanitize=address -fsanitize=undefined -Wall -Wshadow -Wno-unused-result -D_GLIBCXX_DEBUG -O2 % -o ./bin/${nfn}<CR>
autocmd filetype cpp nnoremap <Leader>r :w <CR> :!nfn=$(echo % \| sed "s/src\///g" \| sed "s/.cpp//g") && ./bin/${nfn} < testCases<CR>
autocmd filetype c nnoremap <Leader>r :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype python nnoremap <Leader>r :w <bar> exec '!python '.shellescape('%')<CR>

autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype css setlocal tabstop=2 shiftwidth=2 softtabstop=2

autocmd BufWritePre * :call TrimWhitespace()
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> "\<C-n>"
else
  inoremap <silent><expr> <c-@> "\<C-n>"
endif

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction
