^r3/sys.r3
^r3/lib/sys.r3	

|--------------------------------------
:cls | color --
	vframe >a sizebuffer ( 1? over a!+ 1 - ) 2drop ;
	
:xy>v screenw * + 2 << vframe + ;	
#buffer * 256

:input
	'buffer
	( key 13 <>? swap c!+ ) drop
	0 swap c! ;
	
:tt	
	$ffffff SDLx SDLy xy>v d!
	SDLkey
	>esc< =? ( exit )
	drop
	;
		
:test
	'tt onshow ;
	
:main
	windows
|	"1;1H" .[ | home
|	"2J" .[  | cls
	"r3init" .
	cr
	input
	cr
	sdl2
	"r3sdl" 640 480 SDLinit

	test
	|$ff0000 cls SDLredraw 1000 ms	
	|$ff00 cls SDLredraw 1000 ms
	|$ff cls SDLredraw 1000 ms

	SDLquit
	;

: main ;
