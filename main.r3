| sdl2 test program
| PHREDA 2021
^r3/win/console.r3

#pad * 256

:.input
	'pad
	( key 13 <>? swap c!+ ) drop
	0 swap c! ;

#.bye 0

:ibye 1 '.bye ! "bye!" .print cr ;
	
#inst "bye" 0
#insc 'ibye 0

:interp | adr -- ex/0
	'pad trim 
	'insc >a
	'inst ( dup c@ 1? drop
		2dup = 1? ( 3drop a> ; ) drop
		>>0 8 a+ ) nip nip ;
	
:interprete
	interp 0? ( drop ; )
	ex ;
	
:main
	"r3 console - PHREDA 2021" .print cr
	( .bye 0? drop
		cr "r3> " .print 
		.input cr
		interprete
		) drop ;

: 
windows
main ;
