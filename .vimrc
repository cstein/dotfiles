au BufNewFile,BufRead *.src set filetype=fortran

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set background=dark
colors peaksea
syntax on

setlocal spell spelllang=en_us
set nospell
