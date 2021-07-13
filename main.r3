^r3/sys.r3
	
|--------------------------------------
:type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;
:ms | ms --
	Sleep ;

:cls | color --
	gr_buffer >a 100 ( 1? over a!+ 1 - ) 2drop
	SDLupdate ;
	
:main
	windows
	sdl2

	"hola" 4 type
	640 480 SDLinit
	SDLupdate
	
	$ff0000 cls 1000 ms
	$ff00 cls	1000 ms
	$ff cls 
	1000 ms
	
	SDLquit
	;

: main ;
