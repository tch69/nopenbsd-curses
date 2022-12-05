
include ../mk.config

all: build

LIB   = panel
LIBA  = lib${LIB}.a
LIBSO = lib${LIB}.so

OBJS  =	p_above.o p_below.o p_bottom.o p_delete.o p_hidden.o p_hide.o p_move.o \
	p_new.o p_replace.o p_show.o p_top.o p_update.o p_user.o p_win.o panel.o

INCS  =	panel.h

MAN=	panel.3

CFLAGS+= -I../libcurses


panel.pc: ../pc_gen
	LIB=${LIB} PREFIX=${PREFIX} LIBDIR=${LIBDIR} INCDIR=${INCDIR} \
		sh ../pc_gen > $@
.c.o:
	${CC} -c -fPIC ${CFLAGS} $<

${LIBSO}: ${OBJS}
	${CC} -shared -o $@ -Wl,--soname="$@" ${OBJS} ${LDFLAGS}

${LIBA}: ${OBJS}
	${AR} rc $@ ${OBJS}
	${RANLIB} $@

build: libpanel

libpanel: ${LIBSO} ${LIBA} panel.pc

install: ${LIBA} ${LIBSO}
	${INSTALL} -d ${MANDIR}/man3
	${INSTALL} -d ${LIBDIR}
	${INSTALL} -d ${PKGCONFDIR}
	${INSTALL} -d ${INCDIR}
	${INSTALL} -m 755 ${LIBSO} ${LIBDIR}/${LIBSO}
	${INSTALL} -m 644 ${LIBA} ${LIBDIR}/${LIBA}
	${INSTALL} -m 644 panel.h ${INCDIR}/panel.h
	${INSTALL} -m 644 panel.pc ${PKGCONFDIR}/panel.pc
	${INSTALL} -m -644 panel.3 ${MANDIR}/man3/panel.3

uninstall:
	${RM} -f ${LIBDIR}/${LIBSO} ${LIBDIR}/${LIBA}
	${RM} -f ${PKGCONFDIR}/panel.pc
	${RM} -f ${INCDIR}/panel.h
	${RM} -f ${MANDIR}/man3/panel.3

clean:
	${RM} -rf ${OBJS}
	${RM} -rf ${LIBSO} ${LIBA} panel.pc
