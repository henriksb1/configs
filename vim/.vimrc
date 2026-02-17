syntax on

" Line numbers
set number
set relativenumber

" Allow mouse
set mouse=a

" Highlight current line
set cursorline

" Better search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Smarter indentation
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4

" Auto reload if changed externally
set autoread

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" System clipboard
set clipboard=unnamedplus

" Split like you should have
set splitbelow
set splitright

" Don't reach for ESC
inoremap jk <Esc>

" Improve scrolling
set scrolloff=5
set sidescrolloff=5
set signcolumn=yes

" Add trailing newline
set fixeol

" Load gruvbox from /vim/colors
set background=dark
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on

" Start cursor at end of first line for commit messages (after ticket prefix)
augroup GitCommitCursor
  autocmd!
  autocmd FileType gitcommit call cursor(1, col('$')) | startinsert
augroup END

" Show invisible characters
set list
set listchars=space:·,tab:»·

" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
