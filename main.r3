^r3/sys.r3
^r3/lib/str.r3
	
|--------------------------------------
:cls | color --
	gr_buffer >a sizebuffer ( 1? over a!+ 1 - ) 2drop ;
	
#buffer * 256

:input
	'buffer
	( key 13 <>? swap c!+ ) drop
	0 swap c! ;
	
:tt	
	100 ( 1? 1 -
		50 ms
		key? . ) drop ;
		
:main
	windows
	"1;1H" .[ | home
	"2J" .[  | cls
	"r3init" 6 type
	cr
	input
	cr
	sdl2
	"r3sdl" 640 480 SDLinit

	$ff0000 cls SDLupdate
	1000 ms	
	$ff00 cls SDLupdate
	1000 ms
	$ff cls SDLupdate
	1000 ms

	SDLquit
	;

: main ;
