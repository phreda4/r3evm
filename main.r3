^r3/sys.r3
	
|--------------------------------------
:type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;
:ms | ms --
	Sleep ;

:main
	windows
	sdl2

	"hola" 4 type
	2000 ms
	;

: main ;
