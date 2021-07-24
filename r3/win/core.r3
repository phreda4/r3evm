| SO core words
| PHREDA 2021

^r3/lib/str.r3
	
::ms | ms --
	Sleep ;
	
::allocate |( n -- a ior ) 
	process-heap 0 rot HeapAlloc ;
	
::free |( a -- ior ) 
	process-heap 0 rot HeapFree ;
	
::resize |( a n -- a ior ) 
	process-heap rot rot 0 rot HeapReAlloc ;

|----------
#sistime 0 0 | 16 bytes

::time | -- h m s
	'sistime GetLocalTime
	'sistime 8 + @
	dup $ffff and 
	swap 16 >> dup $ffff and 
	swap 16 >> $ffff and
	;
	
::date | -- y m d
	'sistime GetLocalTime
	'sistime @
	dup $ffff and 
	swap 16 >> dup $ffff and
	swap 24 >> $ffff and
	;
	
#fdd * 260
#hfind 
|struct WIN32_FIND_DATAA
|  dwFileAttributes   dd ?
|  ftCreationTime     FILETIME
|  ftLastAccessTime   FILETIME
|  ftLastWriteTime    FILETIME
|  nFileSizeHigh      dd ?
|  nFileSizeLow	     dd ?
|  dwReserved0	     dd ?
|  dwReserved1	     dd ?
|  cFileName	     db MAX_PATH dup (?)
|  cAlternateFileName db 14 dup (?)

::ffirst | "path//*" -- fdd/0
	'fdd FindFirstFile
	-1 =? ( drop 0 ; )
	'hfind !
	'fdd ;

::fnext | -- fdd/0
	hfind 'fdd FindNextFile
	1? ( drop 'fdd ; )
	hfind FindClose ; 

#cntf

::load | 'from "filename" -- 'to
| CreateFile eax,GENERIC_READ,FILE_SHARE_READ,0,OPEN_EXISTING,FILE_FLAG_SEQUENTIAL_SCAN,0
	$80000000 1 0 3 $8000000 0 CreateFile
	0? ( drop ; )
	swap
| ReadFile,[hdir],[afile],$fffff,cntr,0	
	( 2dup $ffff 'cntf 0 ReadFile drop
		cntf + cntf 1? drop ) drop
	swap CloseHandle
	;
	
::save | 'from cnt "filename" -- 
| CreateFile eax,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_FLAG_SEQUENTIAL_SCAN,0
	$40000000 0 0 2 $8000000 0 CreateFile
	0? ( 3drop ; )
| WriteFile,[hdir],edx,ecx,cntr,0
	dup >r rot rot 'cntf 0 WriteFile
	r> swap 0? ( 2drop ; ) drop
	CloseHandle 
	;
	
::append | 'from cnt "filename" -- 
| CreateFile eax,4,0,0,CREATE_ALWAYS,FILE_FLAG_SEQUENTIAL_SCAN,0
	$4 0 0 2 $8000000 0 CreateFile
	0? ( 3drop ; )
| WriteFile,[hdir],edx,ecx,cntr,0
	dup >r rot rot 'cntf 0 WriteFile
	r> swap 0? ( 2drop ; ) drop
	CloseHandle 
	;

|struct STARTUPINFO
|  cb		  dd ?,?
|  lpReserved	  dq ?
|  lpDesktop	  dq ?
|  lpTitle	  dq ?
|  dwX		  dd ?
|  dwY		  dd ?
|  dwXSize	  dd ?
|  dwYSize	  dd ?
|  dwXCountChars   dd ?
|  dwYCountChars   dd ?
|  dwFillAttribute dd ?
|  dwFlags	  dd ?
|  wShowWindow	  dw ?
|  cbReserved2	  dw ?,?,?
|  lpReserved2	  dq ?
|  hStdInput	  dq ?
|  hStdOutput	  dq ?
|  hStdError	  dq ?

#sinfo * 100

|struct PROCESS_INFORMATION
|  hProcess    dq ?
|  hThread     dq ?
|  dwProcessId dd ?
| dwThreadId  dd ?

#pinfo * 24

::sys | "" --
	'sinfo 0 100 cfill
	68 'sinfo d!
	0 swap 0 0 0 $8000000 0 0 'sinfo 'pinfo CreateProcess drop
	;