CC=gcc
//CFLAGS = -g -Wall -O3 -std=gnu99 -DCHANNELS=2
#CFLAGS += -g -Wall -O3 -std=gnu99 -DCHANNELS=4
# -DZEROMQ="\"tcp://178.77.72.138:5556\""

CFLAGS += -g -I/usr/local/include -Wall -O3 -std=gnu99 -DCHANNELS=2 -DDIRTYCOMPRESSOR
LDFLAGS += -lm -L/usr/local/lib -llo -lsndfile -lsamplerate -ljack
# -lzmq
#LDFLAGS += -lxtract

all: dirt

clean:
	rm -f *.o *~ dirt dirt-analyse

dirt: dirt.o jack.o audio.o file.o server.o  Makefile
	$(CC) dirt.o jack.o audio.o file.o server.o $(CFLAGS) $(LDFLAGS) -o dirt 

dirt-analyse: dirt.o jack.o audio.o file.o server.o pitch.o Makefile
	$(CC) dirt.o jack.o audio.o file.o server.o pitch.o $(CFLAGS) $(LDFLAGS) -o dirt-analyse

test : test.c Makefile
	$(CC) test.c -llo -o test

install: dirt
	install -d $(DESTDIR)/bin/
	install -m 0755 dirt $(DESTDIR)/bin/dirt


