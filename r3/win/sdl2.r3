
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
	
#SDL_windows
#SDL_screen

|typedef struct SDL_Surface {
|    Uint32 flags;               /**< Read-only */
|    SDL_PixelFormat *format;    /**< Read-only */
|    int w, h;                   /**< Read-only */
|    int pitch;                  /**< Read-only */
|    void *pixels;               /**< Read-write */
|    /** Application data associated with the surface */
|    void *userdata;             /**< Read-write */
|    /** information needed for surfaces requiring locks */
|    int locked;                 /**< Read-only */
|    void *lock_data;            /**< Read-only */
|    /** clipping information */
|    SDL_Rect clip_rect;         /**< Read-only */
|    /** info for fast blit mapping to other surfaces */
|    struct SDL_BlitMap *map;    /**< Private */
|    /** Reference count -- used when freeing surface */
|    int refcount;               /**< Read-mostly */
|} SDL_Surface;

##screenw
##screenh
##gr_buffer

::SDLinit | w h --
	'screenh ! 'screenw !
	$3231 SDL_init drop
	"r3sdl" $1FFF0000 $1FFF0000 screenw screenh 0 SDL_CreateWindow 'SDL_windows !
	SDL_windows SDL_GetWindowSurface 'SDL_screen !
	
| window=SDL_CreateWindow(title,SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,XRES,YRES,0);
|	if (!window) return -1;
|	if (f==1) SDL_SetWindowFullscreen(window,SDL_WINDOW_FULLSCREEN);
|	screen = SDL_GetWindowSurface(window);	

	0 SDL_ShowCursor drop | disable cursor
	SDL_screen @ 20 + d@ 'gr_buffer ! 
	;
	
::SDLquit
	SDL_windows SDL_DestroyWindow drop 
	SDL_Quit drop ;
	
::SDLupdate	
	SDL_windows SDL_UpdateWindowSurface drop ;
	