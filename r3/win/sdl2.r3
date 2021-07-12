
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

::SDL_Init sys-SDL_Init sys1 ;
::SDL_Quit sys-SDL_Quit sys0 ;
::SDL_GetNumVideoDisplays sys-SDL_GetNumVideoDisplays sys0 ;
::SDL_CreateWindow sys-SDL_CreateWindow sys6 ;
::SDL_GetWindowSurface sys-SDL_GetWindowSurface sys1 ;
::SDL_ShowCursor sys-SDL_ShowCursor sys1 ;
::SDL_UpdateWindowSurface sys-SDL_UpdateWindowSurface sys1 ;
::SDL_DestroyWindow sys-SDL_DestroyWindow sys1 ;
::SDL_CreateRenderer sys-SDL_CreateRenderer sys3 ;
::SDL_CreateTexture sys-SDL_CreateTexture sys5 ;
::SDL_DestroyTexture sys-SDL_DestroyTexture sys1 ;
::SDL_DestroyRenderer sys-SDL_DestroyRenderer sys1 ;
::SDL_UpdateTexture sys-SDL_UpdateTexture sys4 ;
::SDL_RenderCopy sys-SDL_RenderCopy sys4 ;
::SDL_RenderPresent sys-SDL_RenderPresent sys1 ;

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
	drop
	;