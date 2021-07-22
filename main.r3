| sdl2 test program
| PHREDA 2021

^r3/win/sdl2.r3	
^r3/win/sdl2image.r3	
|^r3/win/glew.r3
^r3/lib/sys.r3
^r3/lib/gr.r3

#SDLrenderer
#texture
#textbit

#GL_context

:xypen SDLx SDLy ;

#desrec [ 0 100 200 200 ]
#desrec2 [ 10 100 100 100 ]
#desrec3 [ 200 150 427 240 ]

#srct [ 0 0 427 240 ]
#mpixel 
#mpitch

#vx 0

##seed 495090497

::rand | -- r32
  seed 3141592621 * 1 + dup 'seed ! ;

:updatetexbit
	textbit 'srct 'mpixel 'mpitch SDL_LockTexture
	mpixel >a 427 240 * ( 1? 1 - rand da!+ ) drop
	textbit SDL_UnlockTexture
	;
	
:drawl

	updatetexbit
	
	SDLrenderer SDL_RenderClear
	SDLrenderer textbit 0 'desrec3 SDL_RenderCopy		
	SDLrenderer texture 0 'desrec SDL_RenderCopy
	SDLrenderer texture 0 'desrec2 SDL_RenderCopy
	SDLrenderer SDL_RenderPresent

	vx 'desrec3 d+!
	
	SDLkey
	>esc< =? ( exit )
	<le> =? ( 1 'vx ! )
	<ri> =? ( -1 'vx ! )	
	
	drop ;
		
:draw
	'drawl onshow ;

#surface

:inicio
	windows
	sdl2
	sdl2image
|	glew
	mark ;
	
:main
 
	"r3sdl" 640 480 SDLinit
		|SDLinitGL
		
	SDL_windows -1 0 SDL_CreateRenderer 'SDLrenderer !
	SDL_windows SDL_GL_CreateContext 'GL_context !
	
	SDLrenderer $0 $0 $0 $ff SDL_SetRenderDrawColor
	$3 IMG_Init

	"media/img/lolomario.png" IMG_Load 'surface !
	SDLrenderer surface SDL_CreateTextureFromSurface 'texture !
	surface SDL_FreeSurface

	SDLrenderer $16362004 1 427 240 SDL_CreateTexture 'textbit !
	
	draw
	
	SDLquit
	;

: inicio main ;
