all: p4a.com p4b.exe p4c.exe

p4a.com: p4a.obj
	tlink /t p4a
	
p4a.obj: p4a.asm 
	tasm /zi p4a.asm,,p4a.lst
	
p4b.exe: p4b.obj
	tlink /v p4b
	
p4b.obj: p4b.asm 
	tasm /zi p4b.asm,,p4b.lst
	
p4c.exe: p4c.obj
	tlink /v p4c
	
p4c.obj: p4c.asm 
	tasm /zi p4c.asm,,p4c.lst

clean:
	del p4a.obj
	del p4a.map
	del p4a.lst
	del p4a.com
	del p4b.obj
	del p4b.map
	del p4b.lst
	del p4b.exe
	del p4c.obj
	del p4c.map
	del p4c.lst
	del p4c.exe