CFLAGS?=-O2 -g -Wall -W $(shell pkg-config --cflags librtlsdr)
LDLIBS+=$(shell pkg-config --libs librtlsdr) -lpthread -lm
CC?=gcc
PROGNAME=dump1090

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) -c $<

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LDFLAGS) $(LDLIBS)

run: dump1090
	./dump1090 --net --interactive --log

get:
	@read -p "Flight no.: " flt; \
	cat ./logs/* | grep -w $$flt - > $$flt.log;

clean:
	rm -f *.o dump1090

clean_logs:
	rm -rf logs *.log
