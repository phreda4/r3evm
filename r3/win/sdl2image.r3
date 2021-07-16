| SDL2_image.dll
|

#sys-IMG_Load

::IMG_Load sys-IMG_Load sys1 ;
	
	
::sdl2image
	"SDL2_image.DLL" loadlib
	dup "IMG_Load" getproc 'sys-IMG_Load !
	drop
	;

