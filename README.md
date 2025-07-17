
# r3 VM

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/phreda4/r3evm)

r3 is a concatenative language of the forth family, more precisely it takes elements of the ColorForth, the colors that have the words internally are encoded by a prefix, in r3 this prefix is explicit.

This is the virtual machine, load main.r3, compile in bytecodes (really are dwordcodes) and interpret this code.

# Connection with the computer

All the conection to OS is made with Dinamyc Library load and call this API with LOADLIB and GETPROC words
This allow not need recompiling when use another lib and full compilation with library calls 

# Optimizations

The speed is not a issue anymore, but I like optimice the VM.
The last version when tokenize the code make some changes for gain speed.

- Constant folding: if you code "2 2 +" really in the machine load "4".
- Inline short words: if you definition is short, like ":getxy * + ;" this word is not called, the tokenize write the tokens "* +" instead of "CALL getxy"
- Tail call: if a word end with a word, the token use is "JMP" not "CALL" then one level in return stack is saved, and, for this, the recursion is convert in a loop.
- Hidden tokens: there are a lot of hidden token with specific optimization for common operations, for example  "12 +" really is one token, not two. Or "3 << + @" is one token, etc.

All this optimiations are made without intervencion, the tokenizer is automatic and not require programmer indication.

Really R3 have a compiler with much better optimization for now and have space to improve, but this VM is the first step and is good have a speed one.

# Linux version

The VM is working on LINUX and perhaps in RPI too, for MAC need change how access to memory (I do this for previous vm) Apple have a costume of paranoid for make more money !!
But the system need the conecction with Librarys (in r3) and I not have money for do this, write me if you like to work on this and have a BIG SIGN with you name in the language for help me.


  
