////////////////////////////////////////////////////////////
// r3 concatenative programing language - Pablo Hugo Reda
//
// Compiler to dword-code and virtual machine for r3 lang, 
//  with cell size of 64 bits, 
//

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

#else	// WINDOWS
#include <windows.h>

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

//----- internal tokens, replace 8 first names
const char *r3asm[]={
";","LIT1","ADR","CALL","VAR"
};

//------ base dictionary, machine-forth or machine-r3
const char *r3bas[]={
";","(",")","[","]",
"EX",
"0?","1?","+?","-?", 								
"<?",">?","=?",">=?","<=?","<>?","AND?","NAND?","BT?",
"DUP","DROP","OVER","PICK2","PICK3","PICK4","SWAP","NIP",
"ROT","2DUP","2DROP","3DROP","4DROP","2OVER","2SWAP",
">R","R>","R@",
"AND","OR","XOR",
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
"MOVE","MOVE>","FILL",
"CMOVE","CMOVE>","CFILL",
"DMOVE","DMOVE>","DFILL",
"MEM",

"LOADLIB","GETPROC",
"SYS0","SYS1","SYS2","SYS3","SYS4","SYS5",
"SYS6","SYS7","SYS8","SYS9","SYS10",
//"SYS6F1",

//".",".S",

"",// !!cut the dicc!!!
"JMP","JMPR","LIT2","LIT3",	// internal only
"AND_L","OR_L","XOR_L",		// OPTIMIZATION WORDS
"+_L","-_L","*_L","/_L",
"<<_L",">>_L",">>>_L",
"MOD_L","/MOD_L","*/_L","*>>_L","<</_L",
"<?_L",">?_L","=?_L",">=?_L","<=?_L","<>?_L","AN?_L","NA?_L",

};

//------ enumaration for table jump
enum {
FIN,LIT,ADR,CALL,VAR, 
EX,
ZIF,UIF,PIF,NIF,
IFL,IFG,IFE,IFGE,IFLE,IFNE,IFAND,IFNAND,IFBT,
DUP,DROP,OVER,PICK2,PICK3,PICK4,SWAP,NIP,
ROT,DUP2,DROP2,DROP3,DROP4,OVER2,SWAP2,
TOR,RFROM,ERRE,
AND,OR,XOR,
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
MOVED,MOVEA,FILL,
CMOVED,CMOVEA,CFILL,
DMOVED,DMOVEA,DFILL,
MEM,
LOADLIB,GETPROCA,
SYSCALL0,SYSCALL1,SYSCALL2,SYSCALL3,SYSCALL4,SYSCALL5,
SYSCALL6,SYSCALL7,SYSCALL8,SYSCALL9,SYSCALL10,
//SYSCALL6F1,
//DOT,DOTS,

ENDWORD, // !! cut the dicc !!!
JMP,JMPR,LIT2,LIT3,	// internal
AND1,OR1,XOR1,		// OPTIMIZATION WORDS
ADD1,SUB1,MUL1,DIV1,
SHL1,SHR1,SHR01,
MOD1,DIVMOD1,MULDIV1,MULSHR1,CDIVSH1,
IFL1,IFG1,IFE1,IFGE1,IFLE1,IFNE1,IFAND1,IFNAND1
};

//////////////////////////////////////
// DEBUG -- remove when all work ok
//////////////////////////////////////
void printword(char *s)
{
while (*s>32) putchar(*s++);
putchar(' ');
}

void printcode(int n)
{
if ((n&0xff)<5 && n!=0) {
	printf(r3asm[n&0xff]);printf(" %d",n>>8);
} else if (((n&0xff)>=IFL && (n&0xff)<=IFNAND) || (n&0xff)==JMPR) {	
	printf(r3bas[n&0xff]);printf(" >> %d",n>>8);
} else if ((n&0xff)>=IFL1 && (n&0xff)<=IFNAND1) {	
	printf(r3bas[n&0xff]);printf(" %d",n>>16);printf(" >> %d",n<<16>>24);
} else if ((n&0xff)>ENDWORD ) {
	printf(r3bas[n&0xff]);printf(" %d",n>>8);	
} else 
	printf(r3bas[n&0xff]);
printf("\n");
}

void dumpcode()
{
printf("code\n");
printf("boot:%d\n",boot);
for(int i=1;i<memc;i++) {
	printf("%x:",i);
	printcode(memcode[i]);
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
	printf("%d ",dicc[i].mem);	
	printf("%d \n",dicc[i].info);	
	}
}


//////////////////////////////////////
// Compiler: from text to dwordcodes
//////////////////////////////////////

// scan for a valid number begin in *p char
// return number in global var "nro"

typedef __INT64_TYPE__ int64_t;
typedef __UINT64_TYPE__ uint64_t;
typedef __INT32_TYPE__ int32_t;
typedef __UINT32_TYPE__ uint32_t;
typedef __INT16_TYPE__ int16_t;
typedef __UINT16_TYPE__ uint16_t;

int64_t nro=0;

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
int64_t parte0;
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
int64_t num=nro;
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
while (*s!=0)	{
	if (*s==34) { 
		s++;if (*s!=34) { 
			s++;break; } }
	s++;
	}
return s;
}

// ask for a word in the basic dicc
int isBas(char *p)
{    
nro=0;
char **m=(char**)r3bas;
while (**m!=0) {
  if (strequal(*m,p)) return -1;
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
memd+=memd&3; // align data!!! (FILL break error)
dicc[cntdicc].mem=memd;
dicc[cntdicc].info=ex+0x10;	// 0x10 es dato
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
	if (ex!=-1) { codetok((ex<<8)+CALL); } // call to prev boot code
	}
modo=1;
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
if (modo<2) codetok((ini<<8)+ADR); // lit data
}

// Store in datamemory a number or reserve mem
void datanro(int64_t n) { 
char *p=&memdata[memd];	
switch(modo){
	case 2:*(int64_t*)p=(int64_t)n;memd+=8;break;
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
		datanro((int64_t)&memdata[dicc[n].mem]);	
	return; 
	}
codetok((dicc[n].mem<<8)+LIT+((dicc[n].info>>4)&1));  //1 code 2 data
}

// Compile literal
void compilaLIT(int64_t n) 
{
if (modo>1) { datanro(n);return; }
int token=n;
codetok((token<<8)+LIT); 
if ((token<<8>>8)==n) return;
token=n>>24;
codetok((token<<8)+LIT2); 
if ((token<<8>>8)==(n>>24)) return;
token=n>>48;
codetok((token<<8)+LIT3); 
}

// Start block code (
void blockIn(void)
{
pushA(memc);
level++;
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
	codetok((-(dist+1)<<8)+JMPR); 	// jmpr
} else { // patch if	
	if ((memcode[from-1]&0xff)>=IFL1 && (memcode[from-1]&0xff)<=IFNAND1) { 
		memcode[from-1]|=(dist<<8)&0xff00;	// byte dir
	} else {
		memcode[from-1]|=(dist<<8);		// full dir
		}
	}
level--;	
if (level<0) {
	printf("ERROR bad )\n");
	}
lastblock=memc;
}

// start anonymous definition (adress only word)
void anonIn(void)
{
pushA(memc);
codetok(JMP);	
level++;	
}

// end anonymous definition, save adress in stack
void anonOut(void)
{
int from=popA();
memcode[from]|=(memc<<8);	// patch jmp
codetok((from+1)<<8|LIT);
level--;	
if (level<0) {
	printf("ERROR bad )\n");
	}
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

// compile word from base diccionary
void compilaMAC(int n) 
{
if (modo>1) { dataMAC(n);return; }
if (n==0) { 					// ;
	if (level==0) modo=0; 
	if ((memcode[memc-1]&0xff)==CALL && lastblock!=memc) { // avoid jmp to block
		memcode[memc-1]=(memcode[memc-1]^CALL)|JMP; // call->jmp avoid ret
		return;
		}
	}
if (n==1) { blockIn();return; }		//(	etiqueta
if (n==2) { blockOut();return; }	//)	salto
if (n==3) { anonIn();return; }		//[	salto:etiqueta
if (n==4) { anonOut();return; }		//]	etiqueta;push

int token=memcode[memc-1];

// optimize conditional jump to short version
if (n>=IFL && n<=IFNAND && (token&0xff)==LIT && (token<<8>>16)==(token>>8)) { 
	memcode[memc-1]=((token<<8)&0xffff0000)|(n-IFL+IFL1);
	return; 
	}

// optimize operation with constant
if (n>=AND && n<=CDIVSH && (token&0xff)==LIT && lastblock!=memc) { 
	memcode[memc-1]=(token^LIT)|(n-ADD+ADD1);
	return; 
	}

codetok(n);	
}

// compile word
void compilaWORD(int n) 
{
if (modo>1) { datanro(n);return; }
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
char *lc=src;
for (char *p=src;p<cerror;p++)
	if (*p==10) { if (*(p+1)==13) p++;
		line++;lc=p+1;
	} else if (*p==13) { if (*(p+1)==10) p++;
		line++;lc=p+1; }
*nextcr(lc)=0; // put 0 in the end of line
printf("in: ");printword(name);printf("\n\n");	
printf("%s\n",lc);
for(char *p=lc;p<cerror;p++) if (*p==9) printf("\t"); else printf(" ");
printf("^-");
printf("ERROR %s, line %d\n\n",werror,line);	
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
			if (nro<0) { 
//				if (isBas(str)) // 'ink allow compile replace
//					{ compilaMAC(nro);str=nextw(str);break; }
				seterror(str,"adr not found");return 0; 
				}
			compilaADDR(nro);str=nextw(str);break;		
		default:
			if (isNro(str)||isNrof(str)) 
				{ compilaLIT(nro);str=nextw(str);break; }
			if (isBas(str)) 
				{ compilaMAC(nro);str=nextw(str);break; }
			nro=isWord(str);
			if (nro<0) { seterror(str,"word not found");return 0; }
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
char *openfile(char *filename)
{
long len;
char *buff;
FILE *f=fopen(filename,"rb");
if (!f) {
	printf("FILE %s not found\n",filename);
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
int isinclude(char *str)
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
includes[cntincludes].str=openfile(filename); 
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
void r3includes(char *str) 
{
if (str==0) return;
//if (*str=='.') { }
	
int ninc;	
while(*str!=0) {
	str=trim(str);
	switch (*str) {
		case '^':	// include
			ninc=isinclude(str+1);
			if (ninc>=0) {
				r3includes(includes[ninc].str);
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
printf("\nr3vm - PHREDA\n");
printf("compile:%s...",name);

char *sourcecode;

strcpy(path,name);// para ^. ahora pone el path del codigo origen
char *aa=path+strlen(path);
while (path<aa) { if (*aa=='/'||*aa=='\\') { *aa=0;break; } aa--; }
 
//printf("*%s*",path);

sourcecode=openfile(name);
if (sourcecode==0) return 0;
memcsize=0;
cntincludes=0;
cntstacki=0;
r3includes(sourcecode); // load includes

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
	printerror(name,sourcecode);
	return 0;
	}

//memd+=memd&3; // align

//dumpdicc();
//dumpcode();

printf(" ok.\n");
printf("inc:%d - words:%d - code:%dKb - data:%dKb - free:%dKb\n\n",cntincludes,cntdicc,memc>>8,memd>>10,(memdsize-memd)>>10);
freeinc();
free(sourcecode);
return -1;
}

	
//----------------------
/*--------RUNER--------*/
//----------------------
#define iclz(x) __builtin_clz(x)

// http://www.devmaster.net/articles/fixed-point-optimizations/
static inline int64_t isqrt(int64_t value)
{
if (value==0) return 0;
int bshft = (63-iclz(value))>>1;  // spot the difference!
int64_t g = 0;
int64_t b = 1<<bshft;
do {
	int64_t temp = (g+g+b)<<bshft;
	if (value >= temp) { g += b;value -= temp;	}
	b>>=1;
} while (bshft--);
return g;
}

//---------------------------//
// TOS..DSTACK--> <--RSTACK  //
//---------------------------//
#define STACKSIZE 256
int64_t stack[STACKSIZE];

void printstack(int64_t *R){
int64_t *RTOS=&stack[STACKSIZE-1];
while (RTOS>=R) {
	printf("%x ",*RTOS);
	RTOS--;
}
}

void printstackd(int64_t *T){
int64_t *TOS=stack;
while (TOS<=T) {
	printf("%d ",*TOS);
	TOS++;
}
}

FILE *file;

void memset32(uint32_t *dest, uint32_t val, uint32_t count)
{ while (count--) *dest++ = val; }

void memset64(uint64_t *dest, uint64_t val, uint32_t count)
{ while (count--) *dest++ = val; }

// run code, from adress "boot"
void runr3(int boot) 
{
stack[STACKSIZE-1]=0;	
register int64_t TOS=0;
register int64_t *NOS=&stack[0];
register int64_t *RTOS=&stack[STACKSIZE-1];
register int64_t REGA=0;
register int64_t REGB=0;
register int64_t op=0;
register int ip=boot;

next:
	op=memcode[ip++]; 
	
//	printstack(RTOS);
//printf("%x:%x:",ip,TOS);printcode(op);
	
	switch(op&0xff){
	case FIN:ip=*RTOS;RTOS++;if (ip==0) return;
//		printf("r:%x ip:%x\n",*RTOS,ip);
		goto next; 							// ;
	case LIT:NOS++;*NOS=TOS;TOS=op>>8;goto next;					// LIT1
	case ADR:NOS++;*NOS=TOS;TOS=(int64_t)&memdata[op>>8];goto next;		// LIT adr
	case CALL:RTOS--;*RTOS=ip;ip=(unsigned int)op>>8;goto next;	// CALL
	case VAR:NOS++;*NOS=TOS;TOS=*(int64_t*)&memdata[op>>8];goto next;// VAR
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
	case IFBT:if (*(NOS-1)>TOS||*(NOS-1)<*NOS) {ip+=(op>>8);} 
		TOS=*(NOS-1);NOS-=2;goto next;//BTW (need bit trick) 	//(TOS-*(NOS-1))|(*(NOS-1)-*NOS)>0
	case DUP:NOS++;*NOS=TOS;goto next;				//DUP
	case DROP:TOS=*NOS;NOS--;goto next;				//DROP
	case OVER:NOS++;*NOS=TOS;TOS=*(NOS-1);goto next;	//OVER
	case PICK2:NOS++;*NOS=TOS;TOS=*(NOS-2);goto next;//PICK2
	case PICK3:NOS++;*NOS=TOS;TOS=*(NOS-3);goto next;//PICK3
	case PICK4:NOS++;*NOS=TOS;TOS=*(NOS-4);goto next;//PICK4
	case SWAP:op=*NOS;*NOS=TOS;TOS=op;goto next;		//SWAP
	case NIP:NOS--;goto next; 						//NIP
	case ROT:op=TOS;TOS=*(NOS-1);*(NOS-1)=*NOS;*NOS=op;goto next;	//ROT
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
	case ADD:TOS=*NOS+TOS;NOS--;goto next;				//SUMA
	case SUB:TOS=*NOS-TOS;NOS--;goto next;				//RESTA
	case MUL:TOS=*NOS*TOS;NOS--;goto next;				//MUL
	case DIV:TOS=(*NOS/TOS);NOS--;goto next;				//DIV
	case SHL:TOS=*NOS<<TOS;NOS--;goto next;				//SAl
	case SHR:TOS=*NOS>>TOS;NOS--;goto next;				//SAR
	case SHR0:TOS=((uint64_t)*NOS)>>TOS;NOS--;goto next;	//SHR
	case MOD:TOS=*NOS%TOS;NOS--;goto next;					//MOD
	case DIVMOD:op=*NOS;*NOS=op/TOS;TOS=op%TOS;goto next;	//DIVMOD
	case MULDIV:TOS=((long long)(*(NOS-1))*(*NOS)/TOS);NOS-=2;goto next;	//MULDIV
	case MULSHR:TOS=((long long)(*(NOS-1)*(*NOS))>>TOS);NOS-=2;goto next;	//MULSHR
	case CDIVSH:TOS=(long long)((*(NOS-1)<<TOS)/(*NOS));NOS-=2;goto next;//CDIVSH
	case NOT:TOS=~TOS;goto next;							//NOT
	case NEG:TOS=-TOS;goto next;							//NEG
	case ABS:op=(TOS>>63);TOS=(TOS+op)^op;goto next;		//ABS
	case CSQRT:TOS=isqrt(TOS);goto next;					//CSQRT
	case CLZ:TOS=iclz(TOS);goto next;					//CLZ
	case FECH:TOS=*(int64_t*)TOS;goto next;//@
	case CFECH:TOS=*(char*)TOS;goto next;//C@
	case WFECH:TOS=*(int16_t*)TOS;goto next;//W@	
	case DFECH:TOS=*(int32_t*)TOS;goto next;//D@		
	case FECHPLUS:NOS++;*NOS=TOS+8;TOS=*(int64_t*)TOS;goto next;//@+
	case CFECHPLUS:NOS++;*NOS=TOS+1;TOS=*(char*)TOS;goto next;// C@+
	case WFECHPLUS:NOS++;*NOS=TOS+2;TOS=*(int16_t*)TOS;goto next;//W@+			
	case DFECHPLUS:NOS++;*NOS=TOS+4;TOS=*(int32_t*)TOS;goto next;//D@+		
	case STOR:*(int64_t*)TOS=(int64_t)*NOS;NOS--;TOS=*NOS;NOS--;goto next;// !
	case CSTOR:*(char*)TOS=(char)*NOS;NOS--;TOS=*NOS;NOS--;goto next;//C!
	case WSTOR:*(int16_t*)TOS=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//W!		
	case DSTOR:*(int32_t*)TOS=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//D!
	case STOREPLUS:*(int64_t*)TOS=*NOS;NOS--;TOS+=8;goto next;// !+
	case CSTOREPLUS:*(char*)TOS=*NOS;NOS--;TOS++;goto next;//C!+
	case WSTOREPLUS:*(int16_t*)TOS=*NOS;NOS--;TOS+=2;goto next;//W!+	
	case DSTOREPLUS:*(int32_t*)TOS=*NOS;NOS--;TOS+=4;goto next;//D!+
	case INCSTOR:*(int64_t*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//+!
	case CINCSTOR:*(char*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//C+!
	case WINCSTOR:*(int16_t*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//W+!	
	case DINCSTOR:*(int32_t*)TOS+=*NOS;NOS--;TOS=*NOS;NOS--;goto next;//D+!
	case TOA:REGA=TOS;TOS=*NOS;NOS--;goto next; //>A
	case ATO:NOS++;*NOS=TOS;TOS=REGA;goto next; //A> 
	case AA:REGA+=TOS;TOS=*NOS;NOS--;goto next;//A+ 	
	
	case AF:NOS++;*NOS=TOS;TOS=*(int64_t*)REGA;goto next;//A@
	case AS:*(int64_t*)REGA=TOS;TOS=*NOS;NOS--;goto next;//A! 
	case AFA:NOS++;*NOS=TOS;TOS=*(int64_t*)REGA;REGA+=8;goto next;//A@+ 
	case ASA:*(int64_t*)REGA=TOS;TOS=*NOS;NOS--;REGA+=8;goto next;//A!+
	case CAF:NOS++;*NOS=TOS;TOS=*(char*)REGA;goto next;//cA@
	case CAS:*(char*)REGA=TOS;TOS=*NOS;NOS--;goto next;//cA! 
	case CAFA:NOS++;*NOS=TOS;TOS=*(char*)REGA;REGA++;goto next;//cA@+ 
	case CASA:*(char*)REGA=TOS;TOS=*NOS;NOS--;REGA++;goto next;//cA!+
	case DAF:NOS++;*NOS=TOS;TOS=*(int32_t*)REGA;goto next;//dA@
	case DAS:*(int32_t*)REGA=TOS;TOS=*NOS;NOS--;goto next;//dA! 
	case DAFA:NOS++;*NOS=TOS;TOS=*(int32_t*)REGA;REGA+=4;goto next;//dA@+ 
	case DASA:*(int32_t*)REGA=TOS;TOS=*NOS;NOS--;REGA+=4;goto next;//dA!+
	
	case TOB:REGB=TOS;TOS=*NOS;NOS--;goto next; //>B
	case BTO:NOS++;*NOS=TOS;TOS=REGB;goto next; //B> 
	case BA:REGB+=TOS;TOS=*NOS;NOS--;goto next;//B+ 

	case BF:NOS++;*NOS=TOS;TOS=*(int64_t*)REGB;goto next;//B@
	case BS:*(int64_t*)REGB=TOS;TOS=*NOS;NOS--;goto next;//B! 
	case BFA:NOS++;*NOS=TOS;TOS=*(int64_t*)REGB;REGB+=8;goto next;//B@+ 
	case BSA:*(int64_t*)REGB=TOS;TOS=*NOS;NOS--;REGB+=8;goto next;//B!+

	case CBF:NOS++;*NOS=TOS;TOS=*(char*)REGB;goto next;//cB@
	case CBS:*(char*)REGB=TOS;TOS=*NOS;NOS--;goto next;//cB! 
	case CBFA:NOS++;*NOS=TOS;TOS=*(char*)REGB;REGB++;goto next;//cB@+ 
	case CBSA:*(char*)REGB=TOS;TOS=*NOS;NOS--;REGB++;goto next;//cB!+

	case DBF:NOS++;*NOS=TOS;TOS=*(int32_t*)REGB;goto next;//dB@
	case DBS:*(int32_t*)REGB=TOS;TOS=*NOS;NOS--;goto next;//dB! 
	case DBFA:NOS++;*NOS=TOS;TOS=*(int32_t*)REGB;REGB+=4;goto next;//dB@+ 
	case DBSA:*(int32_t*)REGB=TOS;TOS=*NOS;NOS--;REGB+=4;goto next;//dB!+

	case MOVED://QMOVE 
//		W=(uint64_t)*(NOS-1);op=(uint64_t)*NOS;
//		while (TOS--) { *(uint64_t*)W=*(uint64_t*)op;W+=8;op+=8; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS<<3);	
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case MOVEA://MOVE> 
//		W=(uint64_t)*(NOS-1)+(TOS<<3);op=(uint64_t)*NOS+(TOS<<3);
//		while (TOS--) { W-=8;op-=8;*(uint64_t*)W=*(uint64_t*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS<<3);		
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case FILL://QFILL
//		W=(uint64_t)*(NOS-1);op=*NOS;while (TOS--) { *(uint64_t*)W=op;W+=8; }
		memset64((uint64_t*)*(NOS-1),*NOS,TOS);		
		NOS-=2;TOS=*NOS;NOS--;goto next;

	case CMOVED://CMOVE 
//		W=(int64_t)*(NOS-1);op=(int64_t)*NOS;
//		while (TOS--) { *(char*)W=*(char*)op;W++;op++; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case CMOVEA://CMOVE> 
//		W=(int64_t)*(NOS-1)+TOS;op=(int64_t)*NOS+TOS;
//		while (TOS--) { W--;op--;*(char*)W=*(char*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case CFILL://CFILL
//		W=(int64_t)*(NOS-1);op=*NOS;while (TOS--) { *(char*)W=op;W++; }
		memset((void*)*(NOS-1),*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;

	
	case DMOVED://MOVE 
//		W=(int64_t)*(NOS-1);op=(int64_t)*NOS;
//		while (TOS--) { *(int*)W=*(int*)op;W+=4;op+=4; }
		memcpy((void*)*(NOS-1),(void*)*NOS,TOS<<2);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case DMOVEA://MOVE> 
//		W=(int64_t)*(NOS-1)+(TOS<<2);op=(int64_t)(*NOS)+(TOS<<2);
//		while (TOS--) { W-=4;op-=4;*(int*)W=*(int*)op; }
		memmove((void*)*(NOS-1),(void*)*NOS,TOS<<2);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case DFILL://FILL
//		W=*(NOS-1);op=*NOS;while (TOS--) { *(int*)W=op;W+=4; }
		memset32((uint32_t*)*(NOS-1),*NOS,TOS);
		NOS-=2;TOS=*NOS;NOS--;goto next;
	case MEM://"MEM"
		NOS++;*NOS=TOS;TOS=(int64_t)&memdata[memd];goto next;


#if defined(LINUX) || defined(RPI)
	case LOADLIB: // "" -- hmo
		TOS=(int64_t)dlopen((char*)TOS,RTLD_NOW);goto next; //RTLD_LAZY 1 RTLD_NOW 2
	case GETPROCA: // hmo "" -- ad		
		TOS=(int64_t)dlsym((void*)*NOS,(char*)TOS);NOS--;goto next;
		
#else	// WINDOWS
	case LOADLIB: // "" -- hmo
		TOS=(int64_t)LoadLibraryA((char*)TOS);goto next;
	case GETPROCA: // hmo "" -- ad
		TOS=(int64_t)GetProcAddress((HMODULE)*NOS,(char*)TOS);NOS--;goto next;

#endif
		
		 
	case SYSCALL0: // adr -- rs
		TOS=(int)(* (int(*)())TOS)();goto next;
	case SYSCALL1: // a0 adr -- rs 
		TOS=(int)(* (int(*)(int))TOS)(*NOS);NOS--;goto next;
	case SYSCALL2: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int))TOS)(*(NOS-1),*NOS);NOS-=2;goto next;
	case SYSCALL3: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int))TOS)(*(NOS-2),*(NOS-1),*NOS);NOS-=3;goto next;
	case SYSCALL4: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int))TOS)(*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=4;goto next;
	case SYSCALL5: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int))TOS)(*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=5;goto next;
	case SYSCALL6: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int,int))TOS)(*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=6;goto next;
	case SYSCALL7: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int,int,int))TOS)(*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=7;goto next;
	case SYSCALL8: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int,int,int,int))TOS)(*(NOS-7),*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=8;goto next;
	case SYSCALL9: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int,int,int,int,int))TOS)(*(NOS-8),*(NOS-7),*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=9;goto next;
	case SYSCALL10: // a1 a0 adr -- rs 
		TOS=(int)(* (int(*)(int,int,int,int,int,int,int,int,int,int))TOS)(*(NOS-9),*(NOS-8),*(NOS-7),*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),*NOS);NOS-=10;goto next;
/*
	case SYSCALL6F1:
		TOS=(int)(* (int(*)(int,int,int,int,int,int,double))TOS)(*(NOS-6),*(NOS-5),*(NOS-4),*(NOS-3),*(NOS-2),*(NOS-1),((double)(*NOS)/(1<<16))	);
		NOS-=7;goto next;
*/
/* -- DEBUG
	case DOT:printf("%llx ",TOS);TOS=*NOS;NOS--;goto next;
	case DOTS:printf((char*)TOS);TOS=*NOS;NOS--;goto next;
*/	
	case ENDWORD: goto next;
//----------------- ONLY INTERNAL
	case JMP:ip=(op>>8);goto next;//JMP							// JMP
	case JMPR:ip+=(op>>8);goto next;//JMP						// JMPR	
	case LIT2:TOS=(TOS&0xffffff)|((op>>8)<<24);goto next;		// LIT ....xxxxxxaaaaaa
	case LIT3:TOS=(TOS&0xffffffffffff)|((op>>8)<<48);goto next;	// LIT xxxx......aaaaaa	
//----------------- OPTIMIZED WORD
	case AND1:TOS&=op>>8;goto next;
	case OR1:TOS|=op>>8;goto next;
	case XOR1:TOS^=op>>8;goto next;
	case ADD1:TOS+=op>>8;goto next;
	case SUB1:TOS-=op>>8;goto next;
	case MUL1:TOS*=op>>8;goto next;
	case DIV1:TOS/=op>>8;goto next;
	case SHL1:TOS<<=op>>8;goto next;
	case SHR1:TOS>>=op>>8;goto next;
	case SHR01:TOS=(uint64_t)TOS>>(op>>8);goto next;
	case MOD1:TOS=TOS%(op>>8);goto next;
	case DIVMOD1:op>>=8;NOS++;*NOS=TOS/op;TOS=TOS%op;goto next;	//DIVMOD
	case MULDIV1:op>>=8;TOS=(long long)(*NOS)*TOS/op;NOS--;goto next;		//MULDIV
	case MULSHR1:op>>=8;TOS=((long long)(*NOS)*TOS)>>op;NOS--;goto next;	//MULSHR
	case CDIVSH1:op>>=8;TOS=(long long)((*NOS)<<op)/TOS;NOS--;goto next;	//CDIVSH
	case IFL1:if ((op<<32>>48)<=TOS) ip+=(op<<48>>56);goto next;	//IFL
	case IFG1:if ((op<<32>>48)>=TOS) ip+=(op<<48>>56);goto next;	//IFG
	case IFE1:if ((op<<32>>48)!=TOS) ip+=(op<<48>>56);goto next;	//IFN
	case IFGE1:if ((op<<32>>48)>TOS) ip+=(op<<48>>56);goto next;	//IFGE
	case IFLE1:if ((op<<32>>48)<TOS) ip+=(op<<48>>56);goto next;	//IFLE
	case IFNE1:if ((op<<32>>48)==TOS) ip+=(op<<48>>56);goto next;//IFNO
	case IFAND1:if (!((op<<32>>48)&TOS)) ip+=(op<<48>>56);goto next;//IFNA
	case IFNAND1:if ((op<<32>>48)&TOS) ip+=(op<<48>>56);goto next;//IFAN
	}
}

	
////////////////////////////////////////////////////////////////////////////
int main(int argc, char* argv[])
{
char filename[1024];
if (argc>1) 
	strcpy(filename,argv[1]); 
else 
	strcpy(filename,"main.r3");
if (!r3compile(filename)) return -1;
//dumpdicc();
//dumpcode();
runr3(boot);
return 0;
}
