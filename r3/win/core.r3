^r3/lib/str.r3
	
#kb 0

::key | -- key
	stdin 'kb 1 0 0 ReadFile drop kb ;
	
::key? | -- f 
	stdin 0 WaitForSingleObject  ;

::ms | ms --
	Sleep ;
	
::allocate |( n -- a ior ) 
	process-heap 0 rot HeapAlloc ;
	
::free |( a -- ior ) 
	process-heap 0 rot HeapFree ;
	
::resize |( a n -- a ior ) 
	process-heap rot rot 0 rot HeapReAlloc ;
	
::type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;
	
#crb ( 10 13 0 0 )
#esc[ ( $1b $5b 0 0 0 0 0 0 0 0 0 0 )

::cr 'crb 2 type ;
	
::.[ 'esc[ 2 + swap
	( c@+ 1? rot c!+ swap ) 2drop
	'esc[ swap over - type ;
	
::. count type ;
	