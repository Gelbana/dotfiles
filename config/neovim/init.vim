let mapleader=" "
nnoremap <SPACE> <Nop>

nnoremap <leader>fs :update<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>/ :Files .<CR>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

nnoremap <leader>ce :e $MYVIMRC<CR>
nnoremap <leader>cr :source $MYVIMRC<CR>

set number
set autoindent
set shiftround
set shiftwidth=4
set smarttab
set hlsearch
set ignorecase
set smartcase
set ruler
set mouse=a
syntax on

set hidden
set backspace=indent,eol,start
set updatetime=100
set undofile

set termguicolors
packadd! dracula-vim
set background=dark
colorscheme dracula

lua << EOF
require'lspconfig'.rnix.setup{}
EOF

