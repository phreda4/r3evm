
|--------------------------------------SDL
#sys-SDL_Init 
#sys-SDL_Quit 
#sys-SDL_GetNumVideoDisplays 
#sys-SDL_CreateWindow 
#sys-SDL_GetWindowSurface 
#sys-SDL_ShowCursor 
#sys-SDL_UpdateWindowSurface 
#sys-SDL_DestroyWindow 
#sys-SDL_CreateRenderer 
#sys-SDL_CreateTexture 
#sys-SDL_DestroyTexture 
#sys-SDL_DestroyRenderer 
#sys-SDL_UpdateTexture 
#sys-SDL_RenderCopy 
#sys-SDL_RenderPresent 

::SDL_Init sys-SDL_Init sys1 drop ;
::SDL_Quit sys-SDL_Quit sys0 drop ;
::SDL_GetNumVideoDisplays sys-SDL_GetNumVideoDisplays sys0 ;
::SDL_CreateWindow sys-SDL_CreateWindow sys6 ;
::SDL_GetWindowSurface sys-SDL_GetWindowSurface sys1 ;
::SDL_ShowCursor sys-SDL_ShowCursor sys1 drop ;
::SDL_UpdateWindowSurface sys-SDL_UpdateWindowSurface sys1 drop ;
::SDL_DestroyWindow sys-SDL_DestroyWindow sys1 drop ;
::SDL_CreateRenderer sys-SDL_CreateRenderer sys3 ;
::SDL_CreateTexture sys-SDL_CreateTexture sys5 ;
::SDL_DestroyTexture sys-SDL_DestroyTexture sys1 ;
::SDL_DestroyRenderer sys-SDL_DestroyRenderer sys1 ;
::SDL_UpdateTexture sys-SDL_UpdateTexture sys4 ;
::SDL_RenderCopy sys-SDL_RenderCopy sys4 ;
::SDL_RenderPresent sys-SDL_RenderPresent sys1 ;

#sys-SDL_Delay
::SDL_Delay | dl --
	sys-SDL_Delay sys1 drop ;
	
#sys-SDL_PollEvent	
::SDL_PollEvent | &evt -- ok
	sys-SDL_PollEvent sys1 ;

#sys-SDL_GetTicks
::SDL_GetTicks | -- msec
	sys-SDL_GetTicks sys0 ;
	
#sys-SDL_StartTextInput	
::SDL_StartTextInput
	sys-SDL_StartTextInput sys0 drop ;
	
#sys-SDL_StopTextInput
::SDL_StopTextInput
	sys-SDL_StopTextInput sys0 drop ;
	
::sdl2
	"SDL2.DLL" loadlib
	dup "SDL_Init" getproc 'sys-SDL_Init !
	dup "SDL_Quit" getproc 'sys-SDL_Quit !
	dup "SDL_GetNumVideoDisplays" getproc 'sys-SDL_GetNumVideoDisplays !
	dup "SDL_CreateWindow" getproc 'sys-SDL_CreateWindow !
	dup "SDL_GetWindowSurface" getproc 'sys-SDL_GetWindowSurface !
	dup "SDL_ShowCursor" getproc 'sys-SDL_ShowCursor !
	dup "SDL_UpdateWindowSurface" getproc 'sys-SDL_UpdateWindowSurface !
	dup "SDL_DestroyWindow" getproc 'sys-SDL_DestroyWindow !
	dup "SDL_CreateRenderer" getproc 'sys-SDL_CreateRenderer !
	dup "SDL_CreateTexture" getproc 'sys-SDL_CreateTexture !
	dup "SDL_DestroyTexture" getproc 'sys-SDL_DestroyTexture !
	dup "SDL_DestroyRenderer" getproc 'sys-SDL_DestroyRenderer !
	dup "SDL_UpdateTexture" getproc 'sys-SDL_UpdateTexture !
	dup "SDL_RenderCopy" getproc 'sys-SDL_RenderCopy !
	dup "SDL_RenderPresent" getproc 'sys-SDL_RenderPresent !
	
	"SDL_Delay" getproc 'sys-SDL_Delay !
	"SDL_PollEvent" getproc 'sys-SDL_PollEvent !
	"SDL_GetTicks" getproc 'sys-SDL_GetTicks !
	drop
	;

##SDLevent * 56 
	
##SDL_windows
##SDL_screen

|struct SDL_Surface
|        flags           dd ? +0
|                        dd ? +4
|       ?format          dq ? +8
|        w               dd ? +16
|        h               dd ? +20
|        pitch           dd ? +24
|                        dd ? +28
|        pixels          dq ? +32
|        userdata        dq ?
|        locked          dd ?
|                        dd ?
|        lock_data       dq ?
|        clip_rect       SDL_Rect
|        map             dq ?
|        refcount        dd ?
|                        dd ?
|ends

##screenw
##screenh
##pitch
##sizebuffer
##gr_buffer

::SDLinit | "titulo" w h --
	2dup * 'sizebuffer !
	'screenh ! 'screenw !
	$3231 SDL_init 
	$1FFF0000 $1FFF0000 screenw screenh 0 SDL_CreateWindow dup 'SDL_windows !
	SDL_GetWindowSurface dup 'SDL_screen !
	24 + d@+ 'pitch !
	4 + @ 'gr_buffer ! 

	0 SDL_ShowCursor | disable cursor
	;
	
::SDLquit
	SDL_windows SDL_DestroyWindow 
	SDL_Quit ;
	
::SDLupdate	
	SDL_windows SDL_UpdateWindowSurface ;
	