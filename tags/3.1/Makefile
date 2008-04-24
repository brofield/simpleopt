CC=g++
CFLAGS=-Wall
CPPFLAGS=-Wall

OBJS=fullSample.o basicSample.o globSample.o

help:
	@echo This makefile is just for the test program \(use \"make clean all test\"\)
	@echo Just include the SimpleOpt.h header file to use it.

all: $(OBJS)
	$(CC) -o globSample  globSample.o
	$(CC) -o basicSample basicSample.o
	$(CC) -o fullSample  fullSample.o

clean:
	rm -f core *.o fullSample basicSample globSample

test:
	@if [ ! -x ./runtests.sh ]; then chmod +x ./runtests.sh; fi
	./runtests.sh > runtests.out
	diff --unified=0 -b runtests.ux.txt runtests.out

install:
	@echo No install required. Just include the SimpleOpt.h header file to use it.

globSample.o: SimpleOpt.h SimpleGlob.h
fullSample.o: SimpleOpt.h SimpleGlob.h
basicSample.o: SimpleOpt.h SimpleGlob.h

