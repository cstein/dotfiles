if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	autocmd BufNewFile,BufRead *.src set ft=gmssrc 
	autocmd BufNewFile,BufRead *.code set filetype=fortran
	autocmd BufNewFile,BufRead *.inp set filetype=inp2
	autocmd BufNewFile,BufRead *.dat set filetype=inp2
	autocmd BufNewFile,BufRead *.irc set filetype=inp2
	autocmd BufNewFile,BufRead *.trj set filetype=inp2
	autocmd BufNewFile,BufRead *.efp set filetype=inp2
	autocmd BufNewFile,BufRead Makefile.inc set filetype=make
	autocmd BufNewFile,BufRead *.pml set filetype=python
	autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

