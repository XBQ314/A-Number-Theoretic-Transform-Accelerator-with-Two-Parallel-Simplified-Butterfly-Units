bin: main.c cfmm.c oldadd.c mod_cal.c
	@gcc -Wall -g main.c cfmm.c oldadd.c mod_cal.c -I ./include -o bin

run: bin
	bin.exe

gdb: bin
	@gdb ./bin.exe

clean:
	del bin.exe