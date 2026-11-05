^r3/lib/console.r3

#mem * $fff

:testing..
	"press any key" .println
	
	'pad getch drop
	"getch ok" .println
	
	mark
	">file memory ok<" ,s
	"test.txt" savemem
	empty
	"save ok" .println
	
	'mem "test.txt" load drop
	'mem .println
	"load ok" .println
	;
	
: "hello forth!" .println 
testing..
;