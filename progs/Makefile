#	$OpenBSD: Makefile,v 1.10 2019/12/21 21:40:01 espie Exp $

include ../mk.config

all: build

PROGS 	= infocmp tic tput tset

OBJS  	= dump_entry.o infocmp.o tic.o tput.o tset.o
MAN	= tic.1
LDFLAGS += ../libcurses/libcurses.a
CFLAGS	+= -I../libcurses -I.

INFOCMP_OBJS 	= dump_entry.o infocmp.o
TIC_OBJS 	= dump_entry.o tic.o
TPUT_OBJS 	= tput.o
TSET_OBJS 	= tset.o

all: ${PROGS}

dump_entry.o: termsort.c

termsort.c: MKtermsort.sh
	sh MKtermsort.sh awk ../libcurses/Caps > $@

.c.o:
	${CC} -c ${CFLAGS} $<

build: ${PROGS}

infocmp: ${INFOCMP_OBJS} 
	${CC} -o $@ ${INFOCMP_OBJS} ${LDFLAGS}

tic: ${TIC_OBJS} 
	${CC} -o $@ ${TIC_OBJS} ${LDFLAGS}

tput: ${TPUT_OBJS} 
	${CC} -o $@ ${TPUT_OBJS} ${LDFLAGS}

tset: ${TSET_OBJS} 
	${CC} -o $@ ${TSET_OBJS} ${LDFLAGS}

install: ${PROGS}
	${INSTALL} -d ${BINDIR}
	${INSTALL} -d ${MANDIR}/man1
	for i in ${PROGS}; do \
		${INSTALL} -s -m 755 $$i ${BINDIR}/$$i; \
		${INSTALL} -m 644 $$i.1 ${MANDIR}/man1/$$i.1; \
	done
	for i in infotocap captoinfo; do \
		${LN} -sf tic ${BINDIR}/$$i; \
		${INSTALL} -m 644 $$i.1 ${MANDIR}/man1/$$i.1; \
	done
	${LN} -sf tput ${BINDIR}/clear

uninstall:
	for i in ${PROGS} infotocap captoinfo; do \
		${RM} -f ${BINDIR}/$$i; \
		${RM} -f ${MANDIR}/$$i; \
	done
	${RM} -f ${BINDIR}/clear
	

clean:
	${RM} -f ${OBJS} ${PROGS} termsort.c
