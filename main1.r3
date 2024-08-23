^r3/win/console.r3
^r3/lib/math.r3
|^r3/win/consolew.r3

#var
#var2 0.99


:test1
	1.0 'var !
	var "%f" .println
	1.0 'var +!
	var "%f" .println
	
	'var @+ "%f" .println @ "%f" .println
	
	0.25 0.33 'var !+ !
	
	'var @+ "%f" .println @ "%f" .println
	;
	
: 
test1
.input
;