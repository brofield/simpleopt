CC=g++
CFLAGS=-Wall
CPPFLAGS=-Wall

OBJS=fullSample.o basicSample.o globSample.o

help:
	@echo Just \"make clean all test\" and all should be fine.
	
all: $(OBJS)
	$(CC) -o globSample  globSample.o
	$(CC) -o basicSample basicSample.o
	$(CC) -o fullSample  fullSample.o

clean:
	rm -f core *.o fullSample basicSample globSample

test:
	./runtests.sh

install:
	@echo No install required. Just include the header file and use it.

globSample.o: SimpleOpt.h SimpleGlob.h
fullSample.o: SimpleOpt.h SimpleGlob.h
basicSample.o: SimpleOpt.h SimpleGlob.h

