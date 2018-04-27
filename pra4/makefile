all: pract3.exe

pract3.exe: pract3.obj pract3a.obj pract3b.obj
	tcc -v -ml -Lc:\compila\tc\lib pract3.obj pract3a.obj pract3b.obj

pract3.obj: pract3.c
	tcc -c -v -ml -Ic:\compila\tc\include pract3.c

pract3a.obj: pract3a.asm
	tasm /zi /ml pract3a,,pract3a

pract3b.obj: pract3b.asm
	tasm /zi /ml pract3b,,pract3b

clean:
	del	pract3a.map
	del pract3a.lst
	del pract3a.obj
	del	pract3b.map
	del pract3b.lst
	del pract3b.obj
	del pract3.obj
	del pract3.exe