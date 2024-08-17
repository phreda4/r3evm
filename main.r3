|^r3/win/console.r3


#pos 0 0
	
:pxy! | x y 'p --
	rot over 1 + d! 9 + d! ;
	
:test1
	
	3 2 'pos pxy!
	'pos d@+ |"%d " .println
	swap @ |"%d " .println
	
|	.input
	;
	
: 
test1
;