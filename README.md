
# r3

r3 is a concatenative language of the forth family, more precisely it takes elements of the ColorForth, the colors that have the words internally are encoded by a prefix, in r3 this prefix is explicit.

This is the virtual machine, load main.r3, compile in bytecodes (really are dwordcodes) and interpret this code.

# Naked experiment

This is a naked version, all the conection to OS is made with Dinamyc Library load and call.
This allow not need recompiling when use another lib and full compilation with library calls 

# Core

The core is very small without conecction with OS unless LOADLIB and GETPROC.