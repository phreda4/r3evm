
^r3/win/console.r3

#consoleBuffer * $ffff
#conw 10

#var $f500
#list 1 2 33 4 5
#nl 2
		
:inline 
	2 + ;
	
:cntff
	3 2 + 4 * 1 << 3 / neg
	;
	
:test1
	$ef
	|var 48 << 56 >>
	'list nl 3 << + @ drop
	$5a 'list nl 3 << + !
	'list nl 3 << + @ drop
	cntff 
	$100 'list 16 + ! 
	'list 8 + @
	inline
	;
	
	
##seed $a3b195354a39b70d

::rand | -- rand 
  seed $da942042e4dd58b5 * 1 + dup 'seed ! ;

::randmax | max -- rand ; 0..max
	rand 
	dup "%d" .println
	1 >>> 
	dup "%d" .println
	over "%d" .println
	63 *>> 
	dup "%d" .println
	; | only positive
	
:putpixel
	1 1
	conw * + 2 << 'consoleBuffer +
	$ff randmax 16 << | color
	pick2 $30 + or | char
	swap d!
	;	
		
:test1
	$ff randmax 16 << "%f" .println
	10 2 1 *>> "%d" .println
	.input
	;
	
: 
"test1" .println
test1
;
