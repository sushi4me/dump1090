CFLAGS?=-O2 -g -Wall -W $(shell pkg-config --cflags librtlsdr)
LDLIBS+=$(shell pkg-config --libs librtlsdr) -lpthread -lm
CC?=gcc
PROGNAME=dump1090

all: dump1090

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o dump1090

clean_logs:
	rm -rf logs *.log

dump1090: dump1090.o anet.o
	$(CC) -g -o dump1090 dump1090.o anet.o $(LDFLAGS) $(LDLIBS)

get:
	@read -p "Flight no.: " flt; \
	cat ./logs/* | grep -w $$flt - > $$flt.log;

install:
	@sudo apt-get install librtlsdr-dev
	@sudo apt-get install libusb-1.0-0-dev

run: dump1090
	./dump1090 --net --interactive --log
