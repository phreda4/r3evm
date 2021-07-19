^r3/win/kernel32.r3
^r3/win/core.r3
^r3/lib/mem.r3

#kb 0

::key | -- key
	stdin 'kb 1 0 0 ReadFile drop kb ;
	
::key? | -- f 
	stdin 0 WaitForSingleObject  ;
	
::type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;
	
#crb ( 10 13 0 0 )
#esc[ ( $1b $5b 0 0 0 0 0 0 0 0 0 0 )

::cr 'crb 2 type ;
	
::.[ 'esc[ 2 + swap
	( c@+ 1? rot c!+ swap ) 2drop
	'esc[ swap over - type ;
	
::.print count type ;

::.home	"H" .[ ; | home
::.cls "J" .[ ; | cls 

::.at | x y -- ;|ESC[{line};{column}H  moves cursor to line #, column #
	swap "%d;%dH" sprint .[ ;

::.fc | color -- ;|ESC[38;5;{ID}m	Set foreground color.
	"38;4;%dm" sprint .[ ;
	
::.bc | color -- ;|ESC[48;5;{ID}m	Set background color.
	"48;5;%dm" sprint .[ ;
