#	$OpenBSD: Makefile,v 1.25 2016/09/25 17:43:11 natano Exp $

include ../mk.config

TIC = ../progs/tic

all build: terminfo termcap

terminfo: termtypes.master 
	${TIC} -x -o $@ $<
	@[ -d $@ ] || exit 1

termcap: termtypes.master
	${TIC} -C -x $< > $@
	@[ -s $@ ] || exit 1

install:
	${INSTALL} -d -o root -g wheel ${DATAROOTDIR}/terminfo
	${INSTALL} -d -o root -g wheel ${DATAROOTDIR}/misc
	${INSTALL} -d -o root -g wheel ${SYSCONFDIR}
	${INSTALL} -d -o root -g wheel ${MANDIR}/man5
	${INSTALL} -m 644 termcap.5 ${MANDIR}/man5/termcap.5
	${FIND} terminfo -type f -exec \
	     ${INSTALL} -D -m 644 \
	     {} ${DATAROOTDIR}/{} \;
	${INSTALL} -m 644 termcap \
	     ${DATAROOTDIR}/misc/termcap
	${LN} -s ${DATADOORDIR}/misc/termcap ${SYSCONFDIR}/termcap

uninstall:
	${RM} -rf ${DATAROOTDIR}/terminfo
	${RM} -f ${DATAROOTDIR}/misc/termcap
	${RM} -f ${MANDIR}/man5/termcap.5
	${RM} -f ${SYSCONFDIR}/termcap

clean:
	${RM} -f termcap
	${RM} -rf terminfo
