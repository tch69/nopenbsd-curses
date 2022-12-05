
include ../mk.config

all: build

LIB   = menu
LIBA  =	libmenu.a
LIBSO = libmenu.so

OBJS  =	m_attribs.o m_cursor.o m_driver.o m_format.o \
	m_global.o m_hook.o m_item_cur.o m_item_nam.o m_item_new.o \
	m_item_opt.o m_item_top.o m_item_use.o m_item_val.o m_item_vis.o \
	m_items.o m_new.o m_opts.o m_pad.o m_pattern.o m_post.o \
	m_req_name.o m_scale.o m_spacing.o m_sub.o m_trace.o m_userptr.o m_win.o
INCS  =	menu.h eti.h

CFLAGS+=-I. -I../libcurses -DHAVE_CONFIG_H

menu.pc: ../pc_gen
	LIB=${LIB} PREFIX=${PREFIX} LIBDIR=${LIBDIR} INCDIR=${INCDIR} \
		sh ../pc_gen > $@

.c.o:
	${CC} -c -fPIC ${CFLAGS} $<

${LIBSO}: ${OBJS}
	${CC} -shared -o $@ -Wl,--soname="$@" ${OBJS} ${LDFLAGS}

${LIBA}: ${OBJS}
	${AR} rc $@ ${OBJS}
	${RANLIB} $@

build: libmenu

libmenu: ${LIBSO} ${LIBA} menu.pc

install: ${LIBA} ${LIBSO}
	${INSTALL} -d ${MANDIR}/man3
	${INSTALL} -d ${LIBDIR}
	${INSTALL} -d ${PKGCONFDIR}
	${INSTALL} -d ${INCDIR}
	${INSTALL} -m 755 ${LIBSO} ${LIBDIR}/${LIBSO}
	${INSTALL} -m 644 ${LIBA} ${LIBDIR}/${LIBA}
	${INSTALL} -m 644 eti.h ${INCDIR}/eti.h
	${INSTALL} -m 644 menu.h ${INCDIR}/menu.h
	${INSTALL} -m 644 menu.pc ${PKGCONFDIR}/menu.pc
	for i in *.3; do \
		${INSTALL} -m 644 $$i ${MANDIR}/man3/$$i; \
	done

uninstall:
	${RM} -f ${LIBDIR}/${LIBSO} ${LIBDIR}/${LIBA}
	${RM} -f ${INCDIR}/eti.h ${INCDIR}/menu.h
	${RM} -f ${PKGCONFDIR}/menu.pc
	for i in *.3; do \
		${RM} -f ${MANDIR}/man3/$$i; \
	done

clean:
	${RM} -rf ${OBJS}
	${RM} -rf ${LIBSO} ${LIBA}
