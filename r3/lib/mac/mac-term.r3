| console words linux - Enhanced and Consistent
| PHREDA 2022 - Updated 2025
^r3/lib/mac/posix.r3
^r3/lib/mem.r3
^r3/lib/parse.r3

::type 1 -rot libc-write drop ;

#sterm * 80		| termios structure (72 bytes on macOS arm64)
#flgs

| macOS arm64 termios layout (tcflag_t = 8 bytes):
|  offset 0:  c_iflag  (8 bytes)
|  offset 8:  c_oflag  (8 bytes)
|  offset 16: c_cflag  (8 bytes)
|  offset 24: c_lflag  (8 bytes)
|  offset 32: c_cc     (20 bytes)
|  offset 56: c_ispeed (8 bytes)
|  offset 64: c_ospeed (8 bytes)
| VERASE=3  VMIN=16  VTIME=17
|------- Initialization -------
::.reterm | --
	sterm 0? ( 0 'sterm libc-tcgetattr ) drop
	'sterm >a here >b
	a@+ $FFFFFCCD and b!+	| IFLAG: clear BRKINT|INPCK|ISTRIP|ICRNL|IXON
	a@+ $FFFFFFFE and b!+	| OFLAG: clear OPOST
	a@+ $300 or b!+		| CFLAG: set CS8
	a@+ $FFFFFA77 and b!+	| LFLAG: clear ECHO|ICANON|IEXTEN|ISIG
	a@+ b!+ a@+ b!+ a@+ b!+ a@+ b!+ a@ b! | c_cc + ispeed + ospeed
	here 32 + >b | c_cc at offset 32
	$7f b> 3 + c!	| VERASE
	1 b> 16 + c!	| VMIN
	0 b> 17 + c!	| VTIME
	0 0 here libc-tcsetattr
	;

#showc ( $1B $5B $3f $32 $35 $68 )
::.free | --
	'showc 6 type
	|0 2 flgs libc-fcntl drop  ??
	0 0 'sterm libc-tcsetattr 
	0 'sterm !
	;

|------- Console Information -------
##rows ##cols
#prevrc 0

::.getterminfo | --
	1 $40087468 'flgs libc-ioctl | TIOCGWINSZ
	flgs dup 16 >> $ffff and 1 - 'cols !
	$ffff and 1 - 'rows ! ;

:.getrc rows 16 << cols or ;

|------- Resize Detection -------
#on-resize 0 | callback address

:.checksize | -- evt
	on-resize 0? ( ; )
	.getterminfo
	.getrc prevrc =? ( 2drop 0 ; ) 'prevrc !
    ex 4 ; |#EVT_RESIZE 4
	
::.onresize | 'callback -
    'on-resize ! ;

|------- Keyboard Input -------
#bufferin * 16

:buffin | -- len
	0 'bufferin 2dup ! 16 libc-read ;

#tv 0 0
#fds 0 0

::kbhit
	1 'fds 2dup ! 0 0 'tv libc-select ;

::inkey | -- key | 0 if no key
	kbhit 0? ( ; ) drop
	buffin drop
	bufferin ;

|------- Event System (Windows-compatible) -------
##evtmx ##evtmy
##evtmb
##evtmw
::evtmxy evtmx evtmy ;

|--- mode 1006
:dnbtn
	$40 and? ( $1 and 2* 1- neg 'evtmw ! ; ) 
	$3 and 1 swap <<
	evtmb or 'evtmb ! ;
	
:upbtn
	$40 and? ( $1 and 2* 1- 'evtmw ! ; ) 
	$3 and 1 swap << not
	evtmb and 'evtmb ! ;
	
| Formato: ESC[<button;x;yM o m
:check6 | -- button x y
	0 'evtmw !
	'bufferin 3 +
    getnro swap 1+ | Skip ;
    getnro 'evtmx ! 1+ | Skip ;
    getnro 'evtmy ! 
	c@ | m 6d M 4d
	$20 nand? ( drop dnbtn ; ) 
	drop upbtn ;

::inevt | -- type | 0 if no event
	kbhit 0? ( drop .checksize ; ) drop
	buffin 
	6 >? ( drop 
		bufferin $ffffff and
		$3c5b1b =? ( drop check6 2 ; ) | #EVT_MOUSE 2
		) drop
	1 ; |#EVT_KEY 1
	
::getevt | -- type | wait for event
    ( inevt 0? drop 10 ms ) ;

::evtkey | -- key
    bufferin ;

#enable_sgr ( $1B $5B $3F $31 $30 $30 $36 $68 )
#enable_1002 ( $1B $5B $3F $31 $30 $30 $33 $68 ) |>>3
#disable_sgr ( $1B $5B $3F $31 $30 $30 $36 $6C )
#disable_1002 ( $1B $5B $3F $31 $30 $30 $33 $6C ) |>>3

::.enable-mouse
	'enable_1002 8 type
	'enable_sgr 8 type 
	;

::.disable-mouse
	'disable_sgr 8 type
	'disable_1002 8 type
	;

:
	.reterm
	.getterminfo
	.getrc 'prevrc ! 
| Set locale to UTF-8
	"en_US.UTF-8" "LC_ALL" libc-setlocale drop
	"en_US.UTF-8" "LC_CTYPE" libc-setlocale drop
	;
	