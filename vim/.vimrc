syntax on
  
" Wrap gitcommit file types at the appropriate length
filetype indent plugin on

" Start cursor at end of first line for commit messages (after ticket prefix)
autocmd FileType gitcommit call cursor(1, col('$'))
