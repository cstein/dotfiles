" Vim syntax file
" Language:	GAMESS Input file
" Maintainer:	Albert DeFusco
" URL:		
" Last Change:	
"
" This syntax highlighter can be used for the following files
"   inp  GAMESS Input file
"   dat  GAMESS Punch file
"   irc  GAMESS Optimization trajectory
"   efp  GAMESS Effective Fragment definitions
"   trj  GAMESS Molecular Dynamics trajectory
"
" INSTALL
"Place this file in $HOME/.vim/syntax
"You can add the following line to your $HOME/.vim/filetype.vim or
"$HOME/.vimrc files
"  autocmd BufNewFile,BufRead *.inp,*.dat,*.irc,*.trj,*.efp set filetype=inp

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

set expandtab

"For highly accurate highlighting (slower) set inp_accurate=1
"I would generally argue that input files are small enough to allow this.
"syn sync fromstart
syn sync minlines=200
syn sync match inpSync "\$end"  

"I'm usually too lazy to write my input in ALLCAPS
syn case ignore

"The main philosophy is as follows
"  1. Anything not inside a $group is comment
"  2. A $group starting at column 1 is an error
syn match inpComment "."
syn match inpError "^\$[a-z0-9]\+" 
syn match inpError "\t"
"syn match inpKeyEr "[a-z0-9]\+ " contains=ALLBUT,contrl
"GAMESS will not read past column number 80
"Does this apply to comments as well?
syn match inpError excludenl "^.\{81,}$"lc=80 contained 

"Anyhting after here will be highlighted only when they are explicitely
"contained in a region (i.e. a $group).


setlocal iskeyword=a-z,A-Z,48-57,$
syn keyword cards $CONICL $CONTRL $SYSTEM $BASIS $DATA $DATAS $DATAL $ZMAT $LIBE $SCF $SCFMI $DFT $TDDFT $CIS $CISVEC $MP2 $CCINP $EOMINP $CCINP $MOPAC $GUESS $VEC $DM $MOFRZ $STATPT $TRUDGE $TRURST $FORCE $CPHF $MASS $HESS $GRAD $DIPDR $VIB $VIB2 $VSCF $VIBSCF $GAMMA $EQGEOM $HLOWT $GLOWT $IRC $DRC $MEX $MD $RDF $FRAGNAME $GLOBOP $GRADEX $SURF $LOCAL $TWOEI $TRUNCN $ELMOM $ELPOT $ELDENS $ELFLDG $POINTS $GRID $PDC $RADIAL $MOLGRF $STONE $RAMAN $ALPDR $NMR $MOROKM $LMOEDA $FFCALC $TDHF $TDHFX $EFRAG $FRAGNAME $FRAGNAME $FRAGNAME $FRGRPL $FRAG1 $EWALD $EFRAG $MAKEFP $PRTEFP $DAMP $DAMPGS $PCM $PCMCAV $TESCAV $NEWCAV $PCMGRD $IEFPCM $PCMITR $DISBS $DISREP $SVP $SVPIRF $COSGMS $SCRF $ECP $MCP $RELWFN $EFIELD $INTGRL $FMM $TRANS $FMO $FMOPRP $FMOXYZ $OPTFMO $FMOHYB $FMOBND $FMOENM $FMOEND $FMOEND $OPTRST $GDDI $ELG $DANDC $DCCORR $SUBSCF $SUBCOR $MP2RES $CCRES $CIINP $DET $GEN $CIDET $CIGEN $ORMAS $CEEIS $CEDATA $GCILST $GMCPT $PDET $ADDDET $REMDET $SODET $DRT $CIDRT $MCSCF $MRMP $DETPT $MCQDPT $CASCI $IVOORB $IVOORB $CISORT $GUGEM $GUGDIA $GUGDM $GUGDM2 $LAGRAN $TRFDM2 $TRANST $VEC1 $VEC2 $CIMINP $CIMFRG $CIMATM $QMEFP contained
"this is to help the special case when $end straddles the 81st column
syn match inpEnd "\$end" contained contains=inpError

syn keyword contrl SCFTYP DFTTYP TDDFT MPLEVL CITYP CCTYP RELWFN RUNTYP NUMGRD EXETYP ICHARG MULT COORD UNITS NZVAR PP LOCAL ISPHER QMTTOL MAXIT MOLPLT PLTORB AIMPAC FRIEND NFFLVL NPRINT NOSYM ETOLLZ INTTYP GRDTYP NORMF NORMP ITOL ICUT ISKPRP IREST GEOM contained
syn match ContrlKey display "\([a-z0-9]\+\)=" contained contains=contrl
syn keyword system MWORDS MEMDDI TIMLIM PARALL KDIAG COREFL BALTYP NODEXT IOSMP contained
syn match SystemKey display "\([a-z0-9]\+\)=" contained contains=system
syn keyword basis GBASIS NGAUSS GBASIS GBASIS GBASIS GBASIS NDFUNC NFFUNC NPFUNC DIFFSP DIFFS POLAR SPLIT2 SPLIT3 EXTFIL contained
syn match BasisKey display "\([a-z0-9]\+\)=" contained contains=basis
syn keyword scf DIRSCF FDIFF NOCONV DIIS SOSCF EXTRAP DAMP SHIFT RSTRCT DEM CONV SOGTOL ETHRSH MAXDII SWDIIS DEMCUT DMPCUT UHFNOS VVOS MVOQ ACAVO PACAVO NCO NSETO NO NPAIR CICOEF COUPLE F ALPHA BETA NPUNCH NPREO VTSCAL SCALF MAXVT VTCONV contained
syn match ScfKey display "\([a-z0-9]\+\)=" contained contains=scf

"syn match cards "^\s\$*" contains=cards

"= is used to match keywords but is not itself highlighted
syn match inpOperator "[=]" contained
"spaces are not allowed in Kewords
syn match inpKeyword display "=\s*\([a-z0-9+-.]\+\)" contained contains=inpOperator,inpNumber,inpBoolean
syn match inpKeyword display "," contained contains=inpOperator,inpNumber,inpBoolean
"Numbers of various sorts (copied from other syntaxes)
" Integers
syn match inpNumber	display "\<\d\+\(_\a\w*\)\=\>" contained
" floating point number, without a decimal point
syn match inpNumber	display	"\<\d\+[deq][-+]\=\d\+\(_\a\w*\)\=\>" contained
" floating point number, starting with a decimal point
syn match inpNumber	display	"\.\d\+\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>" contained
" floating point number, no digits after decimal
syn match inpNumber	display	"\<\d\+\.\([deq][-+]\=\d\+\)\=\(_\a\w*\)\=\>" contained
" floating point number, D or Q exponents
syn match inpNumber	display	"\<\d\+\.\d\+\([dq][-+]\=\d\+\)\=\(_\a\w*\)\=\>" contained
" floating point number
syn match inpNumber	display	"\<\d\+\.\d\+\(e[-+]\=\d\+\)\=\(_\a\w*\)\=\>" contained
" Numbers in formats
syn match inpNumber	display	"\d*f\d\+\.\d\+" contained
syn match inpNumber	display	"\d*e[sn]\=\d\+\.\d\+\(e\d+\>\)\=" contained
syn match inpNumber	display	"\d*\(d\|q\|g\)\d\+\.\d\+\(e\d+\)\=" contained
syn match inpNumber	display	"\d\+x\>" contained
"logicals
syn match inpBoolean "\.\(true\|false\|t\|f\)\." contained


"This applies to $data, $efrag, and $grad
syn match inpAtomCart "^[ -a-z0-9]\{1,10\}\s\+-\?\([0-9]\|\.\).*" contains=inpNumber contained
"Fragment gradients are special
syn match inpFragGrad "^FRAG\(\s[0-9]\|[0-9]\{2\}\|\*\*\).*" contains=inpNumber contained
"These are all the symmetry point groups allowed in $data
syn match inpSym "^c\(1\|s\|i\)" contained
syn match inpSym "^c\(nh\|nv\|n\)\s\+[0-9]" contains=inpNumber contained
syn match inpSym "^d\(nh\|nd\|n\)\s\+[0-9]" contains=inpNumber contained
syn match inpSym "^s2n\s\+[0-9]" contains=inpNumber contained
syn match inpSym "^\(t\|th\|td\|o?!\(\s*[0-9]\)\|oh\)" contains=inpNumber contained

"These occur in the $MD group written to a .trj file
syn region inpLineComment start="[!]" end="$" oneline contained
syn region inpLineComment start="^----" end="$" oneline contained
syn match inpFragNum "^fragname=.\+\s\+\#\s*[0-9]*" contains=inpNumber,inpKeyword contained 

"A $fragname has many regions terminated by STOP
"They only appear in a $fragname defined below (the generic output of makeefp)
syn region inpFragnameCard start="\(coordinates\|monopoles\|dipoles\|quadrupoles\|octupoles\|polarizable\spoints\|lmo\scentroids\|fock\smatrix\selements\|projection\swavefunction\|multiplicity\|projection\sbasis\sset\|screen[1-3]*\|polscr\|repulsive\spotential\|dynamic\spolarizable\spoints\|canonvec\|canonfock\)" end="stop" contained keepend contains=inpAtomCart,inpNumber

"Now to the containers of highlighting.

"The general input $group
"There may be other types of comments I am not aware of
syn match inpDeck "\(^\s\$[a-z0-9]\+\|\$end\)" transparent contained contains=cards,inpError,inpEnd
syn region inpDeckGroup start="^\s\$[a-z0-9]\+" end="\$end" display keepend contains=inpError,inpDeck,inpKeyword,inpLineComment,inpNumber,inpBoolean

"syn region ContrlDeck start="^\s\$contrl " end="\$end" display keepend contains=inpDeck,inpLineComment,inpNumber,ContrlKey,inpBoolean,inpError
"syn region SystemDeck start="^\s\$system " end="\$end" display keepend contains=inpDeck,inpLineComment,inpNumber,SystemKey,inpBoolean,inpError
"syn region BasisDeck start="^\s\$basis " end="\$end" display keepend contains=inpDeck,inpLineComment,inpNumber,BasisKey,inpBoolean,inpError
"syn region ScfDeck start="^\s\$scf " end="\$end" display keepend contains=inpDeck,inpLineComment,inpNumber,ScfKey,inpBoolean,inpError

"$data,grad,efrag are a special type of group
syn region inpData start="^\s\$data" end="\$end" transparent keepend contains=inpDeck,inpAtomCart,inpSym,inpError
syn region inpGrad start="^\s\$grad" end="\$end" transparent keepend contains=inpDeck,inpAtomCart,inpError,inpKeyword,inpFragGrad
syn region inpEfrag start="^\s\$efrag" end="\$end" transparent keepend contains=inpError,inpDeck,inpKeyword,inpFragNum,inpAtomCart,inpLineComment

"MD runs produce a .trj file (also highlighted by this file)
"Saved timesteps are contained in a MD DATA PACKET followed by $md group
syn match inpMDData "^===== MD DATA PACKET =====" contained
syn region inpTRJ start="^===== MD DATA PACKET =====" end="^----- RESTART" extend transparent keepend contains=inpKeyword,inpMDData,inpAtomCart,inpEfragCart,inpFragNum,inpLineComment

syn region inpFragname start="^\s\$[a-z0-9]\+.*\n.*\n\s*coordinates" end="\$end" transparent keepend contains=inpFragnameCard,inpDeck,inpError

"These next $groups are usually very large and folding is quite helpful
"set foldmethod=syntax to use
syn region inpFragname start="^\s\$[a-z0-9]\+.*\n.*\n\s*coordinates" end="\$end" transparent keepend fold extend
syn region inpCedata start="^\s\$cedata" end="\$end" extend fold transparent keepend
syn region inpVec start="^\s\$vec" end="\$end" extend fold transparent keepend
"The $MD as written in a .trj file
syn region inpMD start="^\s\$md.\+\ntvelqm(1)=" end="\$end" extend fold transparent keepend 
"This is a very slow way to fold a $vec
"  Once the file is open, you can do /$vec<cr>zf/end


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_inp_syn_inits")
	if version < 508
		let did_inp_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink inpComment	Comment
	HiLink inpLineComment	Comment
	HiLink inpMDData	Type
	HiLink inpError		Error
	HiLink inpKeyword	Keyword
	HiLink inpFragnameCard	Keyword
	HiLink inpSym		Keyword
	HiLink inpNumber	Number
	HiLink inpBoolean	Function
	HiLink inpAtomCart	Identifier
	HiLink inpFragGrad	Identifier

	HiLink inpDeck		Type
	HiLink inpEnd           Type
	HiLink cards		Type
	"HiLink inpEnd		Type
	"HiLink contrl           Keyword
	"HiLink system           Keyword
	"HiLink basis		Keyword
	"HiLink scf		Keyword

	delcommand HiLink
endif

" Input abbreviations
iab MOguess $GUESS GUESS=MOREAD NORB= PRTMO=.F. PURIFY=.T. $END<ESC>11b

"Folding commands
nmap <F4> /^ \$VEC<cr>zf/END<cr>
nmap <F5> /^ \$CEDATA<cr>zf/END<cr>
nmap <F6> /^ \$MD<cr>zf/END<cr>

let b:current_syntax = "inp2"
"set tw=80

