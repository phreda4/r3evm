////////////////////////////////////////////////////////////
// r3 concatenative programing language - Pablo Hugo Reda
//
// Compiler to dword-code and virtual machine for r3 lang, 
//  with cell size of 64 bits, 
//

#define DEBUGVER
//#define OPTOFF
//#define NETSERVER
//#define DEBUG

#define WINDOWS
//#define LINUX
//#define RPI   // Tested on a Raspberry PI 4

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
 
#if defined(LINUX) || defined(RPI)

#include <dlfcn.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <stdint.h>

#ifdef DEBUGVER
#include <signal.h>
#endif

typedef int64_t __int64; 
typedef int32_t __int32; 
typedef int16_t __int16; 
typedef uint64_t __uint64; 
typedef uint32_t __uint32; 
typedef uint16_t __uint16; 

#ifdef NETSERVER
  #include <unistd.h>
  #include <fcntl.h>
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <arpa/inet.h>
  #include <errno.h>
  typedef int SOCKET;
  #define INVALID_SOCKET -1
  #define SET_NONBLOCK(s) fcntl(s, F_SETFL, O_NONBLOCK)
  #define CLOSE_SOCK(s) close(s)
  #define LAST_ERROR errno
#endif

#else	// WINDOWS

#include <windows.h>

#ifdef NETSERVER
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")
typedef int socklen_t;
#define SET_NONBLOCK(s) { u_long mode = 1; ioctlsocket(s, FIONBIO, &mode); }
#define CLOSE_SOCK(s) closesocket(s)
#define LAST_ERROR WSAGetLastError()
#endif

typedef unsigned __int64 __uint64;
typedef unsigned __int32 __uint32; 
typedef unsigned __int16 __uint16;  

#endif

//----------------------
/*------COMPILER------*/
//----------------------
// 0-imm 1-code 2-data 3-reserve 4-bytes 5-qwords
int modo=0; 

char *cerror=0;
char *werror;

int boot=-1;

int memcsize=0;
int memc=0;
int *memcode;

int memdsize=0xA00000;			// 10MB data 
int memd=0;
char *memdata;

char path[1024];

//---- includes
struct Include { char *nombre;char *str; };

int cntincludes;
Include includes[128];
int cntstacki;
int stacki[128];

//---- local dicctionary
struct Indice {	char *nombre;int mem;int info; };

int cntdicc;
int dicclocal;
Indice dicc[8192];

//----- aux stack for compilation
int level;
int cntstacka;
int stacka[256];
int lastblock;

void iniA(void) { cntstacka=0; }
void pushA(int n) { stacka[cntstacka++]=n; }
int popA(void) { return stacka[--cntstacka]; }

#define iclz(x) __builtin_clzll(x)

// http://www.devmaster.net/articles/fixed-point-optimizations/
static inline __int64 isqrt(__int64 value)
{
if (value==0) return 0;
int bshft = (63-iclz(value))>>1;  // spot the difference!
__int64 g = 0;
__int64 b = 1<<bshft;
do {
	__int64 temp = (g+g+b)<<bshft;
	if (value >= temp) { g += b;value -= temp;	}
	b>>=1;
} while (bshft--);
return g;
}
//----- internal tokens, replace 8 first names
const char *r3asm[]={
";","LIT1","ADR","CALL","VAR"
};

//------ base dictionary, machine-forth or machine-r3
const char *r3bas[]={
";","(",")","[","]",
"EX",
"0?","1?","+?","-?", 								
"<?",">?","=?",">=?","<=?","<>?","AND?","NAND?","IN?",
"DUP","DROP","OVER","PICK2","PICK3","PICK4","SWAP","NIP",
"ROT","-ROT","2DUP","2DROP","3DROP","4DROP","2OVER","2SWAP",
">R","R>","R@",
"AND","OR","XOR","NAND",
"+","-","*","/",
"<<",">>",">>>",
"MOD","/MOD","*/","*>>","<</",
"NOT","NEG","ABS","SQRT","CLZ",
"@","C@","W@","D@",
"@+","C@+","W@+","D@+",
"!","C!","W!","D!",
"!+","C!+","W!+","D!+",
"+!","C+!","W+!","D+!",
">A","A>","A+",
"A@","A!","A@+","A!+",
"CA@","CA!","CA@+","CA!+",
"DA@","DA!","DA@+","DA!+",
">B","B>","B+",
"B@","B!","B@+","B!+",
"CB@","CB!","CB@+","CB!+",
"DB@","DB!","DB@+","DB!+",
"AB[","]BA",
"MOVE","MOVE>","FILL",
"CMOVE","CMOVE>","CFILL",
"DMOVE","DMOVE>","DFILL",
"MEM",

"LOADLIB","GETPROC",
"SYS0","SYS1","SYS2","SYS3","SYS4","SYS5",
"SYS6","SYS7","SYS8","SYS9","SYS10",

//".",".S",
"",// !!cut the dicc!!!
#ifdef DEBUG
/**/
"JMP","JMPR","LIT2","LIT3","LITF",	// internal only
"AND_L","OR_L","XOR_L","NAND_L",	// OPTIMIZATION WORDS
"+_L","-_L","*_L","/_L",
"<<_L",">>_L",">>>_L",
"MOD_L","/MOD_L","* /_L",
"*>>_L","<</_L",
"*>>16_L","<<16/_L",
"*>>16","<<16/",
"<?_L",">?_L","=?_L",">=?_L","<=?_L","<>?_L","AN?_L","NA?_L",
"<<>>_",">>AND_",
"+@_","+C@_","+W@_","+D@_",
"+!_","+!C_","+!W_","+!D_",
"1<<+@","2<<+@","3<<+@",
"1<<+@C","2<<+@C","3<<+@C",
"1<<+@W","2<<+@W","3<<+@W",
"1<<+@D","2<<+@D","3<<+@D",
"1<<+!","2<<+!","3<<+!",
"1<<+!C","2<<+!C","3<<+!C",
"1<<+!W","2<<+!W","3<<+!W",
"1<<+!D","2<<+!D","3<<+!D",
"AA1","BA1",
"av@","avC@","avW@","avD@",
"av@+","avC@+","avW@+","avD@+",
"av!","avC!","avW!","avD!",
"av!+","avC!+","avW!+","avD!+",
"av+!","avC+!","avW+!","avD+!",
/**/
#endif
};

//------ enumaration for table jump
enum {
FIN,LIT,ADR,CALL,VAR, 
EX,
ZIF,UIF,PIF,NIF,
IFL,IFG,IFE,IFGE,IFLE,IFNE,IFAND,IFNAND,IFBT,
DUP,DROP,OVER,PICK2,PICK3,PICK4,SWAP,NIP,
ROT,MROT,DUP2,DROP2,DROP3,DROP4,OVER2,SWAP2,
TOR,RFROM,ERRE,
AND,OR,XOR,NAND,
ADD,SUB,MUL,DIV,
SHL,SHR,SHR0,
MOD,DIVMOD,MULDIV,MULSHR,CDIVSH,
NOT,NEG,ABS,CSQRT,CLZ,
FECH,CFECH,WFECH,DFECH,
FECHPLUS,CFECHPLUS,WFECHPLUS,DFECHPLUS,
STOR,CSTOR,WSTOR,DSTOR,
STOREPLUS,CSTOREPLUS,WSTOREPLUS,DSTOREPLUS,
INCSTOR,CINCSTOR,WINCSTOR,DINCSTOR,
TOA,ATO,AA,
AF,AS,AFA,ASA,
CAF,CAS,CAFA,CASA,
DAF,DAS,DAFA,DASA,
TOB,BTO,BA,
BF,BS,BFA,BSA,
CBF,CBS,CBFA,CBSA,
DBF,DBS,DBFA,DBSA,
SAVEAB,LOADBA,
MOVED,MOVEA,FILL,
CMOVED,CMOVEA,CFILL,
DMOVED,DMOVEA,DFILL,
MEM,
LOADLIB,GETPROCA,
SYSCALL0,SYSCALL1,SYSCALL2,SYSCALL3,SYSCALL4,SYSCALL5,
SYSCALL6,SYSCALL7,SYSCALL8,SYSCALL9,SYSCALL10,
//DOT,DOTS,
//ENDWORD, // !! cut the dicc !!!
JMP,JMPR,LIT2,LIT3,LITF,	// internal
AND1,OR1,XOR1,NAND1,		// OPTIMIZATION WORDS
ADD1,SUB1,MUL1,DIV1,
SHL1,SHR1,SHR01,
MOD1,DIVMOD1,MULDIV1,
MULSHR1,CDIVSH1,
MULSHR2,CDIVSH2,
MULSHR3,CDIVSH3,
IFL1,IFG1,IFE1,IFGE1,IFLE1,IFNE1,IFAND1,IFNAND1,
SHLR,SHLAR,
FECHa,CFECHa,WFECHa,DFECHa,
STORa,CSTORa,WSTORa,DSTORa,
FECH1,FECH2,FECH3,
CFECH1,CFECH2,CFECH3,
WFECH1,WFECH2,WFECH3,
DFECH1,DFECH2,DFECH3,
STOR1,STOR2,STOR3,
CSTOR1,CSTOR2,CSTOR3,
WSTOR1,WSTOR2,WSTOR3,
DSTOR1,DSTOR2,DSTOR3,
AA1,BA1,

AFECH,ACFECH,AWFECH,ADFECH,
AFECHPLUS,ACFECHPLUS,AWFECHPLUS,ADFECHPLUS,
ASTOR,ACSTOR,AWSTOR,ADSTOR,
ASTOREPLUS,ACSTOREPLUS,AWSTOREPLUS,ADSTOREPLUS,
AINCSTOR,ACINCSTOR,AWINCSTOR,ADINCSTOR,

VFECH,VCFECH,VWFECH,VDFECH,
VFECHPLUS,VCFECHPLUS,VWFECHPLUS,VDFECHPLUS,
VSTOR,VCSTOR,VWSTOR,VDSTOR,
VSTOREPLUS,VCSTOREPLUS,VWSTOREPLUS,VDSTOREPLUS,
VINCSTOR,VCINCSTOR,VWINCSTOR,VDINCSTOR

};

//////////////////////////////////////
// DEBUG -- remove when all work ok
//////////////////////////////////////
#ifdef DEBUG
void printword(char *s)
{
while (*s>32) putchar(*s++);
putchar(' ');
}

void printcode(int n)
{
if ((n&0xff)<5 && n!=0) {
	printf(r3asm[n&0xff]);printf(" %x",n>>8);
} else if (((n&0xff)>=IFL && (n&0xff)<=IFNAND) || (n&0xff)==JMPR) {	
	printf(r3bas[n&0xff]);printf(" >> %d",n>>8);
} else if ((n&0xff)>=IFL1 && (n&0xff)<=IFNAND1) {	
	printf(r3bas[n&0xff]);printf(" %d",n>>16);printf(" >> %d",n<<16>>24);
} else if ((n&0xff)>SYSCALL10 ) {
	printf(r3bas[(n&0xff)+1]);printf(" %x",n>>8);	
} else 
	printf(r3bas[n&0xff]);
printf("\n");
}

void dumpcode()
{
printf("code\n");
printf("boot:%x\n",boot);
for(int i=1;i<memc;i++) {
	printf("%x:%x:",i,memcode[i]);
	printcode(memcode[i]);
	if ((memcode[i]&0xff)>=AFECH) printf("***\n");
	}
printf("\n");
}

void dumpinc()
{
printf("includes\n");
for(int i=0;i<cntincludes;i++) {
	printf("%d. ",i);
	printword(includes[i].nombre);
	printf("\n");
	}
for(int i=0;i<cntstacki;i++) {
	printf("%d. %d\n",i,stacki[i]);
	}
}

void dumpdicc()
{
printf("diccionario\n");
for(int i=0;i<cntdicc;i++) {
	printf("%d. ",i);
	printword(dicc[i].nombre);
	printf("%x ",dicc[i].mem);	
	printf("%x \n",dicc[i].info);	
	}
}

#endif

//////////////////////////////////////
// Compiler: from text to dwordcodes
//////////////////////////////////////

// scan for a valid number begin in *p char
// return number in global var "nro"

__int64 nro=0;

int isNro(char *p)
{
//if (*p=='&') { p++;nro=*p;return -1;} // codigo ascii
int dig=0,signo=0,base;
if (*p=='-') { p++;signo=1; } else if (*p=='+') p++;
if ((unsigned char)*p<33) return 0;// no es numero
switch(*p) {
  case '$': base=16;p++;break;// hexa
  case '%': base=2;p++;break;// binario
  default:  base=10;break; 
  }; 
nro=0;if ((unsigned char)*p<33) return 0;// no es numero
while ((unsigned char)*p>32) {
  if (base!=10 && *p=='.') dig=0;  
  else if (*p<='9') dig=*p-'0'; 
  else if (*p>='a') dig=*p-'a'+10;  
  else if (*p>='A') dig=*p-'A'+10;  
  else return 0;
  if (dig<0 || dig>=base) return 0;
  nro*=base;nro+=dig;
  p++;
  };
if (signo==1) nro=-nro;  
return -1; 
};

// scan for a valid fixed point number begin in *p char
// return number in global var "nro"

int isNrof(char *p)         // decimal punto fijo 16.16
{
__int64 parte0;
int dig=0,signo=0;
if (*p=='-') { p++;signo=1; } else if (*p=='+') p++;
if ((unsigned char)*p<33) return 0;// no es numero
nro=0;
while ((unsigned char)*p>32) {
  if (*p=='.') { parte0=nro;nro=1;if (*(p+1)<33) return 0; } 
  else  {
  	if (*p<='9') dig=*p-'0'; else dig=-1;
  	if (dig<0 || dig>9) return 0;
  	nro=(nro*10)+dig;
  	}
  p++;
  };  
int decim=1;
__int64 num=nro;
while (num>1) { decim*=10;num/=10; }
num=0x10000*nro/decim;
nro=(num&0xffff)|(parte0<<16);
if (signo==1) nro=-nro;
return -1; 
};

// uppercase a char
char toupp(char c)
{ 
return c&0xdf;
}

// compare two string until len char
int strnicmp(const char *s1, const char *s2, size_t len)
{
int diff=0;
while (len--&&*s1&&*s2) {
	if (*s1!=*s2) if (diff=(int)toupp(*s1)-(int)toupp(*s2)) break;
	s1++;s2++;
    }
return diff;
}

// compare two words, until space	
int strequal(char *s1,char *s2)
{
while ((unsigned char)*s1>32) {
	if (toupp(*s2++)!=toupp(*s1++)) return 0;
	}
if (((unsigned char)*s2)>32) return 0;
return -1;
}
	
// advance pointer with space	
char *trim(char *s)	
{
while (((unsigned char)*s)<33&&*s!=0) s++;
return s;
}

// advance to next word
char *nextw(char *s)	
{
while (((unsigned char)*s)>32) s++;
return s;
}

// advance to next line
char *nextcr(char *s)	
{
while (((unsigned char)*s)>31||*s==9) s++;
return s;
}

// advance to next string ("), admit "" for insert " in a string, multiline is ok too
char *nextstr(char *s) 
{
s++;
while (*s!=0) { if (*s==34) { s++;if (*s!=34) { s++;break; } } s++; }
return s;
}

// ask for a word in the basic dicc
int isBas(char *p)
{    
nro=0;
char **m=(char**)r3bas;
while (**m!=0) { if (strequal(*m,p)) return -1; 
	*m++;nro++; }
return 0;  
};

// ask for a word in the dicc, calculate local or exported too
int isWord(char *p) 
{ 
int i=cntdicc;
while (--i>-1) { 
	if (strequal(dicc[i].nombre,p) && ((dicc[i].info&1)==1 || i>=dicclocal)) return i;
	}
return -1;
};

// compile a token (int)
void codetok(int nro) 
{ 
memcode[memc++]=nro; 
}

// close variable definition with a place when no definition
void closevar() 
{
if (cntdicc==0) return;
if (!dicc[cntdicc-1].info&0x10) return; // prev is var
if (dicc[cntdicc-1].mem<memd) return;  		// have val
memdata[memd]=0;memd+=8; // now 64 bits
}

// compile data definition, a VAR
void compilaDATA(char *str) 
{ 
int ex=0;
closevar();
if (*(str+1)=='#') { ex=1;str++; } // exported
dicc[cntdicc].nombre=str+1;
//memd+=memd&3; // align data!!!
dicc[cntdicc].mem=memd;
dicc[cntdicc].info=ex|0x10;	// 0x10 es dato
cntdicc++;
modo=2;
}

// compile a code definition, a WORD	
void compilaCODE(char *str) 
{ 
int ex=0;
closevar();
if (*(str+1)==':') { ex=1;str++; } // exported
dicc[cntdicc].nombre=str+1;
dicc[cntdicc].mem=memc;
dicc[cntdicc].info=ex;	// 0x10 es dato
cntdicc++;
if (*(str+1)<33) { 
	ex=boot;boot=memc; 
	if (ex!=-1) { codetok((ex<<8)|CALL); } // call to prev boot code
	}
modo=1;
lastblock=memc;
}

// store in datamemory a string
int datasave(char *str) 
{
int r=memd;
for(;*str!=0;str++) { 
	if (*str==34) { str++;if (*str!=34) break; }
	memdata[memd++]=*str;
	}
memdata[memd++]=0;	
return r;
}

// compile a string, in code save the token to retrieve too.
void compilaSTR(char *str) 
{
str++;
int ini=datasave(str);	
if (modo<2) codetok((ini<<8)|ADR); // lit data
}

// Store in datamemory a number or reserve mem
void datanro(__int64 n) { 
char *p=&memdata[memd];	
switch(modo){
	case 2:*(__int64*)p=(__int64)n;memd+=8;break;
	case 3:	for(int i=0;i<n;i++) { *p++=0; };memd+=n;break;
	case 4:*p=(char)n;memd+=1;break;
	case 5:*(int*)p=(int)n;memd+=4;break;
	}
}

// Compile adress of var
void compilaADDR(int n) 
{
if (modo>1) { 
	if ((dicc[n].info&0x10)==0)
		datanro(dicc[n].mem);
	else
		datanro((__int64)&memdata[dicc[n].mem]);	
	return; 
	}
codetok((dicc[n].mem<<8)+LIT+((dicc[n].info>>4)&1));  //1 code 2 data
}

// Compile literal
void compilaLIT(__int64 n) 
{
if (modo>1) { datanro(n);return; }
int token=n;
codetok((token<<8)|LIT); 
if ((token<<8>>8)==n) return;
/* FAST but insegure for optimization */
/*
memc--;
memcode[memc++]=LITF; 
*(__int64*)&memcode[memc]=n;
memc+=2;
*/
/* SLOW but not false token */
token=n>>24;
codetok((token<<8)|LIT2); 
if ((token<<8>>8)==(n>>24)) return;
token=n>>48;
codetok((token<<8)|LIT3); 
}

// Start block code (
void blockIn(void)
{
pushA(memc);
level++;
lastblock=memc;
}

// solve conditional void
int solvejmp(int from,int to) 
{
int whi=false;
for (int i=from;i<to;i++) {
	int op=memcode[i]&0xff;
	if (op>=ZIF && op<=IFBT && (memcode[i]>>8)==0) { // patch while 
		memcode[i]|=(memc-i)<<8;	// full dir
		whi=true;
	} else if (op>=IFL1 && op<=IFNAND1 && (memcode[i]&0xff00)==0) { // patch while 
		memcode[i]|=((memc-i)<<8)&0xff00; // byte dir
		whi=true;
		}
	}
return whi;
}

// end block )
void blockOut(void)
{
int from=popA();
int dist=memc-from;
if (solvejmp(from,memc)) { // salta
	codetok((-(dist+1)<<8)|JMPR); 	// jmpr
} else { // patch if	
	if ((memcode[from-1]&0xff)>=IFL1 && (memcode[from-1]&0xff)<=IFNAND1) { 
		memcode[from-1]|=(dist<<8)&0xff00;	// byte dir
	} else {
		memcode[from-1]|=(dist<<8);		// full dir
		}
	}
level--;	
lastblock=memc;
}

// start anonymous definition (adress only word)
void anonIn(void)
{
pushA(memc);
codetok(JMP);	
level++;
lastblock=memc;
}

// end anonymous definition, save adress in stack
void anonOut(void)
{
int from=popA();
memcode[from]|=(memc<<8);	// patch jmp
codetok((from+1)<<8|LIT);
level--;	
lastblock=memc;
}

// dicc base in data definition
void dataMAC(int n)
{
if (n==1) modo=4; // (	bytes
if (n==2) modo=2; // )
if (n==3) modo=5; // [	qwords
if (n==4) modo=2; // ]
if (n==MUL) modo=3; // * reserva bytes Qword Dword Kbytes
}

inline __int64 lite(int tok) { return (tok>>8); }

inline void back(__int64 n) { memc-=2;compilaLIT(n); }
inline void back1(__int64 n) { memc--;compilaLIT(n); }

int constfold(int n,int tok1,int tok2) // TOS,NOS
{ __int64 t;
switch(n) {
	case AND: t=lite(tok1)&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case OR: t=lite(tok1)|lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case XOR: t=lite(tok1)^lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case NAND: t=(~lite(tok1))&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case ADD: t=lite(tok1)+lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case SUB: t=lite(tok2)-lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case MUL: t=lite(tok1)*lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case DIV: t=lite(tok2)/lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case SHL: t=lite(tok2)<<lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case SHR: t=lite(tok2)>>lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case SHR0: t=(__uint64)(lite(tok2))>>lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case MOD: t=lite(tok2)%lite(tok1);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	//case DIVMOD: t=lite(tok1)&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	//case MULDIV: t=lite(tok1)&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	//case MULSHR: t=lite(tok1)&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	//case CDIVSH: t=lite(tok1)&lite(tok2);if ((tok2&0xff)==LIT) { back(t);return 1; } break;
	case NOT: t=~lite(tok1);back1(t);return 1; 
	case NEG: t=-lite(tok1);back1(t);return 1;
	case ABS: t=lite(tok1);if (t<0)t=-t;back1(t);return 1;
	case CSQRT: t=isqrt(lite(tok1));back1(t);return 1;
	case CLZ: t=iclz(lite(tok1));back1(t);return 1;
	}
	
return 0;
}
// compile word from base diccionary
void compilaMAC(int n) 
{
int tokpre=(lastblock==memc)?0:memcode[memc-1];
int tokpre2=(lastblock>=(memc-1))?0:memcode[memc-2];
if (modo>1) { dataMAC(n);return; }
if (n==0) { 					// ;
	if (level==0) { 
		modo=0; 
		if (memc-dicc[cntdicc-1].mem<4) dicc[cntdicc-1].info|=2; // INLINE (until 3 tokens)
	} else {
		dicc[cntdicc-1].info|=4; // multi ;
		}
	if ((tokpre&0xff)==CALL) { // avoid jmp to block
		memcode[memc-1]=(tokpre^CALL)|JMP; // call->jmp avoid ret
		return;
		}
	}
if (n==1) { blockIn();return; }		//(	etiqueta
if (n==2) { blockOut();return; }	//)	salto
if (n==3) { dicc[cntdicc-1].info|=4;anonIn();return; }		//[	salto:etiqueta
if (n==4) { dicc[cntdicc-1].info|=4;anonOut();return; }		//]	etiqueta;push

#ifndef OPTOFF // DISABLE
///////////////////////// OPTIMIZATION
// CONSTANT FOLDING
if (n>=AND && n<=CLZ && (tokpre&0xff)==LIT) {
	if (constfold(n,tokpre,tokpre2)==1) return;
	}
// optimize conditional jump to short version
if (n>=IFL && n<=IFNAND && (tokpre&0xff)==LIT && (tokpre<<8>>16)==(tokpre>>8)) { 
	memcode[memc-1]=((tokpre<<8)&0xffff0000)|(n-IFL+IFL1);
	return; 
	}
// SHLR  (<<)(>>)
if (n==SHR && (tokpre&0xff)==LIT && (tokpre2&0xff)==SHL1) {
	memcode[memc-2]=((tokpre<<8)&0xff0000)|(tokpre2&0xff00)|SHLR;
	memc--;
	return; 	
	}
// SHLAR  (>>)(and) 18 bit mask 
if (n==AND && (tokpre&0xff)==LIT && (tokpre2&0xff)==SHR1 && (tokpre&0xfc000000)==0) {
	memcode[memc-2]=((tokpre<<6)&0xffffc000)|(tokpre2&0x3f00)|SHLAR;
	memc--;
	return; 	
	}
// LIT 16 *>> <</
if ((n==MULSHR || n==CDIVSH) && (tokpre==((16<<8)|LIT))) {
	if ((tokpre2&0xff)==LIT) {
		memcode[memc-2]=(tokpre2&0xffffff00)|(n-MULSHR+MULSHR2);
		memc--;
		return; 	
		}
	memcode[memc-1]=(n-MULSHR+MULSHR3); // 16 *>> <</
	return; 	
	}
// optimize operation with constant (NRO OP)
if (n>=AND && n<=CDIVSH && (tokpre&0xff)==LIT) { 
	memcode[memc-1]=(tokpre^LIT)|(n-ADD+ADD1);
	return; 
	}
if (n>=FECH && n<=DFECH) {
	if ((tokpre&0xff)==ADD1) { // cte + @ c@ w@ d@ 	
		memcode[memc-1]=(tokpre^ADD1)|(n-FECH+FECHa);
		return;
		}
	if ((tokpre&0xff)==ADD && (tokpre2&0xff)==SHL1 && (tokpre2>>8)<4 && (tokpre2>>8)>0) { // 1|2|3 << + @ c@ w@ d@
		memcode[memc-2]=FECH1+((n-FECH)*3)+(tokpre2>>8)-1; // 0 1 2 3 * + 1 2 3 
		memc--;
		return;
		}
	}		
if (n>=STOR && n<=DSTOR) {
	if ((tokpre&0xff)==ADD1) { // cte + ! c! w! d!
		memcode[memc-1]=(tokpre^ADD1)|(n-STOR+STORa);
		return;
		}
	if ((tokpre&0xff)==ADD && (tokpre2&0xff)==SHL1 && (tokpre2>>8)<4 && (tokpre2>>8)>0) { // 1|2|3 << + ! c! w! d!
		memcode[memc-2]=STOR1+((n-STOR)*3)+(tokpre2>>8)-1; // 0 1 2 3 * + 1 2 3 
		memc--;
		return;
		}
	}
// cte a+ b+
if ((tokpre&0xff)==LIT && (n==AA||n==BA)) {
	memcode[memc-1]=(tokpre^LIT)|((n==AA)?AA1:BA1);
	return;
	}
// 'adr !..+!
if (n>=FECH && n<=DINCSTOR) {
	if ((tokpre&0xff)==ADR) {
		memcode[memc-1]=(tokpre^ADR)|(n-FECH+AFECH);
		return;
		}
	if ((tokpre&0xff)==VAR) {
		memcode[memc-1]=(tokpre^VAR)|(n-FECH+VFECH);
		return;
		}
	}
#endif	
///////////////////////// OPTIMIZATION

// ALWAYS VAR SYSCALL !!!
if (n>=SYSCALL0 && n<=SYSCALL10 && (tokpre&0xff)==VAR) {
	memcode[memc-1]=(tokpre^VAR)|n;
	return;
	} // show error if not??

codetok(n);	
}

void compilainline(int memt) 
{
int i;
for(i=memt;(memcode[i]!=0)&&(memcode[i]&0xff)!=JMP;i++) {
	if (memcode[i]>=AND&&memcode[i]<=BA) { 
		compilaMAC(memcode[i]);
	} else { 
		codetok(memcode[i]);
		}
	}
if ((memcode[i]&0xff)==JMP) {
	codetok((memcode[i]^JMP)|CALL);
	}
}

// compile word
void compilaWORD(int n) 
{
if (modo>1) { datanro(n);return; }
//printf("COMPILA %x (%x)\n",dicc[n].mem,dicc[n].info);

#ifndef OPTOFF
if ((dicc[n].info&6)==2) { 
	//printword(dicc[n].nombre);printf(" INLINE %x (%x)\n",dicc[n].mem,dicc[n].info);
	compilainline(dicc[n].mem);return; } // INLINE, no ;;
#endif

codetok((dicc[n].mem<<8)+CALL+((dicc[n].info>>4)&1));
}

// --- error in code --
void seterror(char *f,char *s)
{
werror=s;
cerror=f;	
}

// print error info 
void printerror(char *name,char *src)
{
int line=1;
char *lc=src,*lca;
char *le,linee[1024];
for (char *p=src;p<cerror;p++)
	if (*p==10) { if (*(p+1)==13) p++;
		line++;lc=p+1;
	} else if (*p==13) { if (*(p+1)==10) p++;
		line++;lc=p+1; }
*nextcr(lc)=0; // 0 in end of line
le=&linee[0];
lca=lc;
while (*lc>31||*lc==9) {
	if (*lc==0x25) *le++=0x25;
	*le++=*lc++;
	};
*le=0;
*nextcr(name)=0;
fprintf(stderr,"FILE:%s LINE:%d CHAR:%d\n\n",name,line,cerror-lca);	
fprintf(stderr,"%4d|%s\n     ",line,linee);
for(char *p=lca;p<cerror;p++) if (*p==9) fprintf(stderr,"\t"); else fprintf(stderr," ");
fprintf(stderr,"^- %s\n",werror);	
}

// |WEB| emscripten only
// |LIN| linux only
// |WIN| windows only
// |RPI| Raspberry PI only
char *nextcom(char *str)
{
#if defined(LINUX)
  if (strnicmp(str,"|LIN|",5)==0) {	// linux specific
    return str+5;
  }
#elif defined(EMSCRIPTEN)
  if (strnicmp(str,"|WEB|",5)==0) {	// web specific
    return str+5;
  }
#elif defined(RPI)
  if (strnicmp(str,"|RPI|",5)==0) {	// raspberry pi specific
    return str+5;
  }
#else
  if (strnicmp(str,"|WIN|",5)==0) {	// window specific
    return str+5;
  }
#endif
  
  return nextcr(str);
}

// tokeniza string
int r3token(char *str) 
{
level=0;
while(*str!=0) {
	str=trim(str);if (*str==0) return -1;
	switch (*str) {
		case '^':	// include
			str=nextcr(str);break;
		case '|':	// comments	
			str=nextcom(str);break; 
		case '"':	// strings		
			compilaSTR(str);str=nextstr(str);break;
		case ':':	// $3a :  Definicion	// :CODE
			compilaCODE(str);str=nextw(str);break;
		case '#':	// $23 #  Variable	// #DATA
			compilaDATA(str);str=nextw(str);break;	
		case 0x27:	// $27 ' Direccion	// 'ADR
			nro=isWord(str+1);
			if (nro<0) { seterror(str,(char*)"adr not found");return 0; }
			compilaADDR(nro);str=nextw(str);break;		
		default:
			if (isNro(str)||isNrof(str)) { 
				compilaLIT(nro);str=nextw(str);break; }
			if (isBas(str)) { 
				compilaMAC(nro);str=nextw(str);
				if (level<0) { seterror(str,(char*)"Bad block");return 0; }
				break; }
			nro=isWord(str);
			if (nro<0) { seterror(str,(char*)"word not found");return 0; }
			if (modo==1) 
				compilaWORD(nro); 
			else 
				compilaADDR(nro);
			str=nextw(str);break;
		}
	}
return -1;
}

// open, alloc and load file to string in memory
char *openfile(char *from,char *filename)
{
long len;
char *buff;
FILE *f=fopen(filename,"rb");
if (!f) { 
	*nextcr(from)=0;
	fprintf(stderr,"FILE:%s LINE:%d CHAR:%d\n\n%s not found\n",from,cerror,cerror,filename);
	cerror=(char*)1;
	return 0;
	}
fseek(f,0,SEEK_END);len=ftell(f);fseek(f,0,SEEK_SET);
buff=(char*)malloc(len+1);
if (!buff) return 0;
fread(buff,1,len,f); 
fclose(f);
buff[len]=0;
return buff;
/*	
int fd=open(name,O_RDONLY);
int len=lseek(fd,0,SEEK_END);
void *data=mmap(0,len,PROT_READ,MAP_PRIVATE,fd,0);
*/  
}

// include logic, not load many times
int isinclude(char* from,char *str)
{
char filename[1024];
char *fn=filename;	
char *ns=str;	

if (*str=='.') {
	str++;
	strcpy(filename,path);
	while (*fn!=0) fn++;
	}
	
while ((unsigned char)*str>31) { *fn++=*str++; }
*fn=0;
//printf("[%s]",filename);

for (int i=0;i<cntincludes;i++){
	if (strequal(includes[i].nombre,ns)) return -1;
	}
includes[cntincludes].nombre=ns; // ./coso y coso son distintos !!
includes[cntincludes].str=openfile(from,filename); 
cntincludes++;	
return cntincludes-1;
}

// free source code of includes
void freeinc()
{
for (int i=0;i<cntincludes;i++){
	free(includes[cntincludes].str);
	}
}

//----------- comments / configuration
// |MEM 640 		set data memory size (in kb) min 1kb
char *syscom(char *str)
{
if (strnicmp(str,"|MEM ",5)==0) {	// memory in Kb
	if (isNro(trim(str+5))) {
		memdsize=nro<<20;
		if (memdsize<1<<20)	memdsize=1<<20; // 1MB min
		}
	}	
return nextcom(str);
}

// resolve includes, recursive definition
void r3includes(char *from,char *str) 
{
if (str==0) return;
//if (*str=='.') { }
	
int ninc;	
while(*str!=0) {
	str=trim(str);
	switch (*str) {
		case '^':	// include
			ninc=isinclude(from,str+1);
			if (ninc>=0) {
				r3includes(includes[ninc].nombre,includes[ninc].str);
				stacki[cntstacki++]=ninc;
				}
			str=nextcr(str);
			break;
		case '|':	// comments	
			str=syscom(str);break;
		case ':':	// code
			modo=1;str=nextw(str);break;
		case '#':	// data	
			modo=0;str=nextw(str);break;			
		case '"':	// strings		
			memcsize+=modo;str=nextstr(str);break;
		default:	// resto
			memcsize+=modo;str=nextw(str);break;
		}
	}
return;
}

// Compile code in file
int r3compile(char *name) 
{
//printf("\nr3vm - PHREDA\n");
//printf("compile:%s...",name);

char *sourcecode;

strcpy(path,name);// para ^. ahora pone el path del codigo origen
char *aa=path+strlen(path);
while (path<aa) { if (*aa=='/'||*aa=='\\') { *aa=0;break; } aa--; }
 
//printf("*%s*",path);

sourcecode=openfile(name,name);
if (sourcecode==0) return 0;
memcsize=0;
cntincludes=0;
cntstacki=0;
r3includes(name,sourcecode); // load includes

if (cerror!=0) return 0;
//dumpinc();

cntdicc=0;
dicclocal=0;
boot=-1;
memc=1; // direccion 0 para null
memd=0;

#if defined(LINUX)
 memcode=(int*)mmap(NULL,sizeof(int)*memcsize,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE|MAP_32BIT,-1,0);
 memdata=(char*)mmap(NULL,memdsize,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE|MAP_32BIT,-1,0);
#elif defined(RPI)
 memcode=(int*)mmap(NULL,sizeof(int)*memcsize,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE/*|MAP_32BIT*/,-1,0);
 memdata=(char*)mmap(NULL,memdsize,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE/*|MAP_32BIT*/,-1,0);
#else
 memcode=(int*)malloc(sizeof(int)*memcsize);
 memdata=(char*)malloc(memdsize);
#endif


// tokenize includes
for (int i=0;i<cntstacki;i++) {
	if (!r3token(includes[stacki[i]].str)) {
		printerror(includes[stacki[i]].nombre,includes[stacki[i]].str);
		return 0;
		}
	dicclocal=cntdicc;
	}
// last tokenizer		
if (!r3token(sourcecode)) {
	printerror(path,sourcecode);
	return 0;
	}

//memd+=memd&3; // align

//dumpdicc();
//dumpcode();

//printf(" ok.\n");
//printf("inc:%d - words:%d - code:%dKb - data:%dKb - free:%dKb\n\n",cntincludes,cntdicc,memc>>8,memd>>10,(memdsize-memd)>>10);
freeinc();
free(sourcecode);
return -1;
}
	
//----------------------
/*--------RUNER--------*/
//----------------------
/////////////////////////////////////////////////////////////
#ifdef NETSERVER

#define BUFF_SIZE 4096
#define LOCALHOST "127.0.0.1"

typedef struct {
  SOCKET sock;
  char rx_buf[BUFF_SIZE];
  int rx_len;
} conn_t;

static conn_t conn;

void init_winsock(void) {
#ifdef _WIN32
  WSADATA wsa;
  if (WSAStartup(MAKEWORD(2, 2), &wsa)) {
    fprintf(stderr, "WSAStartup error\n");
    exit(1);
  }
#endif
}

void cleanup_winsock(void) {
#ifdef _WIN32
  WSACleanup();
#endif
}

int server_create(int port) {
  struct sockaddr_in addr;
  conn.sock = socket(AF_INET, SOCK_STREAM, 0);
  if (conn.sock == INVALID_SOCKET) {
    perror("socket");
    return -1;
	}
  SET_NONBLOCK(conn.sock);
  int reuse = 1;
  if (setsockopt(conn.sock, SOL_SOCKET, SO_REUSEADDR, (char*)&reuse, sizeof(reuse)) < 0) {
    perror("setsockopt");
    CLOSE_SOCK(conn.sock);
    return -1;
	}
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = inet_addr(LOCALHOST);
  addr.sin_port = htons(port);
  if (bind(conn.sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
    perror("bind");
    CLOSE_SOCK(conn.sock);
    return -1;
	}
  if (listen(conn.sock, 1) < 0) {
    perror("listen");
    CLOSE_SOCK(conn.sock);
    return -1;
	}
//  printf("Servidor escuchando en 127.0.0.1:%d\n", port);
  conn.rx_len = 0;
  return 0;
}

int client_connect(int port) {
  struct sockaddr_in addr;
  conn.sock = socket(AF_INET, SOCK_STREAM, 0);
  if (conn.sock == INVALID_SOCKET) { perror("socket");return -1;	}
  SET_NONBLOCK(conn.sock);
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = inet_addr(LOCALHOST);
  addr.sin_port = htons(port);
  if (connect(conn.sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
#ifdef _WIN32
    if (LAST_ERROR != WSAEWOULDBLOCK) {
#else
    if (LAST_ERROR != EINPROGRESS) {
#endif
      perror("connect"); CLOSE_SOCK(conn.sock);return -1; }
	}
//  printf("Conectando a 127.0.0.1:%d\n", port);
  conn.rx_len = 0;
  return 0;
}

int server_accept(void) {
  struct sockaddr_in addr;
  socklen_t len = sizeof(addr);
  SOCKET cli_sock = accept(conn.sock, (struct sockaddr*)&addr, &len);
  if (cli_sock == INVALID_SOCKET) {return -1;}
  CLOSE_SOCK(conn.sock);
  conn.sock = cli_sock;
  conn.rx_len = 0;
  SET_NONBLOCK(conn.sock);
//  printf("Cliente conectado\n");
  return 0;
}

int sock_send(const char *data, int len) {
  int n = send(conn.sock, data, len, 0);
  return (n > 0) ? n : 0;
}

int sock_recv(void) {
  int n = recv(conn.sock, conn.rx_buf + conn.rx_len, BUFF_SIZE - conn.rx_len - 1, 0);
  if (n > 0) {
    conn.rx_len += n;
    conn.rx_buf[conn.rx_len] = '\0';
    return n;
	}
  if (n == 0) {return -1;}
  if (n < 0) {
#ifdef _WIN32
    if (LAST_ERROR == WSAECONNRESET || LAST_ERROR == WSAECONNABORTED) {return -1;}
#else
    if (LAST_ERROR == ECONNRESET || LAST_ERROR == ECONNABORTED) {return -1;}
#endif
  }  
return 0;
}

void sock_close(void) {
  CLOSE_SOCK(conn.sock);
}

void sock_flush(void) {
  conn.rx_len = 0;
  conn.rx_buf[0] = '\0';
}

conn_t* get_conn(void) {
  return &conn;
}
#endif
/////////////////////////////////////////////////////////////

void memset32(__uint32 *dest,__uint32 val, __uint32 count)
{ while (count--) *dest++ = val; }

void memset64(__uint64 *dest,__uint64 val,__uint32 count)
{ while (count--) *dest++ = val; }

__int64 datastack[512];
__int64 retstack[512];

__int64 TOS=0;
__int64 *NOS;
__int64 *RTOS;
__int64 REGA=0;
__int64 REGB=0;
int ip;

/////////////////////////////////////////////////////////////
// write error

void fword(FILE *f,char *s) {
while (*s>32) fputc(*s++,f);
}

void errorinc(FILE *f)
{
fprintf(f,"includes\n");
for(int i=0;i<cntincludes;i++) {
	fprintf(f,"%d. ",i);
	fword(f,includes[i].nombre);
	fprintf(f,"\n");
	}
for(int i=0;i<cntstacki;i++) {
	fprintf(f,"%d. %d\n",i,stacki[i]);
	}
}


void fprintcode(FILE *f,int n) {
if ((n&0xff)<5 && n!=0) {
	fprintf(f,r3asm[n&0xff]);fprintf(f," %x",n>>8);
} else if (((n&0xff)>=IFL && (n&0xff)<=IFNAND) || (n&0xff)==JMPR) {	
	fprintf(f,r3bas[n&0xff]);fprintf(f," >> %d",n>>8);
} else if ((n&0xff)>=IFL1 && (n&0xff)<=IFNAND1) {	
	fprintf(f,r3bas[n&0xff]);fprintf(f," %d",n>>16);fprintf(f," >> %d",n<<16>>24);
} else if ((n&0xff)>SYSCALL10 ) {
	fprintf(f,r3bas[(n&0xff)+1]);fprintf(f," %x",n>>8);	
} else 
	fprintf(f,r3bas[n&0xff]);
fprintf(f,"\n");
}

void errorcode(FILE *f) {
int dic=0;
while (dicc[dic].info&0x10) dic++;
for(int i=1;i<memc;i++) {
	if (dicc[dic].mem==i) {
		fprintf(f,"=== %x. ",dic);
		fword(f,dicc[dic].nombre-1);
		fprintf(f," %x ",dicc[dic].mem);	
		fprintf(f,"%x ===\n",dicc[dic].info);			
		dic++;
		while (~(dicc[dic].info&0x10) && dicc[dic].mem==dicc[dic-1].mem) dic++;
		while (dicc[dic].info&0x10) dic++;
		}
	fprintf(f,"%x:%x:",i,memcode[i]);
	fprintcode(f,memcode[i]);
	if ((memcode[i]&0xff)>=AFECH) fprintf(f,"***\n");
	}
fprintf(f,"\n");
}

void errordicc(FILE *f)
{
for(int i=0;i<cntdicc;i++) {
	fprintf(f,"%x. ",i);
	fword(f,dicc[i].nombre-1);
	fprintf(f," %x ",dicc[i].mem);	
	fprintf(f,"%x \n",dicc[i].info);	
	}
}


void print_error(void* error_code) {
#ifdef _WIN32
    DWORD code = (DWORD)(uintptr_t)error_code;
    const char* msg;
    switch (code) {
        case EXCEPTION_ACCESS_VIOLATION:              msg = "MEM INV"; break;
        case EXCEPTION_DATATYPE_MISALIGNMENT:         msg = "Desalineación de tipo de dato"; break;
        case EXCEPTION_BREAKPOINT:                    msg = "Punto de interrupción"; break;
        case EXCEPTION_SINGLE_STEP:                   msg = "Paso único (debug)"; break;
        case EXCEPTION_ARRAY_BOUNDS_EXCEEDED:         msg = "Límites de array excedidos"; break;
        case EXCEPTION_FLT_DENORMAL_OPERAND:          msg = "Operando flotante denormal"; break;
        case EXCEPTION_FLT_DIVIDE_BY_ZERO:            msg = "División flotante por cero"; break;
        case EXCEPTION_FLT_INEXACT_RESULT:            msg = "Resultado flotante inexacto"; break;
        case EXCEPTION_FLT_INVALID_OPERATION:         msg = "Operación flotante inválida"; break;
        case EXCEPTION_FLT_OVERFLOW:                  msg = "Desbordamiento flotante"; break;
        case EXCEPTION_FLT_STACK_CHECK:               msg = "Verificación de stack flotante"; break;
        case EXCEPTION_FLT_UNDERFLOW:                 msg = "Subdesbordamiento flotante"; break;
        case EXCEPTION_INT_DIVIDE_BY_ZERO:            msg = "/0"; break;
        case EXCEPTION_INT_OVERFLOW:                  msg = "Desbordamiento entero"; break;
        case EXCEPTION_PRIV_INSTRUCTION:              msg = "Instrucción privilegiada"; break;
        case EXCEPTION_IN_PAGE_ERROR:                 msg = "Error en página (memoria no residente)"; break;
        case EXCEPTION_ILLEGAL_INSTRUCTION:           msg = "Instrucción ilegal"; break;
        case EXCEPTION_NONCONTINUABLE_EXCEPTION:      msg = "Excepción no continuable"; break;
        case EXCEPTION_STACK_OVERFLOW:                msg = "Desbordamiento de stack"; break;
        case EXCEPTION_GUARD_PAGE:                    msg = "Página guard (protección memoria)"; break;
        case CONTROL_C_EXIT:                          msg = "Salida por Ctrl+C"; break;
        case STATUS_FLOAT_MULTIPLE_FAULTS:            msg = "Múltiples fallos flotantes"; break;
        case STATUS_FLOAT_MULTIPLE_TRAPS:             msg = "Múltiples trampas flotantes"; break;
        default:                                      msg = "Excepción desconocida"; break;
    }
  
#else
    int sig = (int)(uintptr_t)error_code;
    const char* msg;
    switch (sig) {
        case SIGABRT: msg = "Señal de abort (ej. assert o abort())"; break;
        case SIGBUS:  msg = "Error de bus (acceso memoria no alineado o inválido)"; break;
        case SIGFPE:  msg = "Error de punto flotante (div/0, overflow, etc.)"; break;
        case SIGILL:  msg = "Instrucción ilegal (opcode inválido)"; break;
        case SIGSEGV: msg = "Violación de segmento (acceso a ptr NULL o inválido)"; break;
        case SIGPIPE: msg = "Broken pipe (escritura a canal cerrado)"; break;
        case SIGTERM: msg = "Señal de terminación (kill -TERM)"; break;
        // Opcional: case SIGINT: msg = "Interrupción (Ctrl+C)"; break;
        default:      msg = "Señal desconocida"; break;
    }
#endif
FILE *fe;
int i,sd,sr;
sd=(NOS-(&datastack[0]));
sr=(&retstack[512-1])-RTOS;
fe=fopen("r3.err","w+");
fprintf(fe,"RUNTIME ERROR: %s ($%lx)\n", msg, code);
fprintf(fe,"MC:$%x ",memcode);
fprintf(fe,"MD:$%x ",memdata);
fprintf(fe,"B:$%x ",boot);
fprintf(fe,"I:$%x ",ip);
fprintf(fe,"IN:%s\n",r3bas[memcode[ip-1]]);

//TOS=0;//NOS = &datastack[0];//RTOS = &retstack[512 - 1];
fprintf(fe,"D:%d\n",sd);
for(int i=2;i<sd+1;i++) {
	fprintf(fe,"$%x ",datastack[i]);
	}
fprintf(fe,"$%x\n",TOS);
fprintf(fe,"R:%d\n",sr);
for(int i=510;i>510-sr;i--) {
	fprintf(fe,"$%x ",retstack[i]);
	}
fprintf(fe,"\n");
fprintf(fe,"A:$%x B:$%x\n",REGA,REGB);
//fprintf(fe,"DICC:\n");errordicc(fe);
fprintf(fe,"CODE:\n");errorcode(fe);
fclose(fe);
}

/////////////////////////////////////////////////////////////
#ifdef WINDOWS

LONG WINAPI error_filter(PEXCEPTION_POINTERS pExInfo) {
    DWORD code = pExInfo->ExceptionRecord->ExceptionCode;
    print_error((void*)(uintptr_t)code);  // Casteo para unificar
    return EXCEPTION_EXECUTE_HANDLER;  // Re-lanza después de imprimir
}

void install_handler() {
    SetUnhandledExceptionFilter(error_filter);
}

void uninstall_handler() {
    SetUnhandledExceptionFilter(NULL);
}

#else  // Linux/Unix
  
void error_handler(int sig) {
    print_error((void*)(uintptr_t)sig);  // Casteo para unificar
    signal(sig, SIG_DFL);  // Restaura por defecto
    raise(sig);  // Re-lanza
}

void install_handler() {
    signal(SIGABRT, error_handler);  // Abort (ej. assert fallido)
    signal(SIGBUS, error_handler);   // Error de bus (acceso memoria inválido)
    signal(SIGFPE, error_handler);   // Error punto flotante (div/0, overflow)
    signal(SIGILL, error_handler);   // Instrucción ilegal
    signal(SIGSEGV, error_handler);  // Violación segmento (null ptr, etc.)
    signal(SIGPIPE, error_handler);  // Broken pipe (escritura a socket cerrado)
//        signal(SIGTERM, error_handler);  // Terminación (kill)
// Opcional: signal(SIGINT, error_handler);  // Ctrl+C (descomenta si quieres)
}

void uninstall_handler() {
    signal(SIGABRT, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
//        signal(SIGTERM, SIG_DFL);
// Opcional: signal(SIGINT, SIG_DFL);
}

#endif

/////////////////////////////////////////////////////////////////////
// run code, from adress "boot"
void runr3(int boot) 
{
//    datastack[DATA_STACK_ENTRIES - 1] = 0;
retstack[512 - 1] = 0;    
		
register __int64 op=0;
ip=boot;
TOS=0;
NOS = &datastack[0];
RTOS = &retstack[512 - 1];
REGA=0;
REGB=0;

next:
	op=memcode[ip++]; 
	
#ifdef DEBUG	
//printstackd(NOS);printf("%d |%x: %x |",TOS,ip,op);printcode(op);
#endif
	
	switch(op&0xff){
	case FIN:ip=*RTOS;RTOS++;if (ip==0) return;
		goto next; 													// ;
	case LIT:NOS++;*NOS=TOS;TOS=op>>8;goto next;					// LIT1
	case ADR:NOS++;*NOS=TOS;TOS=(__int64)&memdata[op>>8];goto next;	// LIT adr
	case CALL:RTOS--;*RTOS=ip;ip=(unsigned int)op>>8;goto next;		// CALL
	case VAR:NOS++;*NOS=TOS;TOS=*(__int64*)&memdata[op>>8];goto next;// VAR
	case EX:RTOS--;*RTOS=ip;ip=TOS;TOS=*NOS;NOS--;goto next;		//EX
	case ZIF:if (TOS!=0) {ip+=(op>>8);}; goto next;//ZIF
	case UIF:if (TOS==0) {ip+=(op>>8);}; goto next;//UIF
	case PIF:if (TOS<0) {ip+=(op>>8);}; goto next;//PIF
	case NIF:if (TOS>=0) {ip+=(op>>8);}; goto next;//NIF
	case IFL:if (TOS<=*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFL
	case IFG:if (TOS>=*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFG
	case IFE:if (TOS!=*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFN	
	case IFGE:if (TOS>*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFGE
	case IFLE:if (TOS<*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFLE
	case IFNE:if (TOS==*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFNO
	case IFAND:if (!(TOS&*NOS)) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFNA
	case IFNAND:if (TOS&*NOS) {ip+=(op>>8);} TOS=*NOS;NOS--;goto next;//IFAN
	case IFBT:if ((__uint64)(*(NOS-1)-*NOS)>(__uint64)(TOS-(*NOS))){ip+=(op>>8);} TOS=*(NOS-1);NOS-=2;goto next;
	case DUP:NOS++;*NOS=TOS;goto next;				//DUP
	case DROP:TOS=*NOS;NOS--;goto next;				//DROP
	case OVER:NOS++;*NOS=TOS;TOS=*(NOS-1);goto next;	//OVER
	case PICK2:NOS++;*NOS=TOS;TOS=*(NOS-2);goto next;//PICK2
	case PICK3:NOS++;*NOS=TOS;TOS=*(NOS-3);goto next;//PICK3
	case PICK4:NOS++;*NOS=TOS;TOS=*(NOS-4);goto next;//PICK4
	case SWAP:op=*NOS;*NOS=TOS;TOS=op;goto next;		//SWAP
	case NIP:NOS--;goto next; 						//NIP
	case ROT:op=TOS;TOS=*(NOS-1);*(NOS-1)=*NOS;*NOS=op;goto next;	//ROT
	case MROT:op=TOS;TOS=*(NOS);*NOS=*(NOS-1);*(NOS-1)=op;goto next;	//-ROT
	case DUP2:op=*NOS;NOS++;*NOS=TOS;NOS++;*NOS=op;goto next;//DUP2
	case DROP2:NOS--;TOS=*NOS;NOS--;goto next;				//DROP2
	case DROP3:NOS-=2;TOS=*NOS;NOS--;goto next;				//DROP3
	case DROP4:NOS-=3;TOS=*NOS;NOS--;goto next;				//DROP4
	case OVER2:NOS++;*NOS=TOS;TOS=*(NOS-3);
		NOS++;*NOS=TOS;TOS=*(NOS-3);goto next;	//OVER2
	case SWAP2:op=*NOS;*NOS=*(NOS-2);*(NOS-2)=op;
		op=TOS;TOS=*(NOS-1);*(NOS-1)=op;goto next;	//SWAP2
	case TOR:RTOS--;*RTOS=TOS;TOS=*NOS;NOS--;goto next;	//>r
	case RFROM:NOS++;*NOS=TOS;TOS=*RTOS;RTOS++;goto next;	//r>
	case ERRE:NOS++;*NOS=TOS;TOS=*RTOS;goto next;			//r@
	case AND:TOS&=*NOS;NOS--;goto next;					//AND
	case OR:TOS|=*NOS;NOS--;goto next;					//OR
	case XOR:TOS^=*NOS;NOS--;goto next;					//XOR
	case NAND:TOS=(~TOS)&(*NOS);NOS--;goto next;		//NAND
	case ADD:TOS=*NOS+TOS;NOS--;goto next;				//SUMA
	case SUB:TOS=*NOS-TOS;NOS--;goto next;				//RESTA
	case MUL:TOS=*NOS*TOS;NOS--;goto next;				//MUL
	case DIV:TOS=(*NOS/TOS);NOS--;goto next;			//DIV
	case SHL:TOS=*NOS<<TOS;NOS--;goto next;				//SAl
	case SHR:TOS=*NOS>>TOS;NOS--;goto next;				//SAR
	case SHR0:TOS=((__uint64)*NOS)>>TOS;NOS--;goto next;	//SHR
	case MOD:TOS=*NOS%TOS;NOS--;goto next;					//MOD
	case DIVMOD:op=*NOS;*NOS=op/TOS;TOS=op%TOS;goto next;	//DIVMOD
	case MULDIV:TOS=((__int128)(*(NOS-1))*(*NOS)/TOS);NOS-=2;goto next;	//MULDIV
	case MULSHR:TOS=((__int128)(*(NOS-1)*(*NOS))>>TOS);NOS-=2;goto next;	//MULSHR
	case CDIVSH:TOS=(__int128)((*(NOS-1)<<TOS)/(*NOS));NOS-=2;goto next;//CDIVSH
	case NOT:TOS=~TOS;goto next;							//NOT
	case NEG:TOS=-TOS;goto next;					//NEG
	case ABS:if(TOS<0)TOS=-TOS;goto next;			//ABS
	case CSQRT:TOS=isqrt(TOS);goto next;			//CSQRT
	case CLZ:TOS=iclz(TOS);goto next;				//CLZ
	
	case FECH:TOS=*(__int64*)TOS;goto next;		//@
	case CFECH:TOS=*(char*)TOS;goto next;		//C@
	case WFECH:TOS=*(__int16*)TOS;goto next;	//W@
	case DFECH:TOS=*(__int32*)TOS;goto next;	//D@
	case FECHPLUS:NOS++;*NOS=TOS+8;TOS=*(__int64*)TOS;goto next;//@+
	case CFECHPLUS:NOS++;*NOS=TOS+1;TOS=*(char*)TOS;goto next;// C@+
	case WFECHPLUS:NOS++;*NOS=TOS+2;TOS=*(__int16*)TOS;goto next;//W@+			
	case DFECHPLUS:NOS++;*NOS=TOS+4;TOS=*(__int32*)TOS;goto next;//D@+		
	case STOR:*(__int64*)TOS=(__int64)*NOS;NOS--;TOS=*NOS;NOS--;goto next;// !
	case CSTOR:*(char*)TOS=(char)*NOS;NOS--;TOS=*NOS;NOS--;goto next;//C!
	case WSTOR:*(__int16*)TOS=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//W!		
	case DSTOR:*(__int32*)TOS=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//D!
	case STOREPLUS:*(__int64*)TOS=*NOS;NOS--;TOS+=8;goto next;// !+
	case CSTOREPLUS:*(char*)TOS=*NOS;NOS--;TOS++;goto next;//C!+
	case WSTOREPLUS:*(__int16*)TOS=*NOS;NOS--;TOS+=2;goto next;//W!+	
	case DSTOREPLUS:*(__int32*)TOS=*NOS;NOS--;TOS+=4;goto next;//D!+
	case INCSTOR:*(__int64*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//+!
	case CINCSTOR:*(char*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//C+!
	case WINCSTOR:*(__int16*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//W+!	
	case DINCSTOR:*(__int32*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//D+!
	
	case TOA:REGA=TOS;TOS=*NOS;NOS--;goto next; //>A
	case ATO:NOS++;*NOS=TOS;TOS=REGA;goto next; //A> 
	case AA:REGA+=TOS;TOS=*NOS;NOS--;goto next;//A+ 	
	
	case AF:NOS++;*NOS=TOS;TOS=*(__int64*)REGA;goto next;//A@
	case AS:*(__int64*)REGA=TOS;TOS=*NOS;NOS--;goto next;//A! 
	case AFA:NOS++;*NOS=TOS;TOS=*(__int64*)REGA;REGA+=8;goto next;//A@+ 
	case ASA:*(__int64*)REGA=TOS;TOS=*NOS;NOS--;REGA+=8;goto next;//A!+
	case CAF:NOS++;*NOS=TOS;TOS=*(char*)REGA;goto next;//cA@
	case CAS:*(char*)REGA=TOS;TOS=*NOS;NOS--;goto next;//cA! 
	case CAFA:NOS++;*NOS=TOS;TOS=*(char*)REGA;REGA++;goto next;//cA@+ 
	case CASA:*(char*)REGA=TOS;TOS=*NOS;NOS--;REGA++;goto next;//cA!+
	case DAF:NOS++;*NOS=TOS;TOS=*(__int32*)REGA;goto next;//dA@
	case DAS:*(__int32*)REGA=TOS;TOS=*NOS;NOS--;goto next;//dA! 
	case DAFA:NOS++;*NOS=TOS;TOS=*(__int32*)REGA;REGA+=4;goto next;//dA@+ 
	case DASA:*(__int32*)REGA=TOS;TOS=*NOS;NOS--;REGA+=4;goto next;//dA!+
	
	case TOB:REGB=TOS;TOS=*NOS;NOS--;goto next; //>B
	case BTO:NOS++;*NOS=TOS;TOS=REGB;goto next; //B> 
	case BA:REGB+=TOS;TOS=*NOS;NOS--;goto next;//B+ 

	case BF:NOS++;*NOS=TOS;TOS=*(__int64*)REGB;goto next;//B@
	case BS:*(__int64*)REGB=TOS;TOS=*NOS;NOS--;goto next;//B! 
	case BFA:NOS++;*NOS=TOS;TOS=*(__int64*)REGB;REGB+=8;goto next;//B@+ 
	case BSA:*(__int64*)REGB=TOS;TOS=*NOS;NOS--;REGB+=8;goto next;//B!+

	case CBF:NOS++;*NOS=TOS;TOS=*(char*)REGB;goto next;//cB@
	case CBS:*(char*)REGB=TOS;TOS=*NOS;NOS--;goto next;//cB! 
	case CBFA:NOS++;*NOS=TOS;TOS=*(char*)REGB;REGB++;goto next;//cB@+ 
	case CBSA:*(char*)REGB=TOS;TOS=*NOS;NOS--;REGB++;goto next;//cB!+

	case DBF:NOS++;*NOS=TOS;TOS=*(__int32*)REGB;goto next;//dB@
	case DBS:*(__int32*)REGB=TOS;TOS=*NOS;NOS--;goto next;//dB! 
	case DBFA:NOS++;*NOS=TOS;TOS=*(__int32*)REGB;REGB+=4;goto next;//dB@+ 
	case DBSA:*(__int32*)REGB=TOS;TOS=*NOS;NOS--;REGB+=4;goto next;//dB!+

	case SAVEAB:RTOS--;*RTOS=REGA;RTOS--;*RTOS=REGB;goto next;// ab[
	case LOADBA:REGB=*RTOS;RTOS++;REGA=*RTOS;RTOS++;goto next;// ]ba
	
	case MOVED://QMOVE 
//		W=(unsigned __int64)*(NOS-1);op=(unsigned __int64)*NOS;
//		while (TOS--) { *(unsigned __int64*)W=*(unsigned __int64*)op;W+=8;op+=8; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS<<3);	
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case MOVEA://MOVE> 
//		W=(unsigned __int64)*(NOS-1)+(TOS<<3);op=(unsigned __int64)*NOS+(TOS<<3);
//		while (TOS--) { W-=8;op-=8;*(unsigned __int64*)W=*(unsigned __int64*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS<<3);		
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case FILL://QFILL
//		W=(unsigned __int64)*(NOS-1);op=*NOS;while (TOS--) { *(unsigned __int64*)W=op;W+=8; }
		memset64((__uint64*)*(NOS-1),*NOS,TOS);		
		NOS-=2;TOS=*NOS;NOS--;goto next;

	case CMOVED://CMOVE 
//		W=(__int64)*(NOS-1);op=(__int64)*NOS;
//		while (TOS--) { *(char*)W=*(char*)op;W++;op++; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case CMOVEA://CMOVE> 
//		W=(__int64)*(NOS-1)+TOS;op=(__int64)*NOS+TOS;
//		while (TOS--) { W--;op--;*(char*)W=*(char*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case CFILL://CFILL
//		W=(__int64)*(NOS-1);op=*NOS;while (TOS--) { *(char*)W=op;W++; }
		memset((void*)*(NOS-1),*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;

	
	case DMOVED://MOVE 
//		W=(__int64)*(NOS-1);op=(__int64)*NOS;
//		while (TOS--) { *(int*)W=*(int*)op;W+=4;op+=4; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS<<2);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case DMOVEA://MOVE> 
//		W=(__int64)*(NOS-1)+(TOS<<2);op=(__int64)(*NOS)+(TOS<<2);
//		while (TOS--) { W-=4;op-=4;*(int*)W=*(int*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS<<2);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case DFILL://FILL
//		W=*(NOS-1);op=*NOS;while (TOS--) { *(int*)W=op;W+=4; }
		memset32((__uint32*)*(NOS-1),*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case MEM://"MEM"
		NOS++;*NOS=TOS;TOS=(__int64)&memdata[memd];goto next;

#if defined(LINUX) || defined(RPI)
	case LOADLIB: // "" -- hmo
		TOS=(__int64)dlopen((char*)TOS,RTLD_NOW);goto next; //RTLD_LAZY 1 RTLD_NOW 2
	case GETPROCA: // hmo "" -- ad		
		TOS=(__int64)dlsym((void*)*NOS,(char*)TOS);NOS--;goto next;
#else	// WINDOWS
	case LOADLIB: // "" -- hmo
		TOS=(__int64)LoadLibraryA((char*)TOS);goto next;
	case GETPROCA: // hmo "" -- ad
		TOS=(__int64)GetProcAddress((HMODULE)*NOS,(char*)TOS);NOS--;goto next;
#endif
		 
	case SYSCALL0: // adr -- rs
		op=*(__int64*)&memdata[op>>8];
		NOS++;*NOS=TOS;TOS=(__int64)(* (__int64(*)())op)();goto next;
	case SYSCALL1: // a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64))op)(TOS);goto next;
	case SYSCALL2: // a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64))op)(*NOS,TOS);NOS--;goto next;
	case SYSCALL3: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64))op)(*(NOS-1),*NOS,TOS);NOS-=2;goto next;
	case SYSCALL4: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64))op)(*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=3;goto next;
	case SYSCALL5: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64))op)(*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=4;goto next;
	case SYSCALL6: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64,__int64))op)(*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=5;goto next;
	case SYSCALL7: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64,__int64,__int64))op)(*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=6;goto next;
	case SYSCALL8: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64))op)(*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=7;goto next;
	case SYSCALL9: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64))op)(*(NOS-7),*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=8;goto next;
	case SYSCALL10: // a1 a0 adr -- rs 
		op=*(__int64*)&memdata[op>>8];
		TOS=(__int64)(* (__int64(*)(__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64,__int64))op)(*(NOS-8),*(NOS-7),*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS,TOS);NOS-=9;goto next;
/* -- DEBUG
	case DOT:printf("%llx ",TOS);TOS=*NOS;NOS--;goto next;
	case DOTS:printf((char*)TOS);TOS=*NOS;NOS--;goto next;
*/	
//	case ENDWORD: goto next;
//----------------- ONLY INTERNAL
	case JMP:ip=(op>>8);goto next;//JMP							// JMP
	case JMPR:ip+=(op>>8);goto next;//JMP						// JMPR	
	case LIT2:TOS=(TOS&0xffffff)|((op>>8)<<24);goto next;		// LIT ....xxxxxxaaaaaa
	case LIT3:TOS=(TOS&0xffffffffffff)|((op>>8)<<48);goto next;	// LIT xxxx......aaaaaa	
	case LITF:NOS++;*NOS=TOS;TOS=*(__int64*)(&memcode[ip]);ip+=2;goto next; // insegure for optimization
//----------------- OPTIMIZED WORD
#ifndef OPTOFF // DISABLE
	case AND1:TOS&=op>>8;goto next;
	case OR1:TOS|=op>>8;goto next;
	case XOR1:TOS^=op>>8;goto next;
	case NAND1:TOS&=~(op>>8);goto next;
	case ADD1:TOS+=op>>8;goto next;
	case SUB1:TOS-=op>>8;goto next;
	case MUL1:TOS*=op>>8;goto next;
	case DIV1:TOS/=op>>8;goto next;
	case SHL1:TOS<<=op>>8;goto next;
	case SHR1:TOS>>=op>>8;goto next;
	case SHR01:TOS=(__uint64)TOS>>(op>>8);goto next;
	case MOD1:TOS=TOS%(op>>8);goto next;
	case DIVMOD1:op>>=8;NOS++;*NOS=TOS/op;TOS=TOS%op;goto next;	//DIVMOD
	case MULDIV1:op>>=8;TOS=(__int128)(*NOS)*TOS/op;NOS--;goto next;	//MULDIV
	case MULSHR1:op>>=8;TOS=((__int128)(*NOS)*TOS)>>op;NOS--;goto next;	//MULSHR
	case CDIVSH1:op>>=8;TOS=(__int128)((*NOS)<<op)/TOS;NOS--;goto next;	//CDIVSH

	case MULSHR2:op>>=8;TOS=((__int128)TOS*op)>>16;goto next;	//MULSHR .. 234 16 *>>
	case CDIVSH2:op>>=8;TOS=(__int128)(TOS<<16)/op;goto next;	//CDIVSH ... 23 16 <</
	
	case MULSHR3:TOS=((__int128)(*NOS)*TOS)>>16;NOS--;goto next;	//MULSHR .. XX 16 *>>
	case CDIVSH3:TOS=(__int128)((*NOS)<<16)/TOS;NOS--;goto next;	//CDIVSH .. XX 16 <</	

	case IFL1:if ((op>>16)<=TOS) ip+=(op<<48>>56);goto next;	//IFL <<32>>49
	case IFG1:if ((op>>16)>=TOS) ip+=(op<<48>>56);goto next;	//IFG
	case IFE1:if ((op>>16)!=TOS) ip+=(op<<48>>56);goto next;	//IFN
	case IFGE1:if ((op>>16)>TOS) ip+=(op<<48>>56);goto next;	//IFGE
	case IFLE1:if ((op>>16)<TOS) ip+=(op<<48>>56);goto next;	//IFLE
	case IFNE1:if ((op>>16)==TOS) ip+=(op<<48>>56);goto next;//IFNO
	case IFAND1:if (!((op>>16)&TOS)) ip+=(op<<48>>56);goto next;//IFNA
	case IFNAND1:if ((op>>16)&TOS) ip+=(op<<48>>56);goto next;//IFAN
	// signed and unsigned transformation
	case SHLR:TOS=(TOS<<((op>>8)&0xff))>>(op>>16);goto next; // SHLR  ( << >>) extend sign
	case SHLAR:TOS=(TOS>>((op>>8)&0x3f))&((unsigned)op>>14);goto next; // SHRAND  (>> and) unsigned
	// cte + @ c@ w@ d@ 
	case FECHa:TOS=*(__int64*)(TOS+(op>>8));goto next;//+ @
	case CFECHa:TOS=*(char*)(TOS+(op>>8));goto next;//+C@
	case WFECHa:TOS=*(__int16*)(TOS+(op>>8));goto next;//+W@
	case DFECHa:TOS=*(__int32*)(TOS+(op>>8));goto next;//+D@
	// cte + ! c! w! d!
	case STORa:*(__int64*)(TOS+(op>>8))=*NOS;TOS=*(NOS-1);NOS-=2;goto next;// + !
	case CSTORa:*(char*)(TOS+(op>>8))=*NOS;TOS=*(NOS-1);NOS-=2;goto next;//+ C!
	case WSTORa:*(__int16*)(TOS+(op>>8))=*NOS;TOS=*(NOS-1);NOS-=2;goto next;//+ W!
	case DSTORa:*(__int32*)(TOS+(op>>8))=*NOS;TOS=*(NOS-1);NOS-=2;goto next;//+ D!
	// 1|2|3 << + @ c@ w@ d@ 
	case FECH1:TOS=*(__int64*)((TOS<<1)+(*NOS));NOS--;goto next;//1<<+@
	case FECH2:TOS=*(__int64*)((TOS<<2)+(*NOS));NOS--;goto next;//2<<+@
	case FECH3:TOS=*(__int64*)((TOS<<3)+(*NOS));NOS--;goto next;//3<<+@
	case CFECH1:TOS=*(char*)((TOS<<1)+(*NOS));NOS--;goto next;//1<<+C@
	case CFECH2:TOS=*(char*)((TOS<<2)+(*NOS));NOS--;goto next;//2<<+C@
	case CFECH3:TOS=*(char*)((TOS<<3)+(*NOS));NOS--;goto next;//3<<+C@
	case WFECH1:TOS=*(__int16*)((TOS<<1)+(*NOS));NOS--;goto next;//1<<+W@
	case WFECH2:TOS=*(__int16*)((TOS<<2)+(*NOS));NOS--;goto next;//2<<+W@
	case WFECH3:TOS=*(__int16*)((TOS<<3)+(*NOS));NOS--;goto next;//3<<+W@
	case DFECH1:TOS=*(__int32*)((TOS<<1)+(*NOS));NOS--;goto next;//1<<+D@
	case DFECH2:TOS=*(__int32*)((TOS<<2)+(*NOS));NOS--;goto next;//2<<+D@
	case DFECH3:TOS=*(__int32*)((TOS<<3)+(*NOS));NOS--;goto next;//3<<+D@
	// 1|2|3 << + ! c! w! d!
	case STOR1:*(__int64*)((TOS<<1)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;// 1<<+!
	case STOR2:*(__int64*)((TOS<<2)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;// 2<<+!
	case STOR3:*(__int64*)((TOS<<3)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;// 3<<+!
	case CSTOR1:*(char*)((TOS<<1)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//1<<+C!
	case CSTOR2:*(char*)((TOS<<2)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//2<<+C!
	case CSTOR3:*(char*)((TOS<<3)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//3<<+C!
	case WSTOR1:*(__int16*)((TOS<<1)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//1<<+W!
	case WSTOR2:*(__int16*)((TOS<<2)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//2<<+W!
	case WSTOR3:*(__int16*)((TOS<<3)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//3<<+W!
	case DSTOR1:*(__int32*)((TOS<<1)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//1<<+D!
	case DSTOR2:*(__int32*)((TOS<<2)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//2<<+D!
	case DSTOR3:*(__int32*)((TOS<<3)+(*NOS))=*(NOS-1);TOS=*(NOS-2);NOS-=3;goto next;//3<<+D!
	case AA1:REGA+=(op>>8);goto next;//LIT A+ 	
	case BA1:REGB+=(op>>8);goto next;//LIT B+ 	
	
	//(__int64)&memdata[op>>8]
	// 'var MEM	
	case AFECH: NOS++;*NOS=TOS;TOS=*(__int64*)&memdata[op>>8];goto next;	//@
	case ACFECH:NOS++;*NOS=TOS;TOS=*(char*)&memdata[op>>8];goto next;		//C@
	case AWFECH:NOS++;*NOS=TOS;TOS=*(__int16*)&memdata[op>>8];goto next;	//W@
	case ADFECH:NOS++;*NOS=TOS;TOS=*(__int32*)&memdata[op>>8];goto next;	//D@
	
	case AFECHPLUS: op=(__int64)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+8;TOS=*(__int64*)op;goto next;//@+
	case ACFECHPLUS:op=(__int64)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+1;TOS=*(char*)op;goto next;// C@+
	case AWFECHPLUS:op=(__int64)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+2;TOS=*(__int16*)op;goto next;//W@+			
	case ADFECHPLUS:op=(__int64)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+4;TOS=*(__int32*)op;goto next;//D@+		
	
	case ASTOR: *(__int64*)&memdata[op>>8]=TOS;TOS=*NOS;NOS--;goto next;// !
	case ACSTOR:*(char*)&memdata[op>>8]=TOS;TOS=*NOS;NOS--;goto next;//C!
	case AWSTOR:*(__int16*)&memdata[op>>8]=TOS;TOS=*NOS;NOS--;goto next;//W!		
	case ADSTOR:*(__int32*)&memdata[op>>8]=TOS;TOS=*NOS;NOS--;goto next;//D!
	
	case ASTOREPLUS: op=(__int64)&memdata[op>>8];*(__int64*)op=TOS;TOS=op+8;goto next;// !+
	case ACSTOREPLUS:op=(__int64)&memdata[op>>8];*(char*)op=TOS;TOS=op+1;goto next;//C!+
	case AWSTOREPLUS:op=(__int64)&memdata[op>>8];*(__int16*)op=TOS;TOS=op+2;goto next;//W!+	
	case ADSTOREPLUS:op=(__int64)&memdata[op>>8];*(__int32*)op=TOS;TOS=op+4;goto next;//D!+
	
	case AINCSTOR: *(__int64*)&memdata[op>>8]+=TOS;TOS=*NOS;NOS--;goto next;//+!
	case ACINCSTOR:*(char*)&memdata[op>>8]+=TOS;TOS=*NOS;NOS--;goto next;//C+!
	case AWINCSTOR:*(__int16*)&memdata[op>>8]+=TOS;TOS=*NOS;NOS--;goto next;//W+!	
	case ADINCSTOR:*(__int32*)&memdata[op>>8]+=TOS;TOS=*NOS;NOS--;goto next;//D+!
	// var MEM
	//*(__int64*)&memdata[op>>8]
	case VFECH: op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;TOS=*(__int64*)op;goto next;	//@
	case VCFECH:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;TOS=*(char*)op;goto next;		//C@
	case VWFECH:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;TOS=*(__int16*)op;goto next;	//W@
	case VDFECH:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;TOS=*(__int32*)op;goto next;	//D@
	
	case VFECHPLUS: op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+8;TOS=*(__int64*)op;goto next;//@+
	case VCFECHPLUS:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+1;TOS=*(char*)op;goto next;// C@+
	case VWFECHPLUS:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+2;TOS=*(__int16*)op;goto next;//W@+			
	case VDFECHPLUS:op=*(__int64*)&memdata[op>>8];NOS++;*NOS=TOS;NOS++;*NOS=op+4;TOS=*(__int32*)op;goto next;//D@+		
	
	case VSTOR: op=*(__int64*)&memdata[op>>8];*(__int64*)op=TOS;TOS=*NOS;NOS--;goto next;// !
	case VCSTOR:op=*(__int64*)&memdata[op>>8];*(char*)op=TOS;TOS=*NOS;NOS--;goto next;//C!
	case VWSTOR:op=*(__int64*)&memdata[op>>8];*(__int16*)op=TOS;TOS=*NOS;NOS--;goto next;//W!		
	case VDSTOR:op=*(__int64*)&memdata[op>>8];*(__int32*)op=TOS;TOS=*NOS;NOS--;goto next;//D!
	
	case VSTOREPLUS: op=*(__int64*)&memdata[op>>8];*(__int64*)op=TOS;TOS=op+8;goto next;// !+
	case VCSTOREPLUS:op=*(__int64*)&memdata[op>>8];*(char*)op=TOS;TOS=op+1;goto next;//C!+
	case VWSTOREPLUS:op=*(__int64*)&memdata[op>>8];*(__int16*)op=TOS;TOS=op+2;goto next;//W!+	
	case VDSTOREPLUS:op=*(__int64*)&memdata[op>>8];*(__int32*)op=TOS;TOS=op+4;goto next;//D!+
	
	case VINCSTOR: op=*(__int64*)&memdata[op>>8];*(__int64*)op+=TOS;TOS=*NOS;NOS--;goto next;//+!
	case VCINCSTOR:op=*(__int64*)&memdata[op>>8];*(char*)op+=TOS;TOS=*NOS;NOS--;goto next;//C+!
	case VWINCSTOR:op=*(__int64*)&memdata[op>>8];*(__int16*)op+=TOS;TOS=*NOS;NOS--;goto next;//W+!	
	case VDINCSTOR:op=*(__int64*)&memdata[op>>8];*(__int32*)op+=TOS;TOS=*NOS;NOS--;goto next;//D+!
#endif
	}
}

	
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
int main(int argc, char* argv[])
{
char *filename;
if (argc>1) 
	filename=argv[1]; 
else 
	filename=(char*)"main.r3";
if (!r3compile(filename)) return -1;
    
#ifdef DEBUGVER    

#ifdef NETSERVER
init_winsock();
if (argc > 2) { // argv[2] = puerto del debugger
	//server_create(atoi(argv[2]));
	client_connect(atoi(argv[2]));
} else {
	//server_create(9999);
	client_connect(9999);
	}
#endif

install_handler();
#endif

runr3(boot);

#ifdef DEBUGVER
uninstall_handler();

#ifdef NETSERVER
sock_close();
cleanup_winsock();    
#endif

#endif
return 0;
}
