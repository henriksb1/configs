syntax on
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
