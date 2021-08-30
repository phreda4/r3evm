
CPP      = g++
CC       = gcc
OBJ      = r3.o 
LINKOBJ  = r3.o 
LIBS     = -ldl -s
INCS     = 
CXXINCS  = 
BIN      = r3lin
CXXFLAGS = $(CXXINCS) -Os -fpermissive
CFLAGS   = $(INCS) -Os 
RM       = rm -f

.PHONY: all all-before all-after clean clean-custom

all: all-before $(BIN) all-after

clean: clean-custom
	${RM} $(OBJ) $(BIN)

$(BIN): $(OBJ)
	$(CPP) $(LINKOBJ) -o $(BIN) $(LIBS)

r3.o: r3.cpp
	$(CPP) -c r3.cpp -o r3.o $(CXXFLAGS)


