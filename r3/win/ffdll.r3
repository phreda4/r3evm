| ffdll.dll
|

#sys-videoopen
#sys-videoclose
#sys-videoresize
#sys-redrawframe
#sys-initffmpeg

::videoopen sys-videoopen sys3 drop ;
::videoclose sys-videoclose sys0 drop ;	
::videoresize sys-videoresize sys2 drop ;
::redrawframe sys-redrawframe sys2 ;
::initffmpeg sys-initffmpeg sys2 drop ;

::ffdll
	"ffdll.DLL" loadlib
	dup "videoopen" getproc 'sys-videoopen !
	dup "videoclose" getproc 'sys-videoclose ! 
	dup "videoresize" getproc 'sys-videoresize !
	dup "redrawframe" getproc 'sys-redrawframe !
	dup "initffmpeg" getproc 'sys-initffmpeg !
	drop
	;
	
|DLLIMPORT extern int mix_movie_channel;

