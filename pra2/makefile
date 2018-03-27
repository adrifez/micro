all: pract2a.exe pract2b.exe pract2c.exe

pract2a.exe: pract2a.obj
	tlink /v pract2a
	
pract2a.obj: pract2a.asm 
	tasm /zi pract2a.asm,,pract2a.lst
	
pract2b.exe: pract2b.obj
	tlink /v pract2b
	
pract2b.obj: pract2b.asm 
	tasm /zi pract2b.asm,,pract2b.lst
	
pract2c.exe: pract2c.obj
	tlink /v pract2c
	
pract2c.obj: pract2c.asm 
	tasm /zi pract2c.asm,,pract2c.lst

clean:
	del pract2a.obj
	del	pract2a.map
	del pract2a.lst
	del pract2a.exe
	del pract2b.obj
	del pract2b.map
	del pract2b.lst
	del pract2b.exe
	del pract2c.obj
	del pract2c.map
	del pract2c.lst
	del pract2c.exe