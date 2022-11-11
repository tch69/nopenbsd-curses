
all: build

LIB   = form
LIBA  =	libform.a
LIBSO =	libform.so

OBJS  =	fld_arg.o fld_attr.o fld_current.o fld_def.o fld_dup.o fld_ftchoice.o \
	fld_ftlink.o fld_info.o fld_just.o fld_link.o fld_max.o fld_move.o \
	fld_newftyp.o fld_opts.o fld_pad.o fld_page.o fld_stat.o fld_type.o \
	fld_user.o frm_cursor.o frm_data.o frm_def.o \
	frm_driver.o frm_hook.o frm_opts.o frm_page.o frm_post.o \
	frm_req_name.o frm_scale.o frm_sub.o frm_user.o frm_win.o fty_alnum.o \
	fty_alpha.o fty_enum.o fty_int.o fty_ipv4.o fty_num.o fty_regex.o \
	f_trace.o

CFLAGS+=-I../libmenu -I../libcurses

form.pc: ../pc_gen
	LIB=${LIB} PREFIX=${PREFIX} LIBDIR=${LIBDIR} INCDIR=${INCDIR} \
		sh ../pc_gen > $@

.c.o:
	${CC} -c -fPIC ${CFLAGS} $<

${LIBA}: ${OBJS}
	${AR} rc $@ ${OBJS}
	${RANLIB} $@

${LIBSO}: ${OBJS}
	${CC} -shared -o $@ -Wl,--soname="$@" ${OBJS}

build: libform

libform: ${LIBA} ${LIBSO} form.pc

install: ${LIBA} ${LIBSO}
	${INSTALL} -d ${MANDIR}/man3
	${INSTALL} -d ${LIBDIR}
	${INSTALL} -d ${PKGCONFDIR}
	${INSTALL} -d ${INCDIR} 
	${INSTALL} -m 755 ${LIBSO} ${LIBDIR}/${LIBSO}
	${INSTALL} -m 644 form.pc ${PKGCONFDIR}/form.pc
	${INSTALL} -m 644 ${LIBA} ${LIBDIR}/${LIBA}
	${INSTALL} -m 644 form.h ${INCDIR}/form.h
	for i in *.3; do \
		${INSTALL} -m -644 $$i ${MANDIR}/man3/$$i; \
	done

uninstall:
	${RM} -f ${LIBDIR}/${LIBSO} ${LIBDIR}/${LIBA}
	${RM} -f ${PKGCONFDIR}/form.pc
	${RM} -f ${INCDIR}/form.h
	for i in *.3; do \
		${RM} -f ${MANDIR}/man3/$$i; \
	done

clean:
	${RM} -f ${OBJS}
	${RM} -f ${LIBSO} ${LIBA} form.pc

include ../mk.config
