^r3/win/console.r3

#buffer * 256

:input
	'buffer
	( key 13 <>? swap c!+ ) drop
	0 swap c! ;