| glew32.dll
|

#sys-glewInit
#sys-glCreateProgram
#sys-glCreateShader
#sys-glShaderSource
#sys-glCompileShader
#sys-glGetShaderiv
#sys-glAttachShader
#sys-glGetProgramiv
#sys-glGetAttribLocation
#sys-glClearColor
#sys-glGenBuffers
#sys-glBindBuffer
#sys-glBufferData
#sys-glClear
#sys-glUseProgram
#sys-glEnableVertexAttribArray
#sys-glVertexAttribPointer
#sys-glDrawElements
#sys-glDisableVertexAttribArray
#sys-glDeleteProgram
#sys-glIsProgram
#sys-glIsShader


::glewInit sys-glewInit sys0 drop ;
::glCreateProgram sys-glCreateProgram sys0 ;
::glCreateShader sys-glCreateShader sys1 ;
::glShaderSource sys-glShaderSource sys4 drop ;
::glCompileShader sys-glCompileShader sys1 drop ;
::glGetShaderiv sys-glGetShaderiv sys3 drop ;
::glAttachShader sys-glAttachShader sys2 drop ;
::glGetProgramiv sys-glGetProgramiv sys3 drop ;
::glGetAttribLocation sys-glGetAttribLocation sys2 ;
::glClearColor sys-glClearColor sys4 drop ;
::glGenBuffers sys-glGenBuffers sys2 drop ;
::glBindBuffer sys-glBindBuffer sys2 drop ;
::glBufferData sys-glBufferData sys4 drop ;
::glClear sys-glClear sys1 drop ;
::glUseProgram sys-glUseProgram sys1 drop ;
::glEnableVertexAttribArray sys-glEnableVertexAttribArray sys1 drop ;
::glVertexAttribPointer sys-glVertexAttribPointer sys6 drop ;
::glDrawElements sys-glDrawElements sys4 drop ;
::glDisableVertexAttribArray sys-glDisableVertexAttribArray sys1 drop ;
::glDeleteProgram sys-glDeleteProgram sys1 drop ;
::glIsProgram sys-glIsProgram sys1 ;
::glIsShader sys-glIsShader sys1 ;

::glew
	"GLEW32.DLL" loadlib
	dup "glewInit" getproc 'sys-glewInit ! 
	dup "glCreateProgram" getproc 'sys-glCreateProgram !
	dup "glCreateShader" getproc 'sys-glCreateShader !
	dup "glShaderSource" getproc 'sys-glShaderSource !
	dup "glCompileShader" getproc 'sys-glCompileShader !
	dup "glGetShaderiv" getproc 'sys-glGetShaderiv !
	dup "glAttachShader" getproc 'sys-glAttachShader !
	dup "glGetProgramiv" getproc 'sys-glGetProgramiv !
	dup "glGetAttribLocation" getproc 'sys-glGetAttribLocation !
	dup "glClearColor" getproc 'sys-glClearColor !
	dup "glGenBuffers" getproc 'sys-glGenBuffers !
	dup "glBindBuffer" getproc 'sys-glBindBuffer !
	dup "glBufferData" getproc 'sys-glBufferData !
	dup "glClear" getproc 'sys-glClear !
	dup "glUseProgram" getproc 'sys-glUseProgram !
	dup "glEnableVertexAttribArray" getproc 'sys-glEnableVertexAttribArray !
	dup "glVertexAttribPointer" getproc 'sys-glVertexAttribPointer !
	dup "glDrawElements" getproc 'sys-glDrawElements !
	dup "glDisableVertexAttribArray" getproc 'sys-glDisableVertexAttribArray !
	dup "glIsProgram" getproc 'sys-glIsProgram !
	dup "glIsShader" getproc 'sys-glIsShader !
	drop
	;