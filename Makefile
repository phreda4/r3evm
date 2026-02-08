# makefile for linux
# remove the comment in r3.cpp and r3d.cpp
# //#define LINUX ; 
CPP      = g++
CC       = gcc
OBJ      = r3.o r3d.o
LIBS     = -ldl -s -flto
INCS     = 
CXXINCS  = 
BIN      = r3lin r3lind
CXXFLAGS = $(CXXINCS) -Oz -fpermissive -fomit-frame-pointer -fno-exceptions -fno-rtti 
CFLAGS   = $(INCS) -Oz
RM       = rm -f

.PHONY: all all-before all-after clean clean-custom

all: all-before $(BIN) all-after

clean: clean-custom
	${RM} $(OBJ) $(BIN)

r3lin: r3.o
	$(CC) r3.o -o r3lin $(LIBS)

r3lind: r3d.o
	$(CC) r3d.o -o r3lind $(LIBS)

r3.o: r3.c
	$(CC) -c r3.c -o r3.o $(CXXFLAGS)

r3d.o: r3d.c
	$(CC) -c r3d.c -o r3d.o $(CXXFLAGS)