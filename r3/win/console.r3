| console words
| PHREDA 2021

^r3/win/core.r3
^r3/lib/mem.r3

#kb 0

::key | -- key
	stdin 'kb 1 0 0 ReadFile drop kb ;
	
::key? | -- f 
	stdin 0 WaitForSingleObject  ;
	
::type | str cnt --
	stdout rot rot 0 0 WriteFile drop ;

#irec 0 
##codekey0 0 0

::getch | -- key
	stdin 'irec 1 'kb ReadConsoleInput 
	irec 
	$100000001 =? ( drop codekey 48 >> ; )
	drop 
	0 ;
	
#crb ( 10 13 0 0 )
#esc[ ( $1b $5b 0 0 0 0 0 0 0 0 0 0 )

::cr 'crb 2 type ;
::sp " " 1 type ;
::nsp ( 1? 1 - sp ) drop ;

::emit | nro
	" " dup rot swap c! 1 type ;
	
::.[ 'esc[ 2 + swap
	( c@+ 1? rot c!+ swap ) 2drop
	'esc[ swap over - type ;
	
::.print sprint count type ;

::. count type ;

::.home	"H" .[ ; | home
::.cls "2J" .[ ; | cls 

::.at | x y -- ;|ESC[{line};{column}H  moves cursor to line #, column #
	"%d;%df" sprint .[ ;

::.color | color -- ;|ESC[38;5;{ID}m	Set foreground color.
	"%dm" sprint .[ ;

##pad * 256

::.input
	'pad
	( key 13 <>? swap c!+ ) drop
	0 swap c! ;
