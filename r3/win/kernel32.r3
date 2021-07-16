| Kernel32.dll
|

#sys-AllocConsole
#sys-ExitProcess 
#sys-GetStdHandle
#sys-ReadFile
#sys-WriteFile 
#sys-GetConsoleMode 
#sys-SetConsoleMode
#sys-FlushConsoleInputBuffer
#sys-Sleep
#sys-WaitForSingleObject sys2
#sys-GetLastError
#sys-CreateFileA
#sys-CloseHandle
#sys-FlushFileBuffers
#sys-DeleteFileA
#sys-MoveFileA
#sys-SetFilePointer
#sys-SetEndOfFile
#sys-GetFileSize

#sys-GetProcessHeap
#sys-HeapAlloc
#sys-HeapFree
#sys-HeapReAlloc


::AllocConsole sys-allocconsole sys0 drop ;
::ExitProcess sys-ExitProcess sys1 ;
::GetStdHandle sys-GetStdHandle sys1 ;
::ReadFile sys-ReadFile sys5 ;
::WriteFile sys-WriteFile sys5 ;
::GetConsoleMode sys-GetConsoleMode sys2 ;
::SetConsoleMode sys-SetConsoleMode sys2 ;
::FlushConsoleInputBuffer sys-FlushConsoleInputBuffer sys1 ;
::Sleep sys-Sleep sys1 drop ;
::WaitForSingleObject sys-WaitForSingleObject sys2 ;
::GetLastError sys-GetLastError sys0 ;
::CreateFileA sys-CreateFileA sys7 ;
::CloseHandle sys-CloseHandle sys1 ;
::FlushFileBuffers sys-FlushFileBuffers sys1 ;
::DeleteFileA sys-DeleteFileA sys1 ;
::MoveFileA sys-MoveFileA sys2 ;
::SetFilePointer sys-SetFilePointer sys4 ;
::SetEndOfFile sys-SetEndOfFile sys1 ;
::GetFileSize sys-GetFileSize sys2 ;

::GetProcessHeap sys-GetProcessHeap sys0 ;
::HeapAlloc 'sys-HeapAlloc sys3 drop ;
::HeapFree 'sys-HeapFree sys3 drop ;
::HeapReAlloc 'sys-HeapReAlloc sys4 drop ;

#console-mode
##process-heap

##stdin 
##stdout
##stderr

::windows
	"KERNEL32.DLL" loadlib 
	dup "AllocConsole" getproc 'sys-AllocConsole !
	dup "ExitProcess" getproc 'sys-ExitProcess ! 
	dup "GetStdHandle" getproc 'sys-GetStdHandle !
	dup "ReadFile" getproc 'sys-ReadFile !
	dup "WriteFile" getproc 'sys-WriteFile !
	dup "GetConsoleMode" getproc 'sys-GetConsoleMode !
	dup "SetConsoleMode" getproc 'sys-SetConsoleMode !
	dup "FlushConsoleInputBuffer" getproc 'sys-FlushConsoleInputBuffer !
	dup "Sleep" getproc 'sys-Sleep !
	dup "WaitForSingleObject" getproc 'sys-WaitForSingleObject ! 
	dup "GetLastError" getproc 'sys-GetLastError ! 
	dup "CreateFileA" getproc 'sys-CreateFileA ! 
	dup "CloseHandle" getproc 'sys-CloseHandle !
	dup "FlushFileBuffers" getproc 'sys-FlushFileBuffers !
	dup "DeleteFileA" getproc 'sys-DeleteFileA !
	dup "MoveFileA" getproc 'sys-MoveFileA !
	dup "SetFilePointer" getproc 'sys-SetFilePointer !
	dup "SetEndOfFile" getproc 'sys-SetEndOfFile !
	dup "GetFileSize" getproc 'sys-GetFileSize !

	dup "GetProcessHeap" getproc 'sys-GetProcessHeap !
	dup "HeapAlloc" getproc 'sys-HeapAlloc !
	dup "HeapFree" getproc 'sys-HeapFree !
	dup "HeapReAlloc" getproc 'sys-HeapReAlloc !

	drop
	AllocConsole 
	-10 GetStdHandle 'stdin ! | STD_INPUT_HANDLE
	-11 GetStdHandle 'stdout ! | STD_OUTPUT_HANDLE
	-12 GetStdHandle 'stderr ! | STD_ERROR_HANDLE	
	stdin 'console-mode GetConsoleMode drop	
	stdin console-mode $1a neg and SetConsoleMode drop
	stdout 'console-mode GetConsoleMode drop	
	stdout console-mode $4 or SetConsoleMode drop
	
	GetProcessHeap 'process-heap !
	;
	
