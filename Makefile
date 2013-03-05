## build for lasvm library

COMPILER = gcc 
LIBS =  -lm
CFLAGS = #-fPIC -g -c -Wall -o
COPTS =  -fPIC -g -c -Wall  -march=nocona -O3 -mmmx -msse -pthread -o 
LIBPATH = 

# -O3 -march=nocona -mmmx -msse -pthread -DLUSH -I/usr/local/share/lush2/packages/svm/lasvm -I/usr/local/share/lush2/packages/svm/lasvm -I/usr/local/share/lush2/include -c /usr/local/share/lush2/packages/svm/lasvm/vector.c -o /home/scott/.lush2/packages/svm/lasvm/C/x86_64-unknown-linux-gnu/vector.o

all: lasvm

clean:
	rm *.o *.so

dist:
	tar -cf ../lasvmc.tar *.c *.h Makefile README LICENSE 

kernel.o: kernel.c
	$(COMPILER) $(COPTS) kernel.o kernel.c  $(LIBS) $(CFLAGS)

kcache.o: kcache.c 
	$(COMPILER) $(COPTS) kcache.o kcache.c  $(LIBS) $(CFLAGS)

messages.o: messages.c
	$(COMPILER) $(COPTS) messages.o messages.c -lm  $(LIBS) $(CFLAGS)

vector.o: vector.c 
	$(COMPILER) $(COPTS) vector.o vector.c $(LIBS) $(CFLAGS)

lasvm.o: lasvm.c
	$(COMPILER) $(COPTS) lasvm.o lasvm.c  $(LIBS) $(CFLAGS)

lasvm: kernel.o kcache.o messages.o vector.o lasvm.o 
	$(COMPILER) -shared -Wl,-soname,lasvm.so -o lasvm.so \
	vector.o kernel.o kcache.o messages.o lasvm.o  -lc	
