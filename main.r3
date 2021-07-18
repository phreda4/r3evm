^r3/sys.r3
^r3/lib/sys.r3	
^r3/win/console.r3	
^r3/lib/gr.r3

|--------------------------------------

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

	"r3init" .
	cr
	input
	cr
	>esc< .h . " " .
	sdl2
	"r3sdl" 640 480 SDLinit

	test
	$ff0000 'paper ! cls SDLredraw 1000 ms	
	$ff00 'paper ! cls SDLredraw 1000 ms
	$ff 'paper ! cls SDLredraw 1000 ms

	SDLquit
	;

: main ;
