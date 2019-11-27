all: prog

prog: main.o F1.o F2.o F3.o Func.o
	gcc main.o F1.o F2.o F3.o Func.o -o homework

main.o: main.c
	gcc -W -Wall -w -g -O2 -m32 -c main.c

F1.o: F1.asm
	nasm -g -f elf32 F1.asm -o F1.o

F2.o: F2.asm
	nasm -g -f elf32 F2.asm -o F2.o

F3.o: F3.asm
	nasm -g -f elf32 F3.asm -o F3.o	

Func.o: Func.asm
	nasm -g -f elf32 Func.asm -o Func.o	

clean:
	rm -rf *.o
