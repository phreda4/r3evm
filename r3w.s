	.file	"r3.cpp"
	.section	.text.unlikely,"x"
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.globl	_Z4iniAv
	.def	_Z4iniAv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z4iniAv
_Z4iniAv:
	.seh_endprologue
	movl	$0, cntstacka(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely,"x"
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	_Z5pushAi
	.def	_Z5pushAi;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5pushAi
_Z5pushAi:
	.seh_endprologue
	movslq	cntstacka(%rip), %rax
	leal	1(%rax), %edx
	movl	%edx, cntstacka(%rip)
	leaq	stacka(%rip), %rdx
	movl	%ecx, (%rdx,%rax,4)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely,"x"
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	_Z4popAv
	.def	_Z4popAv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z4popAv
_Z4popAv:
	.seh_endprologue
	movl	cntstacka(%rip), %eax
	leaq	stacka(%rip), %rdx
	subl	$1, %eax
	movl	%eax, cntstacka(%rip)
	cltq
	movl	(%rdx,%rax,4), %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE2:
	.text
.LHOTE2:
	.section	.text.unlikely,"x"
.LCOLDB3:
	.text
.LHOTB3:
	.p2align 4,,15
	.globl	_Z5isNroPc
	.def	_Z5isNroPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5isNroPc
_Z5isNroPc:
	.seh_endprologue
	movzbl	(%rcx), %eax
	cmpb	$45, %al
	je	.L31
	xorl	%r11d, %r11d
	cmpb	$43, %al
	je	.L32
.L6:
	cmpb	$32, %al
	jbe	.L12
	cmpb	$36, %al
	je	.L10
	cmpb	$37, %al
	jne	.L33
	addq	$1, %rcx
	movl	$2, %r8d
.L9:
	movq	$0, nro(%rip)
	movsbl	(%rcx), %eax
	cmpb	$32, %al
	jbe	.L12
	cmpl	$10, %r8d
	movslq	%r8d, %r9
	setne	%r10b
	jmp	.L18
	.p2align 4,,10
.L35:
	subl	$48, %eax
.L16:
	cmpl	%r8d, %eax
	jge	.L12
	movl	%eax, %edx
	shrl	$31, %edx
	testb	%dl, %dl
	jne	.L12
	cltq
.L13:
	movq	%r9, %rdx
	addq	$1, %rcx
	imulq	nro(%rip), %rdx
	addq	%rax, %rdx
	movq	%rdx, nro(%rip)
	movsbl	(%rcx), %eax
	cmpb	$32, %al
	jbe	.L34
.L18:
	cmpb	$46, %al
	jne	.L23
	testb	%r10b, %r10b
	jne	.L21
.L23:
	cmpb	$57, %al
	jle	.L35
	cmpb	$96, %al
	jle	.L17
	subl	$87, %eax
	jmp	.L16
	.p2align 4,,10
.L12:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
.L10:
	addq	$1, %rcx
	movl	$16, %r8d
	jmp	.L9
	.p2align 4,,10
.L21:
	xorl	%eax, %eax
	jmp	.L13
	.p2align 4,,10
.L17:
	cmpb	$64, %al
	jle	.L12
	subl	$55, %eax
	jmp	.L16
	.p2align 4,,10
.L31:
	movzbl	1(%rcx), %eax
	movl	$1, %r11d
	addq	$1, %rcx
	jmp	.L6
	.p2align 4,,10
.L33:
	movl	$10, %r8d
	jmp	.L9
	.p2align 4,,10
.L32:
	movzbl	1(%rcx), %eax
	addq	$1, %rcx
	jmp	.L6
	.p2align 4,,10
.L34:
	cmpl	$1, %r11d
	movl	$-1, %eax
	je	.L36
	rep ret
.L36:
	negq	%rdx
	movq	%rdx, nro(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text.unlikely,"x"
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4,,15
	.globl	_Z6isNrofPc
	.def	_Z6isNrofPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z6isNrofPc
_Z6isNrofPc:
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movzbl	(%rcx), %eax
	cmpb	$45, %al
	je	.L57
	xorl	%r11d, %r11d
	cmpb	$43, %al
	je	.L58
.L39:
	cmpb	$32, %al
	jbe	.L44
	movq	$0, nro(%rip)
	movsbl	(%rcx), %r8d
	cmpb	$32, %r8b
	ja	.L46
	jmp	.L51
	.p2align 4,,10
.L61:
	subl	$48, %r8d
	cmpl	$9, %r8d
	ja	.L44
	movq	nro(%rip), %r9
	movslq	%r8d, %r8
	addq	$1, %rcx
	leaq	(%r9,%r9,4), %rax
	leaq	(%r8,%rax,2), %r9
	movq	%r9, nro(%rip)
	movsbl	(%rcx), %r8d
	cmpb	$32, %r8b
	jbe	.L59
.L46:
	cmpb	$46, %r8b
	je	.L60
	cmpb	$57, %r8b
	jle	.L61
.L44:
	xorl	%eax, %eax
	popq	%rbx
	ret
	.p2align 4,,10
.L60:
	movq	nro(%rip), %r10
	movq	$1, nro(%rip)
	movl	$1, %r9d
	movsbl	1(%rcx), %r8d
	cmpb	$32, %r8b
	jle	.L44
	addq	$1, %rcx
	cmpb	$32, %r8b
	ja	.L46
.L59:
	cmpq	$1, %r9
	movq	%r9, %rcx
	movl	$1, %r8d
	movabsq	$7378697629483820647, %rbx
	jle	.L51
	.p2align 4,,10
.L52:
	movq	%rcx, %rax
	leal	(%r8,%r8,4), %r8d
	sarq	$63, %rcx
	imulq	%rbx
	addl	%r8d, %r8d
	sarq	$2, %rdx
	subq	%rcx, %rdx
	cmpq	$1, %rdx
	movq	%rdx, %rcx
	jg	.L52
	movq	%r9, %rax
	movslq	%r8d, %r8
	salq	$16, %rax
	cqto
	idivq	%r8
	movzwl	%ax, %r9d
.L42:
	movq	%r10, %rax
	salq	$16, %rax
	orq	%r9, %rax
	cmpl	$1, %r11d
	je	.L62
.L55:
	movq	%rax, nro(%rip)
	movl	$-1, %eax
	popq	%rbx
	ret
	.p2align 4,,10
.L57:
	movzbl	1(%rcx), %eax
	movl	$1, %r11d
	addq	$1, %rcx
	jmp	.L39
	.p2align 4,,10
.L58:
	movzbl	1(%rcx), %eax
	addq	$1, %rcx
	jmp	.L39
.L62:
	negq	%rax
	jmp	.L55
.L51:
	xorl	%r9d, %r9d
	jmp	.L42
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE4:
	.text
.LHOTE4:
	.section	.text.unlikely,"x"
.LCOLDB5:
	.text
.LHOTB5:
	.p2align 4,,15
	.globl	_Z5touppc
	.def	_Z5touppc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5touppc
_Z5touppc:
	.seh_endprologue
	movl	%ecx, %eax
	andl	$-33, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE5:
	.text
.LHOTE5:
	.section	.text.unlikely,"x"
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.globl	strnicmp
	.def	strnicmp;	.scl	2;	.type	32;	.endef
	.seh_proc	strnicmp
strnicmp:
	.seh_endprologue
	testq	%r8, %r8
	je	.L73
	movzbl	(%rcx), %r10d
	xorl	%eax, %eax
	testb	%r10b, %r10b
	je	.L75
	movzbl	(%rdx), %r9d
	testb	%r9b, %r9b
	jne	.L66
	rep ret
	.p2align 4,,10
.L75:
	rep ret
	.p2align 4,,10
.L66:
	movl	%r10d, %eax
	subq	$1, %r8
	xorl	%r10d, %r10d
	jmp	.L67
	.p2align 4,,10
.L77:
	addq	$1, %r10
	movzbl	(%rdx,%r10), %r9d
	testb	%r9b, %r9b
	je	.L73
.L67:
	cmpb	%al, %r9b
	je	.L69
	andl	$-33, %eax
	andl	$-33, %r9d
	movsbl	%al, %eax
	movsbl	%r9b, %r9d
	subl	%r9d, %eax
	jne	.L75
.L69:
	cmpq	%r10, %r8
	je	.L73
	movzbl	1(%rcx,%r10), %eax
	testb	%al, %al
	jne	.L77
.L73:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.unlikely,"x"
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4,,15
	.globl	_Z8strequalPcS_
	.def	_Z8strequalPcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8strequalPcS_
_Z8strequalPcS_:
	.seh_endprologue
	jmp	.L79
	.p2align 4,,10
.L81:
	addq	$1, %rdx
	movzbl	-1(%rdx), %r8d
	andl	$-33, %eax
	addq	$1, %rcx
	andl	$-33, %r8d
	cmpb	%al, %r8b
	jne	.L82
.L79:
	movzbl	(%rcx), %eax
	cmpb	$32, %al
	ja	.L81
	xorl	%eax, %eax
	cmpb	$32, (%rdx)
	setbe	%al
	negl	%eax
	ret
	.p2align 4,,10
.L82:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE7:
	.text
.LHOTE7:
	.section	.text.unlikely,"x"
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.globl	_Z4trimPc
	.def	_Z4trimPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z4trimPc
_Z4trimPc:
	.seh_endprologue
	movq	%rcx, %rax
	movzbl	(%rcx), %ecx
	leal	-1(%rcx), %edx
	cmpb	$31, %dl
	ja	.L84
	.p2align 4,,10
.L85:
	addq	$1, %rax
	movzbl	(%rax), %ecx
	leal	-1(%rcx), %edx
	cmpb	$31, %dl
	jbe	.L85
.L84:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE8:
	.text
.LHOTE8:
	.section	.text.unlikely,"x"
.LCOLDB9:
	.text
.LHOTB9:
	.p2align 4,,15
	.globl	_Z5nextwPc
	.def	_Z5nextwPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5nextwPc
_Z5nextwPc:
	.seh_endprologue
	cmpb	$32, (%rcx)
	movq	%rcx, %rax
	jbe	.L88
	.p2align 4,,10
.L89:
	addq	$1, %rax
	cmpb	$32, (%rax)
	ja	.L89
.L88:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE9:
	.text
.LHOTE9:
	.section	.text.unlikely,"x"
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.globl	_Z6nextcrPc
	.def	_Z6nextcrPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z6nextcrPc
_Z6nextcrPc:
	.seh_endprologue
	movzbl	(%rcx), %edx
	movq	%rcx, %rax
	cmpb	$31, %dl
	jbe	.L100
	.p2align 4,,10
.L98:
	addq	$1, %rax
	movzbl	(%rax), %edx
	cmpb	$31, %dl
	ja	.L98
.L100:
	cmpb	$9, %dl
	je	.L98
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely,"x"
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	_Z7nextstrPc
	.def	_Z7nextstrPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7nextstrPc
_Z7nextstrPc:
	.seh_endprologue
	leaq	1(%rcx), %rax
	movzbl	1(%rcx), %ecx
	testb	%cl, %cl
	jne	.L104
	jmp	.L102
	.p2align 4,,10
.L103:
	movzbl	1(%rdx), %ecx
	leaq	1(%rdx), %rax
	testb	%cl, %cl
	je	.L102
.L104:
	cmpb	$34, %cl
	movq	%rax, %rdx
	jne	.L103
	cmpb	$34, 1(%rax)
	leaq	1(%rax), %rdx
	je	.L103
	addq	$2, %rax
	ret
	.p2align 4,,10
.L102:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE11:
	.text
.LHOTE11:
	.section	.text.unlikely,"x"
.LCOLDB12:
	.text
.LHOTB12:
	.p2align 4,,15
	.globl	_Z5isBasPc
	.def	_Z5isBasPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5isBasPc
_Z5isBasPc:
	.seh_endprologue
	movq	r3bas(%rip), %r8
	movq	$0, nro(%rip)
	leaq	r3bas(%rip), %r10
	movzbl	(%r8), %eax
	testb	%al, %al
	je	.L117
	.p2align 4,,10
.L119:
	movq	%rcx, %r9
	jmp	.L114
	.p2align 4,,10
.L115:
	addq	$1, %r9
	movzbl	-1(%r9), %edx
	andl	$-33, %eax
	addq	$1, %r8
	andl	$-33, %edx
	cmpb	%al, %dl
	jne	.L113
	movzbl	(%r8), %eax
.L114:
	cmpb	$32, %al
	ja	.L115
	cmpb	$32, (%r9)
	ja	.L113
	movl	$-1, %eax
	ret
	.p2align 4,,10
.L113:
	addq	$8, %r10
	movq	(%r10), %r8
	addq	$1, nro(%rip)
	movzbl	(%r8), %eax
	testb	%al, %al
	jne	.L119
.L117:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE12:
	.text
.LHOTE12:
	.section	.text.unlikely,"x"
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.globl	_Z6isWordPc
	.def	_Z6isWordPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z6isWordPc
_Z6isWordPc:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movl	cntdicc(%rip), %eax
	movl	dicclocal(%rip), %esi
	leaq	dicc(%rip), %rbx
	.p2align 4,,10
.L122:
	subl	$1, %eax
	js	.L136
	movslq	%eax, %r11
	movq	%rcx, %r9
	movq	%r11, %rdx
	salq	$4, %rdx
	movq	(%rbx,%rdx), %r10
	jmp	.L123
	.p2align 4,,10
.L125:
	addq	$1, %r9
	movzbl	-1(%r9), %r8d
	andl	$-33, %edx
	addq	$1, %r10
	andl	$-33, %r8d
	cmpb	%dl, %r8b
	jne	.L122
.L123:
	movzbl	(%r10), %edx
	cmpb	$32, %dl
	ja	.L125
	cmpb	$32, (%r9)
	ja	.L122
	salq	$4, %r11
	testb	$1, 12(%rbx,%r11)
	jne	.L133
	cmpl	%esi, %eax
	jl	.L122
.L133:
	popq	%rbx
	popq	%rsi
	ret
.L136:
	movl	$-1, %eax
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE13:
	.text
.LHOTE13:
	.section	.text.unlikely,"x"
.LCOLDB14:
	.text
.LHOTB14:
	.p2align 4,,15
	.globl	_Z7codetoki
	.def	_Z7codetoki;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7codetoki
_Z7codetoki:
	.seh_endprologue
	movslq	memc(%rip), %rax
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movq	memcode(%rip), %rdx
	movl	%ecx, (%rdx,%rax,4)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE14:
	.text
.LHOTE14:
	.section	.text.unlikely,"x"
.LCOLDB15:
	.text
.LHOTB15:
	.p2align 4,,15
	.globl	_Z8closevarv
	.def	_Z8closevarv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8closevarv
_Z8closevarv:
	.seh_endprologue
	movl	cntdicc(%rip), %eax
	testl	%eax, %eax
	je	.L138
	subl	$1, %eax
	leaq	dicc(%rip), %rcx
	movslq	memd(%rip), %rdx
	cltq
	salq	$4, %rax
	cmpl	%edx, 8(%rcx,%rax)
	jl	.L138
	movq	memdata(%rip), %rax
	movb	$0, (%rax,%rdx)
	addl	$8, memd(%rip)
.L138:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE15:
	.text
.LHOTE15:
	.section	.text.unlikely,"x"
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.globl	_Z11compilaDATAPc
	.def	_Z11compilaDATAPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11compilaDATAPc
_Z11compilaDATAPc:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	call	_Z8closevarv
	cmpb	$35, 1(%rbx)
	movl	$16, %ecx
	jne	.L144
	addq	$1, %rbx
	movb	$17, %cl
.L144:
	movslq	cntdicc(%rip), %rax
	leaq	dicc(%rip), %r8
	addq	$1, %rbx
	movl	$2, modo(%rip)
	movq	%rax, %rdx
	salq	$4, %rax
	addq	%r8, %rax
	movl	memd(%rip), %r8d
	addl	$1, %edx
	movq	%rbx, (%rax)
	movl	%ecx, 12(%rax)
	movl	%edx, cntdicc(%rip)
	movl	%r8d, 8(%rax)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely,"x"
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.globl	_Z11compilaCODEPc
	.def	_Z11compilaCODEPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11compilaCODEPc
_Z11compilaCODEPc:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	call	_Z8closevarv
	xorl	%ecx, %ecx
	cmpb	$58, 1(%rbx)
	je	.L153
.L147:
	movslq	cntdicc(%rip), %rax
	leaq	dicc(%rip), %rdx
	movq	%rax, %r8
	salq	$4, %rax
	addq	%rdx, %rax
	leaq	1(%rbx), %rdx
	addl	$1, %r8d
	movl	%ecx, 12(%rax)
	movl	%r8d, cntdicc(%rip)
	movq	%rdx, (%rax)
	movslq	memc(%rip), %rdx
	movl	%edx, 8(%rax)
	cmpb	$32, 1(%rbx)
	jg	.L148
	movl	boot(%rip), %eax
	movl	%edx, boot(%rip)
	cmpl	$-1, %eax
	je	.L148
	leal	1(%rdx), %ecx
	sall	$8, %eax
	orl	$3, %eax
	movl	%ecx, memc(%rip)
	movq	memcode(%rip), %rcx
	movl	%eax, (%rcx,%rdx,4)
	movl	memc(%rip), %edx
.L148:
	movl	$1, modo(%rip)
	movl	%edx, lastblock(%rip)
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L153:
	addq	$1, %rbx
	movb	$1, %cl
	jmp	.L147
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely,"x"
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.globl	_Z8datasavePc
	.def	_Z8datasavePc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8datasavePc
_Z8datasavePc:
	.seh_endprologue
	movzbl	(%rcx), %r8d
	movl	memd(%rip), %eax
	movslq	%eax, %rdx
	testb	%r8b, %r8b
	jne	.L158
	jmp	.L155
	.p2align 4,,10
.L156:
	leal	1(%rdx), %r8d
	movl	%r8d, memd(%rip)
	movzbl	(%rcx), %r9d
	movq	memdata(%rip), %r8
	movb	%r9b, (%r8,%rdx)
	movzbl	1(%rcx), %r8d
	leaq	1(%rcx), %r9
	movslq	memd(%rip), %rdx
	testb	%r8b, %r8b
	je	.L155
	movq	%r9, %rcx
.L158:
	cmpb	$34, %r8b
	jne	.L156
	cmpb	$34, 1(%rcx)
	leaq	1(%rcx), %r8
	jne	.L155
	movq	%r8, %rcx
	jmp	.L156
	.p2align 4,,10
.L155:
	leal	1(%rdx), %ecx
	movl	%ecx, memd(%rip)
	movq	memdata(%rip), %rcx
	movb	$0, (%rcx,%rdx)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE18:
	.text
.LHOTE18:
	.section	.text.unlikely,"x"
.LCOLDB19:
	.text
.LHOTB19:
	.p2align 4,,15
	.globl	_Z10compilaSTRPc
	.def	_Z10compilaSTRPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z10compilaSTRPc
_Z10compilaSTRPc:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	addq	$1, %rcx
	call	_Z8datasavePc
	cmpl	$1, modo(%rip)
	jg	.L160
	movslq	memc(%rip), %rdx
	sall	$8, %eax
	orl	$2, %eax
	leal	1(%rdx), %ecx
	movl	%ecx, memc(%rip)
	movq	memcode(%rip), %rcx
	movl	%eax, (%rcx,%rdx,4)
.L160:
	addq	$40, %rsp
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE19:
	.text
.LHOTE19:
	.section	.text.unlikely,"x"
.LCOLDB20:
	.text
.LHOTB20:
	.p2align 4,,15
	.globl	_Z7datanrox
	.def	_Z7datanrox;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7datanrox
_Z7datanrox:
	.seh_endprologue
	movslq	memd(%rip), %rax
	movl	modo(%rip), %edx
	movq	%rax, %r8
	addq	memdata(%rip), %rax
	cmpl	$3, %edx
	je	.L164
	jle	.L174
	cmpl	$4, %edx
	je	.L167
	cmpl	$5, %edx
	jne	.L175
	movl	%ecx, (%rax)
	addl	$4, memd(%rip)
	ret
	.p2align 4,,10
.L167:
	movb	%cl, (%rax)
	addl	$1, memd(%rip)
	ret
	.p2align 4,,10
.L174:
	cmpl	$2, %edx
	jne	.L176
	addl	$8, %r8d
	movq	%rcx, (%rax)
	movl	%r8d, memd(%rip)
	ret
	.p2align 4,,10
.L164:
	testq	%rcx, %rcx
	leaq	(%rax,%rcx), %rdx
	jle	.L170
	.p2align 4,,10
.L172:
	addq	$1, %rax
	movb	$0, -1(%rax)
	cmpq	%rdx, %rax
	jne	.L172
	movl	memd(%rip), %r8d
.L170:
	addl	%r8d, %ecx
	movl	%ecx, memd(%rip)
	ret
	.p2align 4,,10
.L176:
	rep ret
	.p2align 4,,10
.L175:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE20:
	.text
.LHOTE20:
	.section	.text.unlikely,"x"
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.globl	_Z11compilaADDRi
	.def	_Z11compilaADDRi;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11compilaADDRi
_Z11compilaADDRi:
	.seh_endprologue
	leaq	dicc(%rip), %rax
	movslq	%ecx, %rcx
	salq	$4, %rcx
	addq	%rax, %rcx
	cmpl	$1, modo(%rip)
	jle	.L178
	testb	$16, 12(%rcx)
	movslq	8(%rcx), %rcx
	jne	.L181
	jmp	_Z7datanrox
	.p2align 4,,10
.L181:
	addq	memdata(%rip), %rcx
	jmp	_Z7datanrox
	.p2align 4,,10
.L178:
	movl	12(%rcx), %eax
	movl	8(%rcx), %edx
	sarl	$4, %eax
	sall	$8, %edx
	andl	$1, %eax
	leal	1(%rdx,%rax), %ecx
	movslq	memc(%rip), %rax
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movq	memcode(%rip), %rdx
	movl	%ecx, (%rdx,%rax,4)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE21:
	.text
.LHOTE21:
	.section	.text.unlikely,"x"
.LCOLDB22:
	.text
.LHOTB22:
	.p2align 4,,15
	.globl	_Z10compilaLITx
	.def	_Z10compilaLITx;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z10compilaLITx
_Z10compilaLITx:
	.seh_endprologue
	cmpl	$1, modo(%rip)
	jg	.L187
	movslq	memc(%rip), %rdx
	movl	%ecx, %eax
	movq	memcode(%rip), %r8
	sall	$8, %eax
	leal	1(%rdx), %r9d
	movl	%r9d, memc(%rip)
	movl	%eax, %r9d
	sarl	$8, %eax
	cltq
	orl	$1, %r9d
	cmpq	%rax, %rcx
	movl	%r9d, (%r8,%rdx,4)
	je	.L182
	movslq	memc(%rip), %rdx
	movq	%rcx, %r9
	sarq	$24, %r9
	movl	%r9d, %eax
	sall	$8, %eax
	leal	1(%rdx), %r10d
	movl	%r10d, memc(%rip)
	movl	%eax, %r10d
	sarl	$8, %eax
	cltq
	orb	$-120, %r10b
	cmpq	%rax, %r9
	movl	%r10d, (%r8,%rdx,4)
	je	.L182
	movslq	memc(%rip), %rax
	sarq	$48, %rcx
	sall	$8, %ecx
	orb	$-119, %cl
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movl	%ecx, (%r8,%rax,4)
.L182:
	rep ret
	.p2align 4,,10
.L187:
	jmp	_Z7datanrox
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE22:
	.text
.LHOTE22:
	.section	.text.unlikely,"x"
.LCOLDB23:
	.text
.LHOTB23:
	.p2align 4,,15
	.globl	_Z7blockInv
	.def	_Z7blockInv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7blockInv
_Z7blockInv:
	.seh_endprologue
	movslq	cntstacka(%rip), %rax
	movl	memc(%rip), %edx
	addl	$1, level(%rip)
	movl	%edx, lastblock(%rip)
	leal	1(%rax), %ecx
	movl	%ecx, cntstacka(%rip)
	leaq	stacka(%rip), %rcx
	movl	%edx, (%rcx,%rax,4)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE23:
	.text
.LHOTE23:
	.section	.text.unlikely,"x"
.LCOLDB24:
	.text
.LHOTB24:
	.p2align 4,,15
	.globl	_Z8solvejmpii
	.def	_Z8solvejmpii;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8solvejmpii
_Z8solvejmpii:
	.seh_endprologue
	cmpl	%edx, %ecx
	jge	.L194
	movq	memcode(%rip), %r8
	movslq	%ecx, %rax
	leaq	(%r8,%rax,4), %r10
	xorl	%eax, %eax
	jmp	.L193
	.p2align 4,,10
.L197:
	movl	%r9d, %r11d
	sarl	$8, %r11d
	testl	%r11d, %r11d
	jne	.L191
	movl	memc(%rip), %eax
	subl	%ecx, %eax
	sall	$8, %eax
	orl	%eax, %r9d
	movl	$1, %eax
	movl	%r9d, (%r10)
.L192:
	addl	$1, %ecx
	addq	$4, %r10
	cmpl	%edx, %ecx
	je	.L196
.L193:
	movl	(%r10), %r9d
	movzbl	%r9b, %r8d
	leal	-6(%r8), %r11d
	cmpl	$12, %r11d
	jbe	.L197
.L191:
	subl	$159, %r8d
	cmpl	$7, %r8d
	ja	.L192
	testl	$65280, %r9d
	jne	.L192
	movl	memc(%rip), %eax
	addq	$4, %r10
	subl	%ecx, %eax
	addl	$1, %ecx
	sall	$8, %eax
	movzwl	%ax, %eax
	orl	%eax, %r9d
	movl	$1, %eax
	movl	%r9d, -4(%r10)
	cmpl	%edx, %ecx
	jne	.L193
	.p2align 4,,10
.L196:
	rep ret
.L194:
	xorl	%eax, %eax
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE24:
	.text
.LHOTE24:
	.section	.text.unlikely,"x"
.LCOLDB25:
	.text
.LHOTB25:
	.p2align 4,,15
	.globl	_Z8blockOutv
	.def	_Z8blockOutv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8blockOutv
_Z8blockOutv:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	cntstacka(%rip), %eax
	leaq	stacka(%rip), %rdx
	subl	$1, %eax
	movl	%eax, cntstacka(%rip)
	cltq
	movslq	(%rdx,%rax,4), %rsi
	movl	memc(%rip), %edx
	movl	%edx, %ebx
	movl	%esi, %ecx
	subl	%esi, %ebx
	call	_Z8solvejmpii
	testl	%eax, %eax
	jne	.L202
	movq	memcode(%rip), %rax
	sall	$8, %ebx
	leaq	-4(%rax,%rsi,4), %rdx
	movl	(%rdx), %ecx
	movzbl	%cl, %eax
	subl	$159, %eax
	cmpl	$7, %eax
	jbe	.L203
	orl	%ecx, %ebx
	movl	%ebx, (%rdx)
.L200:
	subl	$1, level(%rip)
	movl	memc(%rip), %eax
	movl	%eax, lastblock(%rip)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L203:
	movzwl	%bx, %ebx
	orl	%ecx, %ebx
	movl	%ebx, (%rdx)
	jmp	.L200
	.p2align 4,,10
.L202:
	movslq	memc(%rip), %rax
	notl	%ebx
	sall	$8, %ebx
	orb	$-121, %bl
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movq	memcode(%rip), %rdx
	movl	%ebx, (%rdx,%rax,4)
	jmp	.L200
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE25:
	.text
.LHOTE25:
	.section	.text.unlikely,"x"
.LCOLDB26:
	.text
.LHOTB26:
	.p2align 4,,15
	.globl	_Z6anonInv
	.def	_Z6anonInv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z6anonInv
_Z6anonInv:
	.seh_endprologue
	movslq	cntstacka(%rip), %rdx
	movslq	memc(%rip), %rax
	leal	1(%rdx), %ecx
	movl	%ecx, cntstacka(%rip)
	leaq	stacka(%rip), %rcx
	movl	%eax, (%rcx,%rdx,4)
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movq	memcode(%rip), %rdx
	movl	$134, (%rdx,%rax,4)
	movl	memc(%rip), %eax
	addl	$1, level(%rip)
	movl	%eax, lastblock(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE26:
	.text
.LHOTE26:
	.section	.text.unlikely,"x"
.LCOLDB27:
	.text
.LHOTB27:
	.p2align 4,,15
	.globl	_Z7anonOutv
	.def	_Z7anonOutv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7anonOutv
_Z7anonOutv:
	.seh_endprologue
	movl	cntstacka(%rip), %eax
	leaq	stacka(%rip), %rdx
	movq	memcode(%rip), %rcx
	subl	$1, %eax
	movl	%eax, cntstacka(%rip)
	cltq
	movslq	(%rdx,%rax,4), %r8
	movl	memc(%rip), %edx
	sall	$8, %edx
	orl	%edx, (%rcx,%r8,4)
	movq	%r8, %rax
	movslq	memc(%rip), %rdx
	addl	$1, %eax
	sall	$8, %eax
	orl	$1, %eax
	leal	1(%rdx), %r8d
	movl	%r8d, memc(%rip)
	movl	%eax, (%rcx,%rdx,4)
	movl	memc(%rip), %eax
	subl	$1, level(%rip)
	movl	%eax, lastblock(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE27:
	.text
.LHOTE27:
	.section	.text.unlikely,"x"
.LCOLDB28:
	.text
.LHOTB28:
	.p2align 4,,15
	.globl	_Z7dataMACi
	.def	_Z7dataMACi;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7dataMACi
_Z7dataMACi:
	.seh_endprologue
	cmpl	$1, %ecx
	je	.L213
	cmpl	$2, %ecx
	je	.L212
	cmpl	$3, %ecx
	jne	.L210
	movl	$5, modo(%rip)
	ret
	.p2align 4,,10
.L210:
	cmpl	$4, %ecx
	jne	.L211
.L212:
	movl	$2, modo(%rip)
	ret
	.p2align 4,,10
.L213:
	movl	$4, modo(%rip)
	ret
.L211:
	cmpl	$44, %ecx
	jne	.L206
	movl	$3, modo(%rip)
.L206:
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely,"x"
.LCOLDB29:
	.text
.LHOTB29:
	.p2align 4,,15
	.globl	_Z9constfoldiii
	.def	_Z9constfoldiii;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z9constfoldiii
_Z9constfoldiii:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	subl	$38, %ecx
	cmpl	$20, %ecx
	ja	.L249
	leaq	.L217(%rip), %rax
	movslq	(%rax,%rcx,4), %rcx
	addq	%rcx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L217:
	.long	.L216-.L217
	.long	.L218-.L217
	.long	.L219-.L217
	.long	.L220-.L217
	.long	.L221-.L217
	.long	.L222-.L217
	.long	.L223-.L217
	.long	.L224-.L217
	.long	.L225-.L217
	.long	.L226-.L217
	.long	.L227-.L217
	.long	.L228-.L217
	.long	.L249-.L217
	.long	.L249-.L217
	.long	.L249-.L217
	.long	.L249-.L217
	.long	.L229-.L217
	.long	.L230-.L217
	.long	.L231-.L217
	.long	.L232-.L217
	.long	.L233-.L217
	.text
	.p2align 4,,10
.L228:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	je	.L253
	.p2align 4,,10
.L249:
	xorl	%ebx, %ebx
.L215:
	movl	%ebx, %eax
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L233:
	sarl	$8, %edx
	subl	$1, memc(%rip)
	movl	$1, %ebx
	movslq	%edx, %rcx
	bsrq	%rcx, %rcx
	xorq	$63, %rcx
	movslq	%ecx, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L216:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	andl	%r8d, %edx
	subl	$2, memc(%rip)
	sarl	$8, %edx
	movslq	%edx, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L218:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	orl	%r8d, %edx
	subl	$2, memc(%rip)
	sarl	$8, %edx
	movslq	%edx, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L219:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	xorl	%r8d, %edx
	subl	$2, memc(%rip)
	sarl	$8, %edx
	movslq	%edx, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L220:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %edx
	sarl	$8, %r8d
	subl	$2, memc(%rip)
	movslq	%edx, %rcx
	movslq	%r8d, %rax
	notq	%rcx
	andq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L221:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %edx
	sarl	$8, %r8d
	subl	$2, memc(%rip)
	movslq	%edx, %rcx
	movslq	%r8d, %rax
	addq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L222:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movslq	%r8d, %rcx
	movslq	%edx, %rax
	subq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L223:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %edx
	sarl	$8, %r8d
	subl	$2, memc(%rip)
	movslq	%edx, %rcx
	movslq	%r8d, %rax
	imulq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L224:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movslq	%r8d, %rax
	movslq	%edx, %rcx
	cqto
	idivq	%rcx
	movq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L225:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movl	%edx, %ecx
	movslq	%r8d, %rax
	salq	%cl, %rax
	movq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L226:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movl	%edx, %ecx
	movslq	%r8d, %rax
	sarq	%cl, %rax
	movq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L227:
	movzbl	%r8b, %ebx
	cmpl	$1, %ebx
	jne	.L249
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movl	%edx, %ecx
	movslq	%r8d, %rax
	shrq	%cl, %rax
	movq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L229:
	sarl	$8, %edx
	subl	$1, memc(%rip)
	movl	$1, %ebx
	movslq	%edx, %rcx
	notq	%rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L230:
	sarl	$8, %edx
	subl	$1, memc(%rip)
	movl	$1, %ebx
	movslq	%edx, %rcx
	negq	%rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L231:
	sarl	$8, %edx
	subl	$1, memc(%rip)
	movl	$1, %ebx
	movslq	%edx, %rcx
	movq	%rcx, %rax
	sarq	$63, %rax
	xorq	%rax, %rcx
	subq	%rax, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.p2align 4,,10
.L232:
	sarl	$8, %edx
	xorl	%ecx, %ecx
	movslq	%edx, %rdx
	testq	%rdx, %rdx
	je	.L234
	bsrq	%rdx, %rax
	movb	$63, %cl
	movl	$1, %r8d
	xorq	$63, %rax
	xorl	%r9d, %r9d
	subl	%eax, %ecx
	sarl	%ecx
	sall	%cl, %r8d
	movslq	%r8d, %r8
	.p2align 4,,10
.L236:
	leaq	(%r8,%r9,2), %rax
	salq	%cl, %rax
	cmpq	%rdx, %rax
	jg	.L235
	addq	%r8, %r9
	subq	%rax, %rdx
.L235:
	subl	$1, %ecx
	sarq	%r8
	cmpl	$-1, %ecx
	jne	.L236
	movq	%r9, %rcx
.L234:
	subl	$1, memc(%rip)
	movl	$1, %ebx
	call	_Z10compilaLITx
	jmp	.L215
.L253:
	sarl	$8, %r8d
	sarl	$8, %edx
	subl	$2, memc(%rip)
	movslq	%r8d, %rax
	movslq	%edx, %r8
	cqto
	idivq	%r8
	movq	%rdx, %rcx
	call	_Z10compilaLITx
	jmp	.L215
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely,"x"
.LCOLDB30:
	.text
.LHOTB30:
	.p2align 4,,15
	.globl	_Z10compilaMACi
	.def	_Z10compilaMACi;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z10compilaMACi
_Z10compilaMACi:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movslq	memc(%rip), %r10
	movl	lastblock(%rip), %eax
	xorl	%esi, %esi
	cmpl	%r10d, %eax
	je	.L255
	movq	memcode(%rip), %r8
	movslq	%r10d, %rdx
	movl	-4(%r8,%rdx,4), %esi
.L255:
	leal	-1(%r10), %r9d
	xorl	%edi, %edi
	cmpl	%r9d, %eax
	jge	.L256
	movq	memcode(%rip), %rdx
	movslq	%r10d, %rax
	movl	-8(%rdx,%rax,4), %edi
.L256:
	cmpl	$1, modo(%rip)
	jg	.L332
	testl	%ecx, %ecx
	movl	%ecx, %ebx
	jne	.L258
	movl	level(%rip), %eax
	testl	%eax, %eax
	je	.L333
	movl	cntdicc(%rip), %eax
	leaq	dicc(%rip), %rdx
	subl	$1, %eax
	cltq
	salq	$4, %rax
	orl	$4, 12(%rdx,%rax)
.L260:
	xorl	%ebp, %ebp
	cmpb	$3, %sil
	movl	$-38, %r12d
	je	.L334
.L274:
	cmpl	$4097, %esi
	movzbl	%sil, %eax
	jne	.L275
	leal	-52(%rbp), %edx
	movzbl	%sil, %eax
	cmpl	$1, %edx
	jbe	.L292
.L275:
	cmpl	$15, %r12d
	ja	.L278
	cmpl	$1, %eax
	je	.L335
.L278:
	leal	-59(%rbp), %edx
	cmpl	$3, %edx
	ja	.L279
	cmpl	$143, %eax
	je	.L336
	cmpl	$42, %eax
	je	.L337
.L281:
	cmpl	$1, %eax
	je	.L338
.L284:
	cmpl	$19, %edx
	jbe	.L339
	cmpl	$4, %eax
	jne	.L285
	subl	$123, %ebp
	cmpl	$10, %ebp
	jbe	.L340
	.p2align 4,,10
.L285:
	leal	1(%r10), %eax
	movl	%eax, memc(%rip)
	movq	memcode(%rip), %rax
	movl	%ebx, (%rax,%r10,4)
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L258:
	cmpl	$1, %ecx
	je	.L341
	cmpl	$2, %ecx
	je	.L342
	cmpl	$3, %ecx
	je	.L343
	cmpl	$4, %ecx
	je	.L344
	leal	-38(%rcx), %r12d
	movl	%ecx, %ebp
	cmpl	$20, %r12d
	ja	.L267
	cmpb	$1, %sil
	je	.L345
	cmpl	$47, %ecx
	je	.L274
.L273:
	cmpl	$38, %ebx
	jne	.L274
	movzbl	%sil, %eax
	cmpl	$1, %eax
	jne	.L274
.L291:
	cmpb	$-108, %dil
	jne	.L274
	testl	$-67108864, %esi
	jne	.L275
	movl	%esi, %eax
	movq	memcode(%rip), %rdx
	andl	$16128, %edi
	sall	$6, %eax
	andl	$-16384, %eax
	orb	$-88, %al
	orl	%edi, %eax
	movl	%eax, -8(%rdx,%r10,4)
	subl	$1, memc(%rip)
	jmp	.L254
	.p2align 4,,10
.L332:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	jmp	_Z7dataMACi
	.p2align 4,,10
.L333:
	movl	cntdicc(%rip), %eax
	leaq	dicc(%rip), %rdx
	movl	$0, modo(%rip)
	subl	$1, %eax
	cltq
	salq	$4, %rax
	addq	%rdx, %rax
	movl	%r10d, %edx
	subl	8(%rax), %edx
	cmpl	$3, %edx
	jg	.L260
	orl	$2, 12(%rax)
	jmp	.L260
	.p2align 4,,10
.L341:
	movslq	cntstacka(%rip), %rax
	addl	$1, level(%rip)
	movl	%r10d, lastblock(%rip)
	leal	1(%rax), %edx
	movl	%edx, cntstacka(%rip)
	leaq	stacka(%rip), %rdx
	movl	%r10d, (%rdx,%rax,4)
.L254:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L279:
	leal	-67(%rbp), %ecx
	cmpl	$3, %ecx
	ja	.L281
	cmpl	$143, %eax
	je	.L346
	cmpl	$42, %eax
	jne	.L281
	cmpb	$-109, %dil
	jne	.L284
	sarl	$8, %edi
	leal	-1(%rdi), %ecx
	cmpl	$2, %ecx
	ja	.L284
	leal	-12(%rbx,%rbx,2), %eax
	leal	-1(%rdi,%rax), %edx
	movq	memcode(%rip), %rax
	movl	%edx, -8(%rax,%r10,4)
	subl	$1, memc(%rip)
	jmp	.L254
	.p2align 4,,10
.L339:
	cmpl	$2, %eax
	je	.L347
	cmpl	$4, %eax
	jne	.L285
	leal	164(%rbx), %eax
	xorl	$4, %esi
	orl	%eax, %esi
	movq	memcode(%rip), %rax
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L267:
	leal	-10(%rcx), %eax
	cmpl	$7, %eax
	ja	.L270
	movzbl	%sil, %eax
	cmpl	$1, %eax
	je	.L348
.L271:
	cmpl	$4097, %esi
	jne	.L278
	leal	-52(%rbx), %edx
	cmpl	$1, %edx
	ja	.L278
.L292:
	cmpb	$1, %dil
	je	.L349
	movq	memcode(%rip), %rax
	addl	$105, %ebx
	movl	%ebx, -4(%rax,%r10,4)
	jmp	.L254
.L270:
	cmpl	$47, %ecx
	jne	.L273
	movzbl	%sil, %eax
	cmpl	$1, %eax
	jne	.L271
.L290:
	cmpb	$-109, %dil
	jne	.L274
	movl	%esi, %eax
	movq	memcode(%rip), %rdx
	andl	$65280, %edi
	sall	$8, %eax
	andl	$16711680, %eax
	orb	$-89, %al
	orl	%edi, %eax
	movl	%eax, -8(%rdx,%r10,4)
	subl	$1, memc(%rip)
	jmp	.L254
	.p2align 4,,10
.L334:
	movq	memcode(%rip), %rax
	xorl	$3, %esi
	orb	$-122, %sil
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L338:
	cmpl	$81, %ebx
	sete	%al
	cmpl	$96, %ebx
	je	.L298
	testb	%al, %al
	je	.L285
.L298:
	sall	$31, %eax
	movq	memcode(%rip), %rdx
	xorl	$1, %esi
	sarl	$31, %eax
	addl	$202, %eax
	orl	%esi, %eax
	movl	%eax, -4(%rdx,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L340:
	movq	memcode(%rip), %rax
	xorl	$4, %esi
	orl	%esi, %ebx
	movl	%ebx, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L345:
	movl	%edi, %r8d
	movl	%esi, %edx
	call	_Z9constfoldiii
	cmpl	$1, %eax
	je	.L254
	cmpl	$47, %ebx
	movslq	memc(%rip), %r10
	je	.L290
	jmp	.L273
.L349:
	movq	memcode(%rip), %rax
	andb	$0, %dil
	addl	$103, %ebx
	orl	%ebx, %edi
	movl	%edi, -8(%rax,%r10,4)
	subl	$1, memc(%rip)
	jmp	.L254
	.p2align 4,,10
.L348:
	movl	%esi, %edx
	movl	%esi, %ecx
	sall	$8, %edx
	sarl	$8, %ecx
	movl	%edx, %r8d
	sarl	$16, %r8d
	cmpl	%ecx, %r8d
	je	.L350
	cmpl	$38, %ebx
	jne	.L271
	jmp	.L291
	.p2align 4,,10
.L342:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	jmp	_Z8blockOutv
	.p2align 4,,10
.L343:
	movl	cntdicc(%rip), %eax
	leaq	dicc(%rip), %rdx
	subl	$1, %eax
	cltq
	salq	$4, %rax
	orl	$4, 12(%rdx,%rax)
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	jmp	_Z6anonInv
	.p2align 4,,10
.L344:
	movl	cntdicc(%rip), %eax
	leaq	dicc(%rip), %rdx
	subl	$1, %eax
	cltq
	salq	$4, %rax
	orl	$4, 12(%rdx,%rax)
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	jmp	_Z7anonOutv
	.p2align 4,,10
.L337:
	cmpb	$-109, %dil
	jne	.L285
	sarl	$8, %edi
	leal	-1(%rdi), %eax
	cmpl	$2, %eax
	ja	.L285
	leal	(%rbx,%rbx,2), %eax
	leal	-1(%rdi,%rax), %edx
	movq	memcode(%rip), %rax
	movl	%edx, -8(%rax,%r10,4)
	subl	$1, memc(%rip)
	jmp	.L254
	.p2align 4,,10
.L335:
	leal	101(%rbx), %ecx
	movq	memcode(%rip), %rax
	xorl	$1, %esi
	orl	%ecx, %esi
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L336:
	leal	110(%rbx), %ecx
	movq	memcode(%rip), %rax
	xorb	$-113, %sil
	orl	%ecx, %esi
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L346:
	leal	106(%rbx), %ecx
	movq	memcode(%rip), %rax
	xorb	$-113, %sil
	orl	%ecx, %esi
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
	.p2align 4,,10
.L347:
	leal	144(%rbx), %ecx
	movq	memcode(%rip), %rax
	xorl	$2, %esi
	orl	%ecx, %esi
	movl	%esi, -4(%rax,%r10,4)
	jmp	.L254
.L350:
	movq	memcode(%rip), %rax
	xorw	%dx, %dx
	addl	$149, %ebx
	orl	%ebx, %edx
	movl	%edx, -4(%rax,%r10,4)
	jmp	.L254
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely,"x"
.LCOLDB31:
	.text
.LHOTB31:
	.p2align 4,,15
	.globl	_Z13compilainlinei
	.def	_Z13compilainlinei;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z13compilainlinei
_Z13compilainlinei:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	memcode(%rip), %rdx
	movslq	%ecx, %rcx
	leaq	0(,%rcx,4), %rbx
	movl	(%rdx,%rcx,4), %ecx
	testl	%ecx, %ecx
	je	.L351
	cmpb	$-122, %cl
	je	.L353
	addq	$4, %rbx
	jmp	.L356
	.p2align 4,,10
.L354:
	movslq	memc(%rip), %rax
	leal	1(%rax), %r8d
	movl	%r8d, memc(%rip)
	movl	%ecx, (%rdx,%rax,4)
	movl	(%rdx,%rbx), %ecx
	testl	%ecx, %ecx
	je	.L351
.L368:
	addq	$4, %rbx
	cmpb	$-122, %cl
	je	.L353
.L356:
	leal	-38(%rcx), %eax
	cmpl	$58, %eax
	ja	.L354
	call	_Z10compilaMACi
	movq	memcode(%rip), %rdx
	movl	(%rdx,%rbx), %ecx
	testl	%ecx, %ecx
	jne	.L368
.L351:
	addq	$32, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
.L353:
	movslq	memc(%rip), %rax
	xorb	$-122, %cl
	orl	$3, %ecx
	leal	1(%rax), %r8d
	movl	%r8d, memc(%rip)
	movl	%ecx, (%rdx,%rax,4)
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE31:
	.text
.LHOTE31:
	.section	.text.unlikely,"x"
.LCOLDB32:
	.text
.LHOTB32:
	.p2align 4,,15
	.globl	_Z11compilaWORDi
	.def	_Z11compilaWORDi;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z11compilaWORDi
_Z11compilaWORDi:
	.seh_endprologue
	cmpl	$1, modo(%rip)
	movslq	%ecx, %rcx
	jg	.L372
	leaq	dicc(%rip), %rax
	salq	$4, %rcx
	addq	%rax, %rcx
	movl	12(%rcx), %eax
	movl	%eax, %edx
	andl	$6, %edx
	cmpl	$2, %edx
	je	.L373
	movl	8(%rcx), %edx
	sarl	$4, %eax
	andl	$1, %eax
	sall	$8, %edx
	leal	3(%rdx,%rax), %ecx
	movslq	memc(%rip), %rax
	leal	1(%rax), %edx
	movl	%edx, memc(%rip)
	movq	memcode(%rip), %rdx
	movl	%ecx, (%rdx,%rax,4)
	ret
	.p2align 4,,10
.L372:
	jmp	_Z7datanrox
	.p2align 4,,10
.L373:
	movl	8(%rcx), %ecx
	jmp	_Z13compilainlinei
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE32:
	.text
.LHOTE32:
	.section	.text.unlikely,"x"
.LCOLDB33:
	.text
.LHOTB33:
	.p2align 4,,15
	.globl	_Z8seterrorPcS_
	.def	_Z8seterrorPcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8seterrorPcS_
_Z8seterrorPcS_:
	.seh_endprologue
	movq	%rdx, werror(%rip)
	movq	%rcx, cerror(%rip)
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE33:
	.text
.LHOTE33:
	.section .rdata,"dr"
.LC34:
	.ascii "FILE:%s LINE:%d CHAR:%d\12\12\0"
.LC35:
	.ascii "%4d|%s\12     \0"
.LC36:
	.ascii "^- %s\12\0"
	.section	.text.unlikely,"x"
.LCOLDB37:
	.text
.LHOTB37:
	.p2align 4,,15
	.globl	_Z10printerrorPcS_
	.def	_Z10printerrorPcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z10printerrorPcS_
_Z10printerrorPcS_:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$1080, %rsp
	.seh_stackalloc	1080
	.seh_endprologue
	movl	$1, %esi
	movq	%rcx, %rdi
	movq	cerror(%rip), %rcx
	movq	%rdx, %rbx
	cmpq	%rcx, %rdx
	jb	.L382
	jmp	.L376
	.p2align 4,,10
.L377:
	cmpb	$13, %al
	je	.L380
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	jbe	.L376
.L382:
	movzbl	(%rdx), %eax
	cmpb	$10, %al
	jne	.L377
	cmpb	$13, 1(%rdx)
.L411:
	sete	%al
	addl	$1, %esi
	movzbl	%al, %eax
	leaq	1(%rdx,%rax), %rbx
	movq	%rbx, %rdx
	cmpq	%rdx, %rcx
	ja	.L382
.L376:
	movzbl	(%rbx), %eax
	cmpb	$31, %al
	ja	.L401
	cmpb	$9, %al
	jne	.L398
.L401:
	movq	%rbx, %rax
	.p2align 4,,10
.L407:
	addq	$1, %rax
	movzbl	(%rax), %edx
	cmpb	$31, %dl
	ja	.L407
	cmpb	$9, %dl
	je	.L407
.L383:
	movb	$0, (%rax)
	movzbl	(%rbx), %eax
	cmpb	$9, %al
	je	.L402
	cmpb	$31, %al
	jle	.L399
.L402:
	leaq	48(%rsp), %r12
	movq	%rbx, %r10
	movq	%r12, %rdx
	.p2align 4,,10
.L408:
	addq	$1, %rdx
	addq	$1, %r10
	movb	%al, -1(%rdx)
	movzbl	(%r10), %eax
	cmpb	$9, %al
	je	.L408
	cmpb	$31, %al
	jg	.L408
.L386:
	movzbl	(%rdi), %eax
	movb	$0, (%rdx)
	cmpb	$31, %al
	ja	.L403
	cmpb	$9, %al
	jne	.L400
.L403:
	movq	%rdi, %rax
	.p2align 4,,10
.L409:
	addq	$1, %rax
	movzbl	(%rax), %edx
	cmpb	$31, %dl
	ja	.L409
	cmpb	$9, %dl
	je	.L409
.L389:
	movb	$0, (%rax)
	movq	cerror(%rip), %r13
	movq	__imp___iob_func(%rip), %rbp
	call	*%rbp
	subq	%rbx, %r13
	leaq	96(%rax), %rcx
	leaq	.LC34(%rip), %rdx
	movl	%esi, %r9d
	movq	%rdi, %r8
	movq	%r13, 32(%rsp)
	call	fprintf
	call	*%rbp
	leaq	.LC35(%rip), %rdx
	leaq	96(%rax), %rcx
	movq	%r12, %r9
	movl	%esi, %r8d
	call	fprintf
	cmpq	cerror(%rip), %rbx
	jb	.L404
	jmp	.L396
	.p2align 4,,10
.L393:
	call	*%rbp
	leaq	96(%rax), %rdx
	movl	$32, %ecx
	addq	$1, %rbx
	call	fputc
	cmpq	%rbx, cerror(%rip)
	jbe	.L396
.L404:
	cmpb	$9, (%rbx)
	jne	.L393
	call	*%rbp
	leaq	96(%rax), %rdx
	movl	$9, %ecx
	addq	$1, %rbx
	call	fputc
	cmpq	%rbx, cerror(%rip)
	ja	.L404
.L396:
	movq	werror(%rip), %rbx
	call	*%rbp
	leaq	.LC36(%rip), %rdx
	leaq	96(%rax), %rcx
	movq	%rbx, %r8
	call	fprintf
	nop
	addq	$1080, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L380:
	cmpb	$10, 1(%rdx)
	jmp	.L411
.L400:
	movq	%rdi, %rax
	jmp	.L389
.L398:
	movq	%rbx, %rax
	jmp	.L383
.L399:
	leaq	48(%rsp), %r12
	movq	%r12, %rdx
	jmp	.L386
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE37:
	.text
.LHOTE37:
	.section .rdata,"dr"
.LC38:
	.ascii "|WIN|\0"
	.section	.text.unlikely,"x"
.LCOLDB39:
	.text
.LHOTB39:
	.p2align 4,,15
	.globl	_Z7nextcomPc
	.def	_Z7nextcomPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7nextcomPc
_Z7nextcomPc:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	.LC38(%rip), %rdx
	movl	$5, %r8d
	movq	%rcx, %rbx
	call	strnicmp
	testl	%eax, %eax
	leaq	5(%rbx), %rdx
	jne	.L425
	jmp	.L417
	.p2align 4,,10
.L421:
	addq	$1, %rbx
.L425:
	movzbl	(%rbx), %eax
	cmpb	$31, %al
	ja	.L421
	cmpb	$9, %al
	je	.L421
	movq	%rbx, %rdx
.L417:
	movq	%rdx, %rax
	addq	$32, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE39:
	.text
.LHOTE39:
	.section .rdata,"dr"
.LC40:
	.ascii "adr not found\0"
.LC41:
	.ascii "Bad block\0"
.LC42:
	.ascii "word not found\0"
	.section	.text.unlikely,"x"
.LCOLDB43:
	.text
.LHOTB43:
	.p2align 4,,15
	.globl	_Z7r3tokenPc
	.def	_Z7r3tokenPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7r3tokenPc
_Z7r3tokenPc:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$0, level(%rip)
	movzbl	(%rcx), %eax
	movq	%rcx, %rbx
	.p2align 4,,10
.L428:
	testb	%al, %al
	je	.L472
.L501:
	leal	-1(%rax), %edx
	cmpb	$31, %dl
	ja	.L464
	.p2align 4,,10
.L478:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	leal	-1(%rax), %edx
	cmpb	$31, %dl
	jbe	.L478
	testb	%al, %al
	je	.L472
.L464:
	cmpb	$39, %al
	je	.L432
	jle	.L498
	cmpb	$94, %al
	je	.L492
	cmpb	$124, %al
	je	.L437
	cmpb	$58, %al
	je	.L499
.L431:
	movq	%rbx, %rcx
	call	_Z5isNroPc
	testl	%eax, %eax
	je	.L500
.L452:
	movq	nro(%rip), %rcx
	call	_Z10compilaLITx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	jbe	.L428
	.p2align 4,,10
.L477:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L477
	testb	%al, %al
	jne	.L501
	.p2align 4,,10
.L472:
	movl	$-1, %esi
.L488:
	movl	%esi, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
.L486:
	addq	$1, %rbx
.L492:
	movzbl	(%rbx), %eax
	cmpb	$31, %al
	ja	.L486
	cmpb	$9, %al
	je	.L486
	jmp	.L428
	.p2align 4,,10
.L498:
	cmpb	$34, %al
	je	.L434
	cmpb	$35, %al
	jne	.L431
	movq	%rbx, %rcx
	call	_Z11compilaDATAPc
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	jbe	.L428
	.p2align 4,,10
.L448:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L448
	jmp	.L428
	.p2align 4,,10
.L432:
	leaq	1(%rbx), %rsi
	movq	%rsi, %rcx
	call	_Z6isWordPc
	movslq	%eax, %rdx
	testq	%rdx, %rdx
	movq	%rdx, nro(%rip)
	js	.L502
	movl	%eax, %ecx
	call	_Z11compilaADDRi
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L451
	jmp	.L428
	.p2align 4,,10
.L503:
	addq	$1, %rsi
.L451:
	movzbl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpb	$32, %al
	ja	.L503
	jmp	.L428
	.p2align 4,,10
.L434:
	movq	%rbx, %rcx
	call	_Z10compilaSTRPc
	movzbl	1(%rbx), %eax
	leaq	1(%rbx), %rdx
	testb	%al, %al
	je	.L472
	movq	%rdx, %rbx
	jmp	.L444
	.p2align 4,,10
.L443:
	movzbl	1(%rdx), %eax
	leaq	1(%rdx), %rbx
	testb	%al, %al
	je	.L472
.L444:
	cmpb	$34, %al
	movq	%rbx, %rdx
	jne	.L443
	cmpb	$34, 1(%rbx)
	leaq	1(%rbx), %rdx
	je	.L443
	movzbl	2(%rbx), %eax
	addq	$2, %rbx
	jmp	.L428
.L499:
	movq	%rbx, %rcx
	call	_Z11compilaCODEPc
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	jbe	.L428
	.p2align 4,,10
.L446:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L446
	jmp	.L428
	.p2align 4,,10
.L437:
	movq	%rbx, %rcx
	call	_Z7nextcomPc
	movq	%rax, %rbx
	movzbl	(%rax), %eax
	jmp	.L428
.L500:
	movq	%rbx, %rcx
	call	_Z6isNrofPc
	testl	%eax, %eax
	movl	%eax, %esi
	jne	.L452
	movq	%rbx, %rcx
	call	_Z5isBasPc
	testl	%eax, %eax
	je	.L504
	movl	nro(%rip), %ecx
	call	_Z10compilaMACi
	cmpb	$32, (%rbx)
	jbe	.L455
	.p2align 4,,10
.L456:
	addq	$1, %rbx
	cmpb	$32, (%rbx)
	ja	.L456
.L455:
	movl	level(%rip), %eax
	testl	%eax, %eax
	js	.L457
	movzbl	(%rbx), %eax
	jmp	.L428
.L504:
	movq	%rbx, %rcx
	call	_Z6isWordPc
	movslq	%eax, %rdx
	testq	%rdx, %rdx
	movq	%rdx, nro(%rip)
	js	.L505
	cmpl	$1, modo(%rip)
	movl	%eax, %ecx
	je	.L506
	call	_Z11compilaADDRi
	jmp	.L493
	.p2align 4,,10
.L462:
	addq	$1, %rbx
.L493:
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L462
	jmp	.L428
.L506:
	call	_Z11compilaWORDi
	jmp	.L493
.L502:
	leaq	.LC40(%rip), %rax
	movq	%rbx, cerror(%rip)
	xorl	%esi, %esi
	movq	%rax, werror(%rip)
	jmp	.L488
.L505:
	leaq	.LC42(%rip), %rax
	movq	%rbx, cerror(%rip)
	movq	%rax, werror(%rip)
	jmp	.L488
.L457:
	leaq	.LC41(%rip), %rax
	movq	%rbx, cerror(%rip)
	movq	%rax, werror(%rip)
	jmp	.L488
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE43:
	.text
.LHOTE43:
	.section .rdata,"dr"
.LC44:
	.ascii "rb\0"
	.align 8
.LC45:
	.ascii "FILE:%s LINE:%d CHAR:%d\12\12%s not found\12\0"
	.section	.text.unlikely,"x"
.LCOLDB46:
	.text
.LHOTB46:
	.p2align 4,,15
	.globl	_Z8openfilePcS_
	.def	_Z8openfilePcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8openfilePcS_
_Z8openfilePcS_:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rdx, %rsi
	leaq	.LC44(%rip), %rdx
	movq	%rcx, %rdi
	movq	%rsi, %rcx
	call	fopen
	testq	%rax, %rax
	movq	%rax, %rbx
	je	.L517
	xorl	%edx, %edx
	movl	$2, %r8d
	movq	%rax, %rcx
	call	fseek
	movq	%rbx, %rcx
	call	ftell
	xorl	%r8d, %r8d
	xorl	%edx, %edx
	movslq	%eax, %rdi
	movq	%rbx, %rcx
	call	fseek
	leal	1(%rdi), %ecx
	movslq	%ecx, %rcx
	call	malloc
	testq	%rax, %rax
	movq	%rax, %rsi
	je	.L514
	movq	%rbx, %r9
	movq	%rdi, %r8
	movl	$1, %edx
	movq	%rax, %rcx
	call	fread
	movq	%rbx, %rcx
	call	fclose
	movb	$0, (%rsi,%rdi)
	movq	%rsi, %rax
.L512:
	addq	$48, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
.L517:
	movzbl	(%rdi), %eax
	cmpb	$31, %al
	ja	.L515
	cmpb	$9, %al
	jne	.L513
.L515:
	movq	%rdi, %rax
	.p2align 4,,10
.L516:
	addq	$1, %rax
	movzbl	(%rax), %edx
	cmpb	$31, %dl
	ja	.L516
	cmpb	$9, %dl
	je	.L516
.L509:
	movb	$0, (%rax)
	movq	cerror(%rip), %rbx
	call	*__imp___iob_func(%rip)
	leaq	.LC45(%rip), %rdx
	leaq	96(%rax), %rcx
	movq	%rsi, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%rbx, %r9
	movq	%rdi, %r8
	call	fprintf
	movq	$1, cerror(%rip)
	xorl	%eax, %eax
	jmp	.L512
	.p2align 4,,10
.L514:
	xorl	%eax, %eax
	jmp	.L512
.L513:
	movq	%rdi, %rax
	jmp	.L509
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE46:
	.text
.LHOTE46:
	.section	.text.unlikely,"x"
.LCOLDB47:
	.text
.LHOTB47:
	.p2align 4,,15
	.globl	_Z9isincludePcS_
	.def	_Z9isincludePcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z9isincludePcS_
_Z9isincludePcS_:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$1056, %rsp
	.seh_stackalloc	1056
	.seh_endprologue
	movzbl	(%rdx), %esi
	movq	%rcx, %rbp
	movq	%rdx, %rbx
	cmpb	$46, %sil
	je	.L519
	leaq	32(%rsp), %rdi
	movl	%esi, %edx
	movq	%rbx, %r12
	movq	%rdi, %rax
	jmp	.L541
	.p2align 4,,10
.L534:
	addq	$1, %rax
	addq	$1, %r12
	movb	%dl, -1(%rax)
	movzbl	(%r12), %edx
.L541:
	cmpb	$31, %dl
	ja	.L534
	movslq	cntincludes(%rip), %rcx
	movb	$0, (%rax)
	leaq	includes(%rip), %r12
	testl	%ecx, %ecx
	jle	.L525
	leal	-1(%rcx), %edx
	movq	%r12, %r11
	addq	$1, %rdx
	salq	$4, %rdx
	addq	%r12, %rdx
	.p2align 4,,10
.L530:
	movq	(%r11), %r9
	movl	%esi, %r8d
	movq	%rbx, %r10
	jmp	.L526
	.p2align 4,,10
.L528:
	andl	$-33, %r8d
	andl	$-33, %eax
	addq	$1, %r10
	addq	$1, %r9
	cmpb	%al, %r8b
	jne	.L527
	movzbl	(%r10), %r8d
.L526:
	movzbl	(%r9), %eax
	cmpb	$32, %al
	ja	.L528
	cmpb	$32, %r8b
	ja	.L527
	movl	$-1, %eax
	addq	$1056, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L527:
	addq	$16, %r11
	cmpq	%rdx, %r11
	jne	.L530
.L525:
	salq	$4, %rcx
	movq	%rdi, %rdx
	addq	%rcx, %r12
	movq	%rbp, %rcx
	movq	%rbx, (%r12)
	call	_Z8openfilePcS_
	movq	%rax, 8(%r12)
	movl	cntincludes(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, cntincludes(%rip)
	addq	$1056, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
.L519:
	leaq	32(%rsp), %rdi
	leaq	1(%rdx), %r12
	leaq	path(%rip), %rdx
	movq	%rdi, %rcx
	call	strcpy
	cmpb	$0, 32(%rsp)
	movq	%rdi, %rax
	je	.L540
	.p2align 4,,10
.L535:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L535
.L540:
	movzbl	1(%rbx), %edx
	jmp	.L541
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE47:
	.text
.LHOTE47:
	.section	.text.unlikely,"x"
.LCOLDB48:
	.text
.LHOTB48:
	.p2align 4,,15
	.globl	_Z7freeincv
	.def	_Z7freeincv;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z7freeincv
_Z7freeincv:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movslq	cntincludes(%rip), %rax
	xorl	%ebx, %ebx
	leaq	includes(%rip), %rsi
	testl	%eax, %eax
	jle	.L542
	.p2align 4,,10
.L546:
	salq	$4, %rax
	addl	$1, %ebx
	movq	8(%rsi,%rax), %rcx
	call	free
	movslq	cntincludes(%rip), %rax
	cmpl	%ebx, %eax
	jg	.L546
.L542:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE48:
	.text
.LHOTE48:
	.section .rdata,"dr"
.LC49:
	.ascii "|MEM \0"
	.section	.text.unlikely,"x"
.LCOLDB50:
	.text
.LHOTB50:
	.p2align 4,,15
	.globl	_Z6syscomPc
	.def	_Z6syscomPc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z6syscomPc
_Z6syscomPc:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	leaq	.LC49(%rip), %rdx
	movl	$5, %r8d
	movq	%rcx, %rbx
	call	strnicmp
	testl	%eax, %eax
	jne	.L550
	movzbl	5(%rbx), %eax
	leaq	5(%rbx), %rcx
	subl	$1, %eax
	cmpb	$31, %al
	ja	.L551
	.p2align 4,,10
.L552:
	addq	$1, %rcx
	movzbl	(%rcx), %eax
	subl	$1, %eax
	cmpb	$31, %al
	jbe	.L552
.L551:
	call	_Z5isNroPc
	testl	%eax, %eax
	je	.L550
	movq	nro(%rip), %rax
	movl	$1048576, %edx
	salq	$20, %rax
	cmpl	$1048576, %eax
	cmovl	%edx, %eax
	movl	%eax, memdsize(%rip)
.L550:
	movq	%rbx, %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	_Z7nextcomPc
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE50:
	.text
.LHOTE50:
	.section	.text.unlikely,"x"
.LCOLDB51:
	.text
.LHOTB51:
	.p2align 4,,15
	.globl	_Z10r3includesPcS_
	.def	_Z10r3includesPcS_;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z10r3includesPcS_
_Z10r3includesPcS_:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	testq	%rdx, %rdx
	movq	%rcx, %rdi
	movq	%rdx, %rbx
	je	.L559
	movzbl	(%rdx), %eax
	leaq	includes(%rip), %rbp
	.p2align 4,,10
.L561:
	testb	%al, %al
	jne	.L608
	jmp	.L559
	.p2align 4,,10
.L596:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
.L608:
	leal	-1(%rax), %edx
	cmpb	$31, %dl
	jbe	.L596
	cmpb	$58, %al
	je	.L564
	jg	.L565
	cmpb	$34, %al
	je	.L566
	cmpb	$35, %al
	jne	.L563
	movl	$0, modo(%rip)
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	jbe	.L561
	.p2align 4,,10
.L578:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L578
	testb	%al, %al
	jne	.L608
	.p2align 4,,10
.L559:
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
.L565:
	cmpb	$94, %al
	je	.L568
	cmpb	$124, %al
	jne	.L563
	movq	%rbx, %rcx
	call	_Z6syscomPc
	movq	%rax, %rbx
	movzbl	(%rax), %eax
	jmp	.L561
	.p2align 4,,10
.L564:
	movl	$1, modo(%rip)
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	jbe	.L561
	.p2align 4,,10
.L576:
	addq	$1, %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L576
	jmp	.L561
	.p2align 4,,10
.L563:
	movl	modo(%rip), %eax
	addl	%eax, memcsize(%rip)
	cmpb	$32, (%rbx)
	jbe	.L581
	.p2align 4,,10
.L582:
	addq	$1, %rbx
	cmpb	$32, (%rbx)
	ja	.L582
.L581:
	movzbl	(%rbx), %eax
	jmp	.L561
	.p2align 4,,10
.L566:
	movl	modo(%rip), %eax
	addl	%eax, memcsize(%rip)
	leaq	1(%rbx), %rdx
	movzbl	1(%rbx), %eax
	testb	%al, %al
	je	.L559
	movq	%rdx, %rbx
	jmp	.L580
	.p2align 4,,10
.L579:
	movzbl	1(%rdx), %eax
	leaq	1(%rdx), %rbx
	testb	%al, %al
	je	.L559
.L580:
	cmpb	$34, %al
	movq	%rbx, %rdx
	jne	.L579
	cmpb	$34, 1(%rbx)
	leaq	1(%rbx), %rdx
	je	.L579
	movq	%rbx, %rax
	addq	$2, %rbx
	movzbl	2(%rax), %eax
	jmp	.L561
	.p2align 4,,10
.L568:
	leaq	1(%rbx), %rsi
	movq	%rdi, %rcx
	movq	%rsi, %rdx
	call	_Z9isincludePcS_
	testl	%eax, %eax
	movl	%eax, %r12d
	js	.L570
	movslq	%eax, %rcx
	salq	$4, %rcx
	addq	%rbp, %rcx
	movq	8(%rcx), %rdx
	movq	(%rcx), %rcx
	call	_Z10r3includesPcS_
	movslq	cntstacki(%rip), %rax
	leal	1(%rax), %edx
	movl	%edx, cntstacki(%rip)
	leaq	stacki(%rip), %rdx
	movl	%r12d, (%rdx,%rax,4)
.L570:
	movzbl	(%rbx), %eax
	cmpb	$31, %al
	ja	.L602
	cmpb	$9, %al
	je	.L602
	jmp	.L561
	.p2align 4,,10
.L609:
	addq	$1, %rsi
.L602:
	movzbl	(%rsi), %eax
	movq	%rsi, %rbx
	cmpb	$31, %al
	ja	.L609
	cmpb	$9, %al
	je	.L609
	jmp	.L561
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE51:
	.text
.LHOTE51:
	.section .rdata,"dr"
.LC52:
	.ascii "\12r3vm - PHREDA\0"
.LC53:
	.ascii "compile:%s...\0"
.LC54:
	.ascii " ok.\0"
	.align 8
.LC55:
	.ascii "inc:%d - words:%d - code:%dKb - data:%dKb\12\12\0"
	.section	.text.unlikely,"x"
.LCOLDB56:
	.text
.LHOTB56:
	.p2align 4,,15
	.globl	_Z9r3compilePc
	.def	_Z9r3compilePc;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z9r3compilePc
_Z9r3compilePc:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	movq	%rcx, %rbx
	leaq	.LC52(%rip), %rcx
	call	puts
	leaq	.LC53(%rip), %rcx
	movq	%rbx, %rdx
	call	printf
	leaq	path(%rip), %rcx
	movq	%rbx, %rdx
	call	strcpy
	leaq	path(%rip), %rcx
	movq	%rcx, %r9
	movq	%rcx, %rax
.L611:
	movl	(%rax), %edx
	addq	$4, %rax
	leal	-16843009(%rdx), %r8d
	notl	%edx
	andl	%edx, %r8d
	andl	$-2139062144, %r8d
	je	.L611
	movl	%r8d, %edx
	shrl	$16, %edx
	testl	$32896, %r8d
	cmove	%edx, %r8d
	leaq	2(%rax), %rdx
	cmove	%rdx, %rax
	addb	%r8b, %r8b
	sbbq	$3, %rax
	subq	%rcx, %rax
	addq	%r9, %rax
	cmpq	%r9, %rax
	jbe	.L613
	movzbl	(%rax), %edx
	cmpb	$92, %dl
	je	.L614
	cmpb	$47, %dl
	jne	.L616
	jmp	.L614
	.p2align 4,,10
.L618:
	movzbl	(%rax), %r8d
	cmpb	$92, %r8b
	je	.L614
	cmpb	$47, %r8b
	je	.L614
.L616:
	subq	$1, %rax
	cmpq	%r9, %rax
	jne	.L618
.L613:
	movq	%rbx, %rdx
	movq	%rbx, %rcx
	call	_Z8openfilePcS_
	testq	%rax, %rax
	movq	%rax, %rsi
	je	.L621
	movq	%rax, %rdx
	movq	%rbx, %rcx
	movl	$0, memcsize(%rip)
	movl	$0, cntincludes(%rip)
	movl	$0, cntstacki(%rip)
	call	_Z10r3includesPcS_
	cmpq	$0, cerror(%rip)
	je	.L635
.L621:
	xorl	%eax, %eax
.L620:
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L614:
	movb	$0, (%rax)
	jmp	.L613
.L635:
	movslq	memcsize(%rip), %rcx
	movl	$0, cntdicc(%rip)
	movl	$0, dicclocal(%rip)
	movl	$-1, boot(%rip)
	movl	$1, memc(%rip)
	movl	$0, memd(%rip)
	salq	$2, %rcx
	call	malloc
	movslq	memdsize(%rip), %rcx
	movq	%rax, memcode(%rip)
	call	malloc
	movq	%rax, memdata(%rip)
	movl	cntstacki(%rip), %eax
	testl	%eax, %eax
	jle	.L627
	leaq	stacki(%rip), %r12
	xorl	%edi, %edi
	leaq	includes(%rip), %r13
	movq	%r12, %rbp
	jmp	.L626
	.p2align 4,,10
.L625:
	addl	$1, %edi
	addq	$4, %rbp
	cmpl	%edi, cntstacki(%rip)
	movl	cntdicc(%rip), %eax
	movl	%eax, dicclocal(%rip)
	jle	.L627
.L626:
	movslq	0(%rbp), %r8
	salq	$4, %r8
	movq	8(%r13,%r8), %rcx
	call	_Z7r3tokenPc
	testl	%eax, %eax
	jne	.L625
	movslq	%edi, %rdi
	movl	%eax, 60(%rsp)
	movslq	(%r12,%rdi,4), %rdx
	movq	%rdx, %rcx
	leaq	includes(%rip), %rdx
	salq	$4, %rcx
	addq	%rdx, %rcx
	movq	8(%rcx), %rdx
	movq	(%rcx), %rcx
	call	_Z10printerrorPcS_
	movl	60(%rsp), %eax
	jmp	.L620
.L627:
	movq	%rsi, %rcx
	call	_Z7r3tokenPc
	testl	%eax, %eax
	jne	.L636
	leaq	path(%rip), %rcx
	movq	%rsi, %rdx
	movl	%eax, 60(%rsp)
	call	_Z10printerrorPcS_
	movl	60(%rsp), %eax
	jmp	.L620
.L636:
	leaq	.LC54(%rip), %rcx
	call	puts
	movl	memd(%rip), %eax
	movl	memc(%rip), %r9d
	leaq	.LC55(%rip), %rcx
	movl	cntdicc(%rip), %r8d
	movl	cntincludes(%rip), %edx
	sarl	$10, %eax
	sarl	$8, %r9d
	movl	%eax, 32(%rsp)
	call	printf
	call	_Z7freeincv
	movq	%rsi, %rcx
	call	free
	movl	$-1, %eax
	jmp	.L620
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE56:
	.text
.LHOTE56:
	.section	.text.unlikely,"x"
.LCOLDB57:
	.text
.LHOTB57:
	.p2align 4,,15
	.globl	_Z8memset32Pjjj
	.def	_Z8memset32Pjjj;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8memset32Pjjj
_Z8memset32Pjjj:
	.seh_endprologue
	leal	-1(%r8), %eax
	testl	%r8d, %r8d
	leaq	4(%rcx,%rax,4), %rax
	je	.L637
	.p2align 4,,10
.L639:
	addq	$4, %rcx
	movl	%edx, -4(%rcx)
	cmpq	%rax, %rcx
	jne	.L639
.L637:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE57:
	.text
.LHOTE57:
	.section	.text.unlikely,"x"
.LCOLDB58:
	.text
.LHOTB58:
	.p2align 4,,15
	.globl	_Z8memset64Pyyj
	.def	_Z8memset64Pyyj;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z8memset64Pyyj
_Z8memset64Pyyj:
	.seh_endprologue
	leal	-1(%r8), %eax
	testl	%r8d, %r8d
	leaq	8(%rcx,%rax,8), %rax
	je	.L642
	.p2align 4,,10
.L644:
	addq	$8, %rcx
	movq	%rdx, -8(%rcx)
	cmpq	%rax, %rcx
	jne	.L644
.L642:
	rep ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE58:
	.text
.LHOTE58:
	.section	.text.unlikely,"x"
.LCOLDB59:
	.text
.LHOTB59:
	.p2align 4,,15
	.globl	_Z5runr3i
	.def	_Z5runr3i;	.scl	2;	.type	32;	.endef
	.seh_proc	_Z5runr3i
_Z5runr3i:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_endprologue
	movq	memcode(%rip), %r11
	leaq	_ZZ5runr3iE14dispatch_table(%rip), %r15
	movq	$0, 2040+stack(%rip)
	leal	1(%rcx), %ebx
	movslq	%ecx, %rcx
	xorl	%edi, %edi
	xorl	%esi, %esi
	leaq	2040+stack(%rip), %rbp
	leaq	stack(%rip), %r14
	movslq	(%r11,%rcx,4), %rax
	xorl	%r10d, %r10d
	movabsq	$281474976710655, %r12
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L924:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	addl	%r10d, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L649:
	movq	0(%rbp), %rax
	addq	$8, %rbp
	testl	%eax, %eax
	je	.L945
	leal	1(%rax), %ebx
	cltq
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L653:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L654:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movslq	%ebx, %rax
	addq	memdata(%rip), %rcx
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L655:
	movl	%eax, %ecx
	movslq	%ebx, %rbx
	subq	$8, %rbp
	shrl	$8, %ecx
	movq	%rbx, 0(%rbp)
	movl	%ecx, %eax
	leal	1(%rcx), %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L656:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movq	(%rax,%rcx), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L657:
	movslq	%r10d, %rax
	movslq	%ebx, %rbx
	subq	$8, %r14
	movq	%rbx, -8(%rbp)
	leal	1(%rax), %ebx
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	subq	$8, %rbp
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L658:
	testq	%r10, %r10
	je	.L659
	sarq	$8, %rax
	addl	%eax, %ebx
.L659:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L660:
	testq	%r10, %r10
	jne	.L661
	sarq	$8, %rax
	addl	%eax, %ebx
.L661:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L662:
	testq	%r10, %r10
	js	.L946
.L663:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L664:
	testq	%r10, %r10
	movl	%ebx, %edx
	js	.L665
	sarq	$8, %rax
	addl	%eax, %edx
.L665:
	leal	1(%rdx), %ebx
	movslq	%edx, %rdx
	movslq	(%r11,%rdx,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L666:
	movq	(%r14), %r8
	cmpq	%r8, %r10
	jg	.L667
	sarq	$8, %rax
	addl	%eax, %ebx
.L667:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L668:
	movq	(%r14), %r8
	cmpq	%r8, %r10
	jl	.L669
	sarq	$8, %rax
	addl	%eax, %ebx
.L669:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L670:
	movq	(%r14), %r8
	movl	%ebx, %edx
	cmpq	%r10, %r8
	je	.L671
	sarq	$8, %rax
	addl	%eax, %edx
.L671:
	leal	1(%rdx), %ebx
	movslq	%edx, %rdx
	subq	$8, %r14
	movslq	(%r11,%rdx,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L672:
	movq	(%r14), %r8
	cmpq	%r8, %r10
	jle	.L673
	sarq	$8, %rax
	addl	%eax, %ebx
.L673:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L674:
	movq	(%r14), %r8
	cmpq	%r8, %r10
	jge	.L675
	sarq	$8, %rax
	addl	%eax, %ebx
.L675:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L676:
	movq	(%r14), %rcx
	cmpq	%r10, %rcx
	je	.L947
.L677:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L678:
	movq	(%r14), %r8
	testq	%r10, %r8
	jne	.L679
	sarq	$8, %rax
	addl	%eax, %ebx
.L679:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L680:
	movq	(%r14), %r8
	testq	%r10, %r8
	je	.L681
	sarq	$8, %rax
	addl	%eax, %ebx
.L681:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r8, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L682:
	movq	-8(%r14), %r13
	movq	(%r14), %rdx
	movq	%r13, %rcx
	subq	%rdx, %r10
	subq	%rdx, %rcx
	cmpq	%r10, %rcx
	jbe	.L683
	sarq	$8, %rax
	addl	%eax, %ebx
.L683:
	movslq	%ebx, %rax
	subq	$16, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r13, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L684:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L685:
	movslq	%ebx, %rax
	movq	(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L686:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	(%r14), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L687:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	-8(%r14), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L688:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	-16(%r14), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L689:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	-24(%r14), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L690:
	movslq	%ebx, %rax
	movq	(%r14), %rcx
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%r10, (%r14)
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L691:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L692:
	movq	(%r14), %rax
	movq	-8(%r14), %rcx
	movq	%r10, (%r14)
	movq	%rax, -8(%r14)
	movslq	%ebx, %rax
	movq	%rcx, %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L693:
	movq	-8(%r14), %rax
	movq	(%r14), %rcx
	movq	%r10, -8(%r14)
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	movq	%rcx, %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L694:
	movq	(%r14), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L695:
	movslq	%ebx, %rax
	movq	-8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$16, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L696:
	movslq	%ebx, %rax
	movq	-16(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$24, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L697:
	movslq	%ebx, %rax
	movq	-24(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$32, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L698:
	movq	-16(%r14), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	movq	-24(%r14), %r10
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L699:
	movq	(%r14), %rax
	movq	-16(%r14), %rdx
	movq	-8(%r14), %rcx
	movq	%r10, -8(%r14)
	movq	%rax, -16(%r14)
	movslq	%ebx, %rax
	movq	%rdx, (%r14)
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L700:
	movslq	%ebx, %rax
	movq	%r10, -8(%rbp)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	subq	$8, %rbp
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L701:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$8, %rbp
	movslq	(%r11,%rax,4), %rax
	movq	-8(%rbp), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L702:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	0(%rbp), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L703:
	movslq	%ebx, %rax
	andq	(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L704:
	movslq	%ebx, %rax
	orq	(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L705:
	movslq	%ebx, %rax
	xorq	(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L706:
	movslq	%ebx, %rax
	notq	%r10
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	andq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L707:
	movslq	%ebx, %rax
	addq	(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L708:
	movq	(%r14), %rax
	subq	$8, %r14
	subq	%r10, %rax
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L709:
	movslq	%ebx, %rax
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	imulq	8(%r14), %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L710:
	movq	(%r14), %rax
	subq	$8, %r14
	cqto
	idivq	%r10
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L711:
	movq	(%r14), %rax
	movl	%r10d, %ecx
	subq	$8, %r14
	salq	%cl, %rax
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L712:
	movq	(%r14), %rax
	movl	%r10d, %ecx
	subq	$8, %r14
	sarq	%cl, %rax
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L713:
	movq	(%r14), %rax
	movl	%r10d, %ecx
	subq	$8, %r14
	shrq	%cl, %rax
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L714:
	movq	(%r14), %rax
	subq	$8, %r14
	cqto
	idivq	%r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%rdx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L715:
	movq	(%r14), %rax
	cqto
	idivq	%r10
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	movq	%rdx, %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L716:
	movq	-8(%r14), %rax
	movq	(%r14), %rcx
/APP
 # 1126 "r3.cpp" 1
	movq %rax, %rax
	imulq %rcx
	idivq %r10
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$16, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L717:
	movq	-8(%r14), %rax
	movq	(%r14), %r8
	movq	%r10, %rcx
/APP
 # 1140 "r3.cpp" 1
	movq %rax, %rax
	imulq %r8
	shrdq %cl, %rdx, %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$16, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L718:
	movq	-8(%r14), %rax
	movq	(%r14), %r8
/APP
 # 1156 "r3.cpp" 1
	movq %rax, %rax
	movq %r10, %rcx
	shldq %cl, %rax, %rdx
	shlq %cl, %rax
	idivq %r8
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$16, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L719:
	movslq	%ebx, %rax
	notq	%r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L720:
	movslq	%ebx, %rax
	negq	%r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L721:
	movq	%r10, %rax
	sarq	$63, %rax
	xorq	%rax, %r10
	subq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L722:
	testq	%r10, %r10
	je	.L723
	bsrq	%r10, %rax
	movl	$63, %ecx
	movl	$1, %edx
	xorq	$63, %rax
	movq	%r10, %r8
	xorl	%r10d, %r10d
	subl	%eax, %ecx
	sarl	%ecx
	sall	%cl, %edx
	movslq	%edx, %rdx
	.p2align 4,,10
.L725:
	leaq	(%rdx,%r10,2), %rax
	salq	%cl, %rax
	cmpq	%r8, %rax
	jg	.L724
	addq	%rdx, %r10
	subq	%rax, %r8
.L724:
	subl	$1, %ecx
	sarq	%rdx
	cmpl	$-1, %ecx
	jne	.L725
.L723:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L726:
	movslq	%ebx, %rax
	bsrq	%r10, %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	xorq	$63, %r10
	movslq	%r10d, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L727:
	movslq	%ebx, %rax
	movq	(%r10), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L728:
	movslq	%ebx, %rax
	movsbq	(%r10), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L729:
	movslq	%ebx, %rax
	movswq	(%r10), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L730:
	movslq	%ebx, %rax
	movslq	(%r10), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L731:
	leaq	8(%r10), %rax
	addq	$8, %r14
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	movq	(%r10), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L732:
	leaq	1(%r10), %rax
	addq	$8, %r14
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	movsbq	(%r10), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L733:
	leaq	2(%r10), %rax
	addq	$8, %r14
	movswq	(%r10), %r10
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L734:
	leaq	4(%r10), %rax
	addq	$8, %r14
	movslq	(%r10), %r10
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L735:
	movq	(%r14), %rax
	subq	$16, %r14
	movq	%rax, (%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L736:
	movq	(%r14), %rax
	subq	$16, %r14
	movb	%al, (%r10)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L737:
	movq	(%r14), %rax
	subq	$16, %r14
	movw	%ax, (%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L738:
	movq	(%r14), %rax
	subq	$16, %r14
	movl	%eax, (%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L739:
	movq	(%r14), %rax
	addq	$8, %r10
	subq	$8, %r14
	movq	%rax, -8(%r10)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L740:
	movq	(%r14), %rax
	addq	$1, %r10
	subq	$8, %r14
	movb	%al, -1(%r10)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L741:
	movq	(%r14), %rax
	addq	$2, %r10
	subq	$8, %r14
	movw	%ax, -2(%r10)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L742:
	movq	(%r14), %rax
	addq	$4, %r10
	subq	$8, %r14
	movl	%eax, -4(%r10)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L743:
	movq	(%r14), %rax
	addq	%rax, (%r10)
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	movq	-8(%r14), %r10
	addl	$1, %ebx
	subq	$16, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L744:
	movq	(%r14), %rax
	addb	%al, (%r10)
	movslq	%ebx, %rax
	movq	memcode(%rip), %r11
	movq	-8(%r14), %r10
	addl	$1, %ebx
	subq	$16, %r14
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L745:
	movq	(%r14), %rax
	addw	%ax, (%r10)
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	movq	-8(%r14), %r10
	addl	$1, %ebx
	subq	$16, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L746:
	movq	(%r14), %rax
	addl	%eax, (%r10)
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	movq	-8(%r14), %r10
	addl	$1, %ebx
	subq	$16, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L747:
	movslq	%ebx, %rax
	movq	(%r14), %rcx
	movq	%r10, %rsi
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	addl	$1, %ebx
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L748:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	addq	$8, %r14
	movq	%rsi, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L749:
	movslq	%ebx, %rax
	addq	%r10, %rsi
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L750:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	(%rsi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L751:
	movslq	%ebx, %rax
	movq	%r10, (%rsi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L752:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$8, %rsi
	movslq	(%r11,%rax,4), %rax
	movq	-8(%rsi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L753:
	movslq	%ebx, %rax
	movq	%r10, (%rsi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addq	$8, %rsi
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L754:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movsbq	(%rsi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L755:
	movb	%r10b, (%rsi)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	(%r14), %r10
	addl	$1, %ebx
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L756:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$1, %rsi
	movslq	(%r11,%rax,4), %rax
	movsbq	-1(%rsi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L757:
	movb	%r10b, (%rsi)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	(%r14), %r10
	addq	$1, %rsi
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L758:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movslq	(%rsi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L759:
	movslq	%ebx, %rax
	movl	%r10d, (%rsi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L760:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$4, %rsi
	movslq	(%r11,%rax,4), %rax
	movslq	-4(%rsi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L761:
	movslq	%ebx, %rax
	movl	%r10d, (%rsi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addq	$4, %rsi
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L762:
	movslq	%ebx, %rax
	movq	(%r14), %rcx
	movq	%r10, %rdi
	movslq	(%r11,%rax,4), %rax
	subq	$8, %r14
	addl	$1, %ebx
	movq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L763:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	addq	$8, %r14
	movq	%rdi, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L764:
	movslq	%ebx, %rax
	addq	%r10, %rdi
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L765:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	(%rdi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L766:
	movslq	%ebx, %rax
	movq	%r10, (%rdi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L767:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$8, %rdi
	movslq	(%r11,%rax,4), %rax
	movq	-8(%rdi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L768:
	movslq	%ebx, %rax
	movq	%r10, (%rdi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addq	$8, %rdi
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L769:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movsbq	(%rdi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L770:
	movb	%r10b, (%rdi)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	(%r14), %r10
	addl	$1, %ebx
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L771:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$1, %rdi
	movslq	(%r11,%rax,4), %rax
	movsbq	-1(%rdi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L772:
	movb	%r10b, (%rdi)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	(%r14), %r10
	addq	$1, %rdi
	subq	$8, %r14
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L773:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movslq	(%rdi), %r10
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L774:
	movslq	%ebx, %rax
	movl	%r10d, (%rdi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L775:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addq	$4, %rdi
	movslq	(%r11,%rax,4), %rax
	movslq	-4(%rdi), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L776:
	movslq	%ebx, %rax
	movl	%r10d, (%rdi)
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	addq	$4, %rdi
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L777:
	movslq	%ebx, %rax
	movq	%rsi, -8(%rbp)
	movq	%rdi, -16(%rbp)
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	subq	$16, %rbp
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L778:
	movslq	%ebx, %rax
	movq	0(%rbp), %rdi
	movq	8(%rbp), %rsi
	movslq	(%r11,%rax,4), %rax
	addq	$16, %rbp
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L779:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	leaq	0(,%r10,8), %r8
	subq	$24, %r14
	call	memcpy
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L780:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	leaq	0(,%r10,8), %r8
	subq	$24, %r14
	call	memmove
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L781:
	movq	-8(%r14), %rax
	leal	-1(%r10), %edx
	movq	(%r14), %rcx
	addq	$8, %rax
	testl	%r10d, %r10d
	leaq	(%rax,%rdx,8), %rdx
	jne	.L783
	jmp	.L784
	.p2align 4,,10
.L948:
	addq	$8, %rax
.L783:
	cmpq	%rdx, %rax
	movq	%rcx, -8(%rax)
	jne	.L948
.L784:
	movslq	%ebx, %rax
	movq	-16(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$24, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L785:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	movq	%r10, %r8
	subq	$24, %r14
	call	memcpy
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L786:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	movq	%r10, %r8
	subq	$24, %r14
	call	memmove
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L787:
	movl	(%r14), %edx
	movq	-8(%r14), %rcx
	movq	%r10, %r8
	subq	$24, %r14
	call	memset
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L788:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	leaq	0(,%r10,4), %r8
	subq	$24, %r14
	call	memcpy
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L789:
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	leaq	0(,%r10,4), %r8
	subq	$24, %r14
	call	memmove
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L790:
	movq	-8(%r14), %rax
	leal	-1(%r10), %edx
	movl	(%r14), %ecx
	addq	$4, %rax
	testl	%r10d, %r10d
	leaq	(%rax,%rdx,4), %rdx
	jne	.L792
	jmp	.L793
	.p2align 4,,10
.L949:
	addq	$4, %rax
.L792:
	cmpq	%rdx, %rax
	movl	%ecx, -4(%rax)
	jne	.L949
.L793:
	movslq	%ebx, %rax
	movq	-16(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	subq	$24, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L794:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	movslq	memd(%rip), %r10
	movslq	(%r11,%rax,4), %rax
	addq	memdata(%rip), %r10
	addl	$1, %ebx
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L795:
	movq	%r10, %rcx
	call	*__imp_LoadLibraryA(%rip)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L796:
	movq	%r10, %rdx
	movq	(%r14), %rcx
	subq	$8, %r14
	call	*__imp_GetProcAddress(%rip)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L797:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	leaq	8(%r14), %r13
	movq	(%rax), %rax
	movq	%r10, 8(%r14)
	movq	%r13, %r14
	call	*%rax
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L798:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, %rcx
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L799:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, %rdx
	movq	(%r14), %rcx
	subq	$8, %r14
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L800:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	(%r14), %rdx
	movq	-8(%r14), %rcx
	movq	%r10, %r8
	subq	$16, %r14
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L801:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	-8(%r14), %rdx
	movq	-16(%r14), %rcx
	movq	%r10, %r9
	movq	(%r14), %r8
	subq	$24, %r14
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L802:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	-16(%r14), %rdx
	movq	-8(%r14), %r8
	movq	-24(%r14), %rcx
	subq	$32, %r14
	movq	%r10, 32(%rsp)
	movq	32(%r14), %r9
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L803:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	-24(%r14), %rdx
	movq	-8(%r14), %r9
	movq	-16(%r14), %r8
	subq	$40, %r14
	movq	8(%r14), %rcx
	movq	%r10, 40(%rsp)
	movq	40(%r14), %r10
	movq	%r10, 32(%rsp)
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L804:
	movq	-32(%r14), %rdx
	movq	-16(%r14), %r9
	sarq	$8, %rax
	movq	-24(%r14), %r8
	movq	-40(%r14), %rcx
	subq	$48, %r14
	movq	%r10, 48(%rsp)
	movq	48(%r14), %r10
	addq	memdata(%rip), %rax
	movq	%r10, 40(%rsp)
	movq	40(%r14), %r10
	movq	%r10, 32(%rsp)
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L805:
	movq	-40(%r14), %rdx
	movq	-24(%r14), %r9
	sarq	$8, %rax
	movq	-32(%r14), %r8
	movq	-48(%r14), %rcx
	subq	$56, %r14
	movq	%r10, 56(%rsp)
	movq	56(%r14), %r10
	addq	memdata(%rip), %rax
	movq	%r10, 48(%rsp)
	movq	48(%r14), %r10
	movq	%r10, 40(%rsp)
	movq	40(%r14), %r10
	movq	%r10, 32(%rsp)
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L806:
	movq	-48(%r14), %rdx
	movq	-32(%r14), %r9
	sarq	$8, %rax
	movq	-40(%r14), %r8
	movq	-56(%r14), %rcx
	subq	$64, %r14
	movq	%r10, 64(%rsp)
	movq	64(%r14), %r10
	addq	memdata(%rip), %rax
	movq	%r10, 56(%rsp)
	movq	56(%r14), %r10
	movq	%r10, 48(%rsp)
	movq	48(%r14), %r10
	movq	%r10, 40(%rsp)
	movq	40(%r14), %r10
	movq	%r10, 32(%rsp)
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L807:
	movq	-56(%r14), %rdx
	movq	-40(%r14), %r9
	sarq	$8, %rax
	movq	-48(%r14), %r8
	movq	-64(%r14), %rcx
	subq	$72, %r14
	movq	%r10, 72(%rsp)
	movq	72(%r14), %r10
	addq	memdata(%rip), %rax
	movq	%r10, 64(%rsp)
	movq	64(%r14), %r10
	movq	%r10, 56(%rsp)
	movq	56(%r14), %r10
	movq	%r10, 48(%rsp)
	movq	48(%r14), %r10
	movq	%r10, 40(%rsp)
	movq	40(%r14), %r10
	movq	%r10, 32(%rsp)
	call	*(%rax)
	movq	memcode(%rip), %r11
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L808:
	sarq	$8, %rax
	leal	1(%rax), %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L809:
	sarq	$8, %rax
	addl	%ebx, %eax
	leal	1(%rax), %ebx
	cltq
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L810:
	sarq	$8, %rax
	andl	$16777215, %r10d
	movq	%rax, %rcx
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	salq	$24, %rcx
	orq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L811:
	sarq	$8, %rax
	andq	%r12, %r10
	salq	$48, %rax
	orq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L812:
	movslq	%ebx, %rax
	movq	%r10, 8(%r14)
	addl	$3, %ebx
	movq	(%r11,%rax,4), %r10
	movslq	8(%r11,%rax,4), %rax
	addq	$8, %r14
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L813:
	sarq	$8, %rax
	andq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L814:
	sarq	$8, %rax
	orq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L815:
	sarq	$8, %rax
	xorq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L816:
	sarq	$8, %rax
	notq	%rax
	andq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L817:
	sarq	$8, %rax
	addq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L818:
	sarq	$8, %rax
	subq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L819:
	sarq	$8, %rax
	imulq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L820:
	sarq	$8, %rax
	movq	%rax, %rcx
	movq	%r10, %rax
	cqto
	idivq	%rcx
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L821:
	sarq	$8, %rax
	movq	%rax, %rcx
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	salq	%cl, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L822:
	sarq	$8, %rax
	movq	%rax, %rcx
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	sarq	%cl, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L823:
	sarq	$8, %rax
	movq	%rax, %rcx
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	shrq	%cl, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L824:
	sarq	$8, %rax
	movq	%rax, %rcx
	movq	%r10, %rax
	cqto
	idivq	%rcx
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	%rdx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L825:
	sarq	$8, %rax
	addq	$8, %r14
	movq	%rax, %rcx
	movq	%r10, %rax
	cqto
	idivq	%rcx
	movq	%rax, (%r14)
	movslq	%ebx, %rax
	movq	%rdx, %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L826:
	movq	(%r14), %r8
	sarq	$8, %rax
/APP
 # 1126 "r3.cpp" 1
	movq %r8, %rax
	imulq %r10
	idivq %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L827:
	sarq	$8, %rax
	movq	(%r14), %r8
	movq	%rax, %rcx
/APP
 # 1140 "r3.cpp" 1
	movq %r8, %rax
	imulq %r10
	shrdq %cl, %rdx, %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L828:
	movq	(%r14), %r8
	sarq	$8, %rax
/APP
 # 1156 "r3.cpp" 1
	movq %r8, %rax
	movq %rax, %rcx
	shldq %cl, %rax, %rdx
	shlq %cl, %rax
	idivq %r10
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L829:
	sarq	$8, %rax
	movl	$16, %ecx
/APP
 # 1140 "r3.cpp" 1
	movq %r10, %rax
	imulq %rax
	shrdq %cl, %rdx, %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L830:
	sarq	$8, %rax
	movl	$16, %r8d
/APP
 # 1156 "r3.cpp" 1
	movq %r10, %rax
	movq %r8, %rcx
	shldq %cl, %rax, %rdx
	shlq %cl, %rax
	idivq %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L831:
	movq	(%r14), %rax
	movl	$16, %ecx
/APP
 # 1140 "r3.cpp" 1
	movq %rax, %rax
	imulq %r10
	shrdq %cl, %rdx, %rax
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L832:
	movq	(%r14), %rax
	movl	$16, %r8d
/APP
 # 1156 "r3.cpp" 1
	movq %rax, %rax
	movq %r8, %rcx
	shldq %cl, %rax, %rdx
	shlq %cl, %rax
	idivq %r10
	
 # 0 "" 2
/NO_APP
	movq	%rax, %r10
	movslq	%ebx, %rax
	subq	$8, %r14
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L833:
	movq	%rax, %rdx
	sarq	$16, %rdx
	cmpq	%rdx, %r10
	jl	.L834
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L834:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L835:
	movq	%rax, %rdx
	sarq	$16, %rdx
	cmpq	%rdx, %r10
	jg	.L836
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L836:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L837:
	movq	%rax, %rcx
	movl	%ebx, %edx
	sarq	$16, %rcx
	cmpq	%r10, %rcx
	je	.L838
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %edx
.L838:
	leal	1(%rdx), %ebx
	movslq	%edx, %rdx
	movslq	(%r11,%rdx,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L839:
	movq	%rax, %rdx
	sarq	$16, %rdx
	cmpq	%rdx, %r10
	jge	.L840
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L840:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L841:
	movq	%rax, %rdx
	sarq	$16, %rdx
	cmpq	%rdx, %r10
	jle	.L842
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L842:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L843:
	movq	%rax, %rdx
	sarq	$16, %rdx
	cmpq	%r10, %rdx
	je	.L950
.L844:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L845:
	movq	%rax, %rdx
	sarq	$16, %rdx
	testq	%r10, %rdx
	jne	.L846
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L846:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L847:
	movq	%rax, %rdx
	sarq	$16, %rdx
	testq	%r10, %rdx
	je	.L848
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
.L848:
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L849:
	movzbl	%ah, %ecx
	sarq	$16, %rax
	salq	%cl, %r10
	movq	%rax, %rcx
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	sarq	%cl, %r10
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L850:
	movq	%rax, %rcx
	sarq	$8, %rcx
	sarq	%cl, %r10
	movl	%eax, %ecx
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	shrl	$14, %ecx
	addl	$1, %ebx
	andq	%rcx, %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L851:
	sarq	$8, %rax
	movq	(%rax,%r10), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L852:
	sarq	$8, %rax
	movsbq	(%rax,%r10), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L853:
	sarq	$8, %rax
	movswq	(%rax,%r10), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L854:
	sarq	$8, %rax
	movslq	(%rax,%r10), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L855:
	movq	(%r14), %rdx
	sarq	$8, %rax
	subq	$16, %r14
	movq	%rdx, (%rax,%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L856:
	sarq	$8, %rax
	subq	$16, %r14
	movq	%rax, %rcx
	movq	16(%r14), %rax
	movb	%al, (%rcx,%r10)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L857:
	sarq	$8, %rax
	subq	$16, %r14
	movq	%rax, %rcx
	movq	16(%r14), %rax
	movw	%ax, (%rcx,%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L858:
	sarq	$8, %rax
	subq	$16, %r14
	movq	%rax, %rcx
	movq	16(%r14), %rax
	movl	%eax, (%rcx,%r10)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L859:
	movq	(%r14), %rax
	subq	$8, %r14
	movq	(%rax,%r10,2), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L860:
	movq	(%r14), %rax
	subq	$8, %r14
	movq	(%rax,%r10,4), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L861:
	movq	(%r14), %rax
	subq	$8, %r14
	movq	(%rax,%r10,8), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L862:
	movq	(%r14), %rax
	subq	$8, %r14
	movsbq	(%rax,%r10,2), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L863:
	movq	(%r14), %rax
	subq	$8, %r14
	movsbq	(%rax,%r10,4), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L864:
	movq	(%r14), %rax
	subq	$8, %r14
	movsbq	(%rax,%r10,8), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L865:
	movq	(%r14), %rax
	subq	$8, %r14
	movswq	(%rax,%r10,2), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L866:
	movq	(%r14), %rax
	subq	$8, %r14
	movswq	(%rax,%r10,4), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L867:
	movq	(%r14), %rax
	subq	$8, %r14
	movswq	(%rax,%r10,8), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L868:
	movq	(%r14), %rax
	subq	$8, %r14
	movslq	(%rax,%r10,2), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L869:
	movq	(%r14), %rax
	subq	$8, %r14
	movslq	(%rax,%r10,4), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L870:
	movq	(%r14), %rax
	subq	$8, %r14
	movslq	(%rax,%r10,8), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L871:
	movq	-8(%r14), %rdx
	movq	(%r14), %rax
	subq	$24, %r14
	movq	%rdx, (%rax,%r10,2)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L872:
	movq	-8(%r14), %rdx
	movq	(%r14), %rax
	subq	$24, %r14
	movq	%rdx, (%rax,%r10,4)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L873:
	movq	-8(%r14), %rdx
	movq	(%r14), %rax
	subq	$24, %r14
	movq	%rdx, (%rax,%r10,8)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L874:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movb	%dl, (%rax,%r10,2)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L875:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movb	%dl, (%rax,%r10,4)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L876:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movb	%dl, (%rax,%r10,8)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L877:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movw	%dx, (%rax,%r10,2)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L878:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movw	%dx, (%rax,%r10,4)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L879:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movw	%dx, (%rax,%r10,8)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L880:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movl	%edx, (%rax,%r10,2)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L881:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movl	%edx, (%rax,%r10,4)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L882:
	movq	(%r14), %rax
	movq	-8(%r14), %rdx
	subq	$24, %r14
	movl	%edx, (%rax,%r10,8)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L883:
	sarq	$8, %rax
	addq	%rax, %rsi
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L884:
	sarq	$8, %rax
	addq	%rax, %rdi
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L885:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movq	(%rax,%rcx), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L886:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movsbq	(%rax,%rcx), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L887:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movswq	(%rax,%rcx), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L888:
	sarq	$8, %rax
	movq	%r10, 8(%r14)
	addq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movslq	(%rax,%rcx), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L889:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	leaq	8(%rax), %rdx
	movq	%rdx, (%r14)
	movq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L890:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	leaq	1(%rax), %rdx
	movq	%rdx, (%r14)
	movsbq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L891:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	leaq	2(%rax), %rdx
	movswq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rdx, (%r14)
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L892:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, 8(%r14)
	addq	$16, %r14
	leaq	4(%rax), %rdx
	movslq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rdx, (%r14)
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L893:
	sarq	$8, %rax
	subq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movq	%r10, (%rax,%rcx)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L894:
	sarq	$8, %rax
	subq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movb	%r10b, (%rax,%rcx)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L895:
	sarq	$8, %rax
	subq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movw	%r10w, (%rax,%rcx)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L896:
	sarq	$8, %rax
	subq	$8, %r14
	movq	%rax, %rcx
	movq	memdata(%rip), %rax
	movl	%r10d, (%rax,%rcx)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L897:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	%r10, (%rax)
	leaq	8(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L898:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movb	%r10b, (%rax)
	movq	memcode(%rip), %r11
	leaq	1(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L899:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movw	%r10w, (%rax)
	leaq	2(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L900:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movl	%r10d, (%rax)
	leaq	4(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L901:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	addq	%r10, (%rax)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L902:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	addb	%r10b, (%rax)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movq	memcode(%rip), %r11
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L903:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	addw	%r10w, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L904:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	addl	%r10d, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L905:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$8, %r14
	movq	(%rax), %rax
	movq	%r10, (%r14)
	movq	(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L906:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$8, %r14
	movq	(%rax), %rax
	movq	%r10, (%r14)
	movsbq	(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L907:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$8, %r14
	movq	(%rax), %rax
	movq	%r10, (%r14)
	movswq	(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L908:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$8, %r14
	movq	(%rax), %rax
	movq	%r10, (%r14)
	movslq	(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L909:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$16, %r14
	movq	(%rax), %rax
	movq	%r10, -8(%r14)
	leaq	8(%rax), %rdx
	movq	%rdx, (%r14)
	movq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L910:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$16, %r14
	movq	(%rax), %rax
	movq	%r10, -8(%r14)
	leaq	1(%rax), %rdx
	movq	%rdx, (%r14)
	movsbq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L911:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$16, %r14
	movq	(%rax), %rax
	movq	%r10, -8(%r14)
	leaq	2(%rax), %rdx
	movswq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rdx, (%r14)
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L912:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	addq	$16, %r14
	movq	(%rax), %rax
	movq	%r10, -8(%r14)
	leaq	4(%rax), %rdx
	movslq	(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movq	%rdx, (%r14)
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L913:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	movq	%r10, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L914:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	movb	%r10b, (%rax)
	movq	memcode(%rip), %r11
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L915:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	movw	%r10w, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L916:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	movl	%r10d, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L917:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	(%rax), %rax
	movq	%r10, (%rax)
	leaq	8(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L918:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	(%rax), %rax
	movb	%r10b, (%rax)
	movq	memcode(%rip), %r11
	leaq	1(%rax), %r10
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L919:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	(%rax), %rax
	movw	%r10w, (%rax)
	leaq	2(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L920:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	movq	(%rax), %rax
	movl	%r10d, (%rax)
	leaq	4(%rax), %r10
	movslq	%ebx, %rax
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L921:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	addq	%r10, (%rax)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movslq	(%r11,%rax,4), %rax
	movq	8(%r14), %r10
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L922:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	addb	%r10b, (%rax)
	movslq	%ebx, %rax
	addl	$1, %ebx
	movq	memcode(%rip), %r11
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
.L923:
	sarq	$8, %rax
	addq	memdata(%rip), %rax
	subq	$8, %r14
	movq	(%rax), %rax
	addw	%r10w, (%rax)
	movslq	%ebx, %rax
	movq	8(%r14), %r10
	movslq	(%r11,%rax,4), %rax
	addl	$1, %ebx
	movzbl	%al, %edx
	movq	(%r15,%rdx,8), %rdx
	jmp	*%rdx
	.p2align 4,,10
.L946:
	sarq	$8, %rax
	addl	%eax, %ebx
	jmp	.L663
	.p2align 4,,10
.L950:
	salq	$48, %rax
	sarq	$56, %rax
	addl	%eax, %ebx
	jmp	.L844
	.p2align 4,,10
.L947:
	sarq	$8, %rax
	addl	%eax, %ebx
	jmp	.L677
.L945:
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE59:
	.text
.LHOTE59:
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC60:
	.ascii "main.r3\0"
	.section	.text.unlikely,"x"
.LCOLDB61:
	.section	.text.startup,"x"
.LHOTB61:
	.p2align 4,,15
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	movq	%rdx, %rsi
	call	__main
	cmpl	$1, %ebx
	leaq	.LC60(%rip), %rcx
	jle	.L952
	movq	8(%rsi), %rcx
.L952:
	call	_Z9r3compilePc
	testl	%eax, %eax
	movl	$-1, %edx
	je	.L953
	movl	boot(%rip), %ecx
	call	_Z5runr3i
	xorl	%edx, %edx
.L953:
	movl	%edx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.section	.text.unlikely,"x"
.LCOLDE61:
	.section	.text.startup,"x"
.LHOTE61:
	.section .rdata,"dr"
	.align 64
_ZZ5runr3iE14dispatch_table:
	.quad	.L649
	.quad	.L653
	.quad	.L654
	.quad	.L655
	.quad	.L656
	.quad	.L657
	.quad	.L658
	.quad	.L660
	.quad	.L662
	.quad	.L664
	.quad	.L666
	.quad	.L668
	.quad	.L670
	.quad	.L672
	.quad	.L674
	.quad	.L676
	.quad	.L678
	.quad	.L680
	.quad	.L682
	.quad	.L684
	.quad	.L685
	.quad	.L686
	.quad	.L687
	.quad	.L688
	.quad	.L689
	.quad	.L690
	.quad	.L691
	.quad	.L692
	.quad	.L693
	.quad	.L694
	.quad	.L695
	.quad	.L696
	.quad	.L697
	.quad	.L698
	.quad	.L699
	.quad	.L700
	.quad	.L701
	.quad	.L702
	.quad	.L703
	.quad	.L704
	.quad	.L705
	.quad	.L706
	.quad	.L707
	.quad	.L708
	.quad	.L709
	.quad	.L710
	.quad	.L711
	.quad	.L712
	.quad	.L713
	.quad	.L714
	.quad	.L715
	.quad	.L716
	.quad	.L717
	.quad	.L718
	.quad	.L719
	.quad	.L720
	.quad	.L721
	.quad	.L722
	.quad	.L726
	.quad	.L727
	.quad	.L728
	.quad	.L729
	.quad	.L730
	.quad	.L731
	.quad	.L732
	.quad	.L733
	.quad	.L734
	.quad	.L735
	.quad	.L736
	.quad	.L737
	.quad	.L738
	.quad	.L739
	.quad	.L740
	.quad	.L741
	.quad	.L742
	.quad	.L743
	.quad	.L744
	.quad	.L745
	.quad	.L746
	.quad	.L747
	.quad	.L748
	.quad	.L749
	.quad	.L750
	.quad	.L751
	.quad	.L752
	.quad	.L753
	.quad	.L754
	.quad	.L755
	.quad	.L756
	.quad	.L757
	.quad	.L758
	.quad	.L759
	.quad	.L760
	.quad	.L761
	.quad	.L762
	.quad	.L763
	.quad	.L764
	.quad	.L765
	.quad	.L766
	.quad	.L767
	.quad	.L768
	.quad	.L769
	.quad	.L770
	.quad	.L771
	.quad	.L772
	.quad	.L773
	.quad	.L774
	.quad	.L775
	.quad	.L776
	.quad	.L777
	.quad	.L778
	.quad	.L779
	.quad	.L780
	.quad	.L781
	.quad	.L785
	.quad	.L786
	.quad	.L787
	.quad	.L788
	.quad	.L789
	.quad	.L790
	.quad	.L794
	.quad	.L795
	.quad	.L796
	.quad	.L797
	.quad	.L798
	.quad	.L799
	.quad	.L800
	.quad	.L801
	.quad	.L802
	.quad	.L803
	.quad	.L804
	.quad	.L805
	.quad	.L806
	.quad	.L807
	.quad	.L808
	.quad	.L809
	.quad	.L810
	.quad	.L811
	.quad	.L812
	.quad	.L813
	.quad	.L814
	.quad	.L815
	.quad	.L816
	.quad	.L817
	.quad	.L818
	.quad	.L819
	.quad	.L820
	.quad	.L821
	.quad	.L822
	.quad	.L823
	.quad	.L824
	.quad	.L825
	.quad	.L826
	.quad	.L827
	.quad	.L828
	.quad	.L829
	.quad	.L830
	.quad	.L831
	.quad	.L832
	.quad	.L833
	.quad	.L835
	.quad	.L837
	.quad	.L839
	.quad	.L841
	.quad	.L843
	.quad	.L845
	.quad	.L847
	.quad	.L849
	.quad	.L850
	.quad	.L851
	.quad	.L852
	.quad	.L853
	.quad	.L854
	.quad	.L855
	.quad	.L856
	.quad	.L857
	.quad	.L858
	.quad	.L859
	.quad	.L860
	.quad	.L861
	.quad	.L862
	.quad	.L863
	.quad	.L864
	.quad	.L865
	.quad	.L866
	.quad	.L867
	.quad	.L868
	.quad	.L869
	.quad	.L870
	.quad	.L871
	.quad	.L872
	.quad	.L873
	.quad	.L874
	.quad	.L875
	.quad	.L876
	.quad	.L877
	.quad	.L878
	.quad	.L879
	.quad	.L880
	.quad	.L881
	.quad	.L882
	.quad	.L883
	.quad	.L884
	.quad	.L885
	.quad	.L886
	.quad	.L887
	.quad	.L888
	.quad	.L889
	.quad	.L890
	.quad	.L891
	.quad	.L892
	.quad	.L893
	.quad	.L894
	.quad	.L895
	.quad	.L896
	.quad	.L897
	.quad	.L898
	.quad	.L899
	.quad	.L900
	.quad	.L901
	.quad	.L902
	.quad	.L903
	.quad	.L904
	.quad	.L905
	.quad	.L906
	.quad	.L907
	.quad	.L908
	.quad	.L909
	.quad	.L910
	.quad	.L911
	.quad	.L912
	.quad	.L913
	.quad	.L914
	.quad	.L915
	.quad	.L916
	.quad	.L917
	.quad	.L918
	.quad	.L919
	.quad	.L920
	.quad	.L921
	.quad	.L922
	.quad	.L923
	.quad	.L924
	.globl	stack
	.bss
	.align 64
stack:
	.space 2048
	.globl	nro
	.align 8
nro:
	.space 8
	.globl	r3bas
	.section .rdata,"dr"
.LC62:
	.ascii ";\0"
.LC63:
	.ascii "(\0"
.LC64:
	.ascii ")\0"
.LC65:
	.ascii "[\0"
.LC66:
	.ascii "]\0"
.LC67:
	.ascii "EX\0"
.LC68:
	.ascii "0?\0"
.LC69:
	.ascii "1?\0"
.LC70:
	.ascii "+?\0"
.LC71:
	.ascii "-?\0"
.LC72:
	.ascii "<?\0"
.LC73:
	.ascii ">?\0"
.LC74:
	.ascii "=?\0"
.LC75:
	.ascii ">=?\0"
.LC76:
	.ascii "<=?\0"
.LC77:
	.ascii "<>?\0"
.LC78:
	.ascii "AND?\0"
.LC79:
	.ascii "NAND?\0"
.LC80:
	.ascii "IN?\0"
.LC81:
	.ascii "DUP\0"
.LC82:
	.ascii "DROP\0"
.LC83:
	.ascii "OVER\0"
.LC84:
	.ascii "PICK2\0"
.LC85:
	.ascii "PICK3\0"
.LC86:
	.ascii "PICK4\0"
.LC87:
	.ascii "SWAP\0"
.LC88:
	.ascii "NIP\0"
.LC89:
	.ascii "ROT\0"
.LC90:
	.ascii "-ROT\0"
.LC91:
	.ascii "2DUP\0"
.LC92:
	.ascii "2DROP\0"
.LC93:
	.ascii "3DROP\0"
.LC94:
	.ascii "4DROP\0"
.LC95:
	.ascii "2OVER\0"
.LC96:
	.ascii "2SWAP\0"
.LC97:
	.ascii ">R\0"
.LC98:
	.ascii "R>\0"
.LC99:
	.ascii "R@\0"
.LC100:
	.ascii "AND\0"
.LC101:
	.ascii "OR\0"
.LC102:
	.ascii "XOR\0"
.LC103:
	.ascii "NAND\0"
.LC104:
	.ascii "+\0"
.LC105:
	.ascii "-\0"
.LC106:
	.ascii "*\0"
.LC107:
	.ascii "/\0"
.LC108:
	.ascii "<<\0"
.LC109:
	.ascii ">>\0"
.LC110:
	.ascii ">>>\0"
.LC111:
	.ascii "MOD\0"
.LC112:
	.ascii "/MOD\0"
.LC113:
	.ascii "*/\0"
.LC114:
	.ascii "*>>\0"
.LC115:
	.ascii "<</\0"
.LC116:
	.ascii "NOT\0"
.LC117:
	.ascii "NEG\0"
.LC118:
	.ascii "ABS\0"
.LC119:
	.ascii "SQRT\0"
.LC120:
	.ascii "CLZ\0"
.LC121:
	.ascii "@\0"
.LC122:
	.ascii "C@\0"
.LC123:
	.ascii "W@\0"
.LC124:
	.ascii "D@\0"
.LC125:
	.ascii "@+\0"
.LC126:
	.ascii "C@+\0"
.LC127:
	.ascii "W@+\0"
.LC128:
	.ascii "D@+\0"
.LC129:
	.ascii "!\0"
.LC130:
	.ascii "C!\0"
.LC131:
	.ascii "W!\0"
.LC132:
	.ascii "D!\0"
.LC133:
	.ascii "!+\0"
.LC134:
	.ascii "C!+\0"
.LC135:
	.ascii "W!+\0"
.LC136:
	.ascii "D!+\0"
.LC137:
	.ascii "+!\0"
.LC138:
	.ascii "C+!\0"
.LC139:
	.ascii "W+!\0"
.LC140:
	.ascii "D+!\0"
.LC141:
	.ascii ">A\0"
.LC142:
	.ascii "A>\0"
.LC143:
	.ascii "A+\0"
.LC144:
	.ascii "A@\0"
.LC145:
	.ascii "A!\0"
.LC146:
	.ascii "A@+\0"
.LC147:
	.ascii "A!+\0"
.LC148:
	.ascii "CA@\0"
.LC149:
	.ascii "CA!\0"
.LC150:
	.ascii "CA@+\0"
.LC151:
	.ascii "CA!+\0"
.LC152:
	.ascii "DA@\0"
.LC153:
	.ascii "DA!\0"
.LC154:
	.ascii "DA@+\0"
.LC155:
	.ascii "DA!+\0"
.LC156:
	.ascii ">B\0"
.LC157:
	.ascii "B>\0"
.LC158:
	.ascii "B+\0"
.LC159:
	.ascii "B@\0"
.LC160:
	.ascii "B!\0"
.LC161:
	.ascii "B@+\0"
.LC162:
	.ascii "B!+\0"
.LC163:
	.ascii "CB@\0"
.LC164:
	.ascii "CB!\0"
.LC165:
	.ascii "CB@+\0"
.LC166:
	.ascii "CB!+\0"
.LC167:
	.ascii "DB@\0"
.LC168:
	.ascii "DB!\0"
.LC169:
	.ascii "DB@+\0"
.LC170:
	.ascii "DB!+\0"
.LC171:
	.ascii "AB[\0"
.LC172:
	.ascii "]BA\0"
.LC173:
	.ascii "MOVE\0"
.LC174:
	.ascii "MOVE>\0"
.LC175:
	.ascii "FILL\0"
.LC176:
	.ascii "CMOVE\0"
.LC177:
	.ascii "CMOVE>\0"
.LC178:
	.ascii "CFILL\0"
.LC179:
	.ascii "DMOVE\0"
.LC180:
	.ascii "DMOVE>\0"
.LC181:
	.ascii "DFILL\0"
.LC182:
	.ascii "MEM\0"
.LC183:
	.ascii "LOADLIB\0"
.LC184:
	.ascii "GETPROC\0"
.LC185:
	.ascii "SYS0\0"
.LC186:
	.ascii "SYS1\0"
.LC187:
	.ascii "SYS2\0"
.LC188:
	.ascii "SYS3\0"
.LC189:
	.ascii "SYS4\0"
.LC190:
	.ascii "SYS5\0"
.LC191:
	.ascii "SYS6\0"
.LC192:
	.ascii "SYS7\0"
.LC193:
	.ascii "SYS8\0"
.LC194:
	.ascii "SYS9\0"
.LC195:
	.ascii "SYS10\0"
.LC196:
	.ascii "\0"
	.data
	.align 64
r3bas:
	.quad	.LC62
	.quad	.LC63
	.quad	.LC64
	.quad	.LC65
	.quad	.LC66
	.quad	.LC67
	.quad	.LC68
	.quad	.LC69
	.quad	.LC70
	.quad	.LC71
	.quad	.LC72
	.quad	.LC73
	.quad	.LC74
	.quad	.LC75
	.quad	.LC76
	.quad	.LC77
	.quad	.LC78
	.quad	.LC79
	.quad	.LC80
	.quad	.LC81
	.quad	.LC82
	.quad	.LC83
	.quad	.LC84
	.quad	.LC85
	.quad	.LC86
	.quad	.LC87
	.quad	.LC88
	.quad	.LC89
	.quad	.LC90
	.quad	.LC91
	.quad	.LC92
	.quad	.LC93
	.quad	.LC94
	.quad	.LC95
	.quad	.LC96
	.quad	.LC97
	.quad	.LC98
	.quad	.LC99
	.quad	.LC100
	.quad	.LC101
	.quad	.LC102
	.quad	.LC103
	.quad	.LC104
	.quad	.LC105
	.quad	.LC106
	.quad	.LC107
	.quad	.LC108
	.quad	.LC109
	.quad	.LC110
	.quad	.LC111
	.quad	.LC112
	.quad	.LC113
	.quad	.LC114
	.quad	.LC115
	.quad	.LC116
	.quad	.LC117
	.quad	.LC118
	.quad	.LC119
	.quad	.LC120
	.quad	.LC121
	.quad	.LC122
	.quad	.LC123
	.quad	.LC124
	.quad	.LC125
	.quad	.LC126
	.quad	.LC127
	.quad	.LC128
	.quad	.LC129
	.quad	.LC130
	.quad	.LC131
	.quad	.LC132
	.quad	.LC133
	.quad	.LC134
	.quad	.LC135
	.quad	.LC136
	.quad	.LC137
	.quad	.LC138
	.quad	.LC139
	.quad	.LC140
	.quad	.LC141
	.quad	.LC142
	.quad	.LC143
	.quad	.LC144
	.quad	.LC145
	.quad	.LC146
	.quad	.LC147
	.quad	.LC148
	.quad	.LC149
	.quad	.LC150
	.quad	.LC151
	.quad	.LC152
	.quad	.LC153
	.quad	.LC154
	.quad	.LC155
	.quad	.LC156
	.quad	.LC157
	.quad	.LC158
	.quad	.LC159
	.quad	.LC160
	.quad	.LC161
	.quad	.LC162
	.quad	.LC163
	.quad	.LC164
	.quad	.LC165
	.quad	.LC166
	.quad	.LC167
	.quad	.LC168
	.quad	.LC169
	.quad	.LC170
	.quad	.LC171
	.quad	.LC172
	.quad	.LC173
	.quad	.LC174
	.quad	.LC175
	.quad	.LC176
	.quad	.LC177
	.quad	.LC178
	.quad	.LC179
	.quad	.LC180
	.quad	.LC181
	.quad	.LC182
	.quad	.LC183
	.quad	.LC184
	.quad	.LC185
	.quad	.LC186
	.quad	.LC187
	.quad	.LC188
	.quad	.LC189
	.quad	.LC190
	.quad	.LC191
	.quad	.LC192
	.quad	.LC193
	.quad	.LC194
	.quad	.LC195
	.quad	.LC196
	.globl	r3asm
	.section .rdata,"dr"
.LC197:
	.ascii "LIT1\0"
.LC198:
	.ascii "ADR\0"
.LC199:
	.ascii "CALL\0"
.LC200:
	.ascii "VAR\0"
	.data
	.align 32
r3asm:
	.quad	.LC62
	.quad	.LC197
	.quad	.LC198
	.quad	.LC199
	.quad	.LC200
	.globl	lastblock
	.bss
	.align 4
lastblock:
	.space 4
	.globl	stacka
	.align 64
stacka:
	.space 1024
	.globl	cntstacka
	.align 4
cntstacka:
	.space 4
	.globl	level
	.align 4
level:
	.space 4
	.globl	dicc
	.align 64
dicc:
	.space 131072
	.globl	dicclocal
	.align 4
dicclocal:
	.space 4
	.globl	cntdicc
	.align 4
cntdicc:
	.space 4
	.globl	stacki
	.align 64
stacki:
	.space 512
	.globl	cntstacki
	.align 4
cntstacki:
	.space 4
	.globl	includes
	.align 64
includes:
	.space 2048
	.globl	cntincludes
	.align 4
cntincludes:
	.space 4
	.globl	path
	.align 64
path:
	.space 1024
	.globl	memdata
	.align 8
memdata:
	.space 8
	.globl	memd
	.align 4
memd:
	.space 4
	.globl	memdsize
	.data
	.align 4
memdsize:
	.long	10485760
	.globl	memcode
	.bss
	.align 8
memcode:
	.space 8
	.globl	memc
	.align 4
memc:
	.space 4
	.globl	memcsize
	.align 4
memcsize:
	.space 4
	.globl	boot
	.data
	.align 4
boot:
	.long	-1
	.globl	werror
	.bss
	.align 8
werror:
	.space 8
	.globl	cerror
	.align 8
cerror:
	.space 8
	.globl	modo
	.align 4
modo:
	.space 4
	.ident	"GCC: (tdm64-1) 4.9.2"
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	fputc;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fseek;	.scl	2;	.type	32;	.endef
	.def	ftell;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	strcpy;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	memmove;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
