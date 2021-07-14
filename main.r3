^r3/sys.r3
^r3/lib/str.r3
	
|--------------------------------------
:type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;
:ms | ms --
	Sleep ;

:cls | color --
	gr_buffer >a sizebuffer ( 1? over a!+ 1 - ) 2drop ;
	
	
:test
	|$ffffff SDL_screen 28 + @ d! ;
	
:main
	windows
	"r3init" 6 type
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
