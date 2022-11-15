
include ../mk.config

all: build

# Search in subdirs
VPATH= .:base:tinfo:trace:tty:widechar

# Default library names
LIB   = curses
LIBA  = libcurses.a
LIBSO = libcurses.so

OBJS=	codes.o comp_captab.o expanded.o fallback.o lib_gen.o lib_keyname.o \
	names.o unctrl.o
# base
OBJS+=	define_key.o key_defined.o keybound.o keyok.o legacy_coding.o \
	lib_addch.o lib_addstr.o lib_beep.o lib_bkgd.o lib_box.o lib_chgat.o \
	lib_clear.o lib_clearok.o lib_clrbot.o lib_clreol.o lib_color.o \
	lib_colorset.o lib_delch.o lib_delwin.o lib_dft_fgbg.o lib_echo.o \
	lib_endwin.o lib_erase.o lib_flash.o lib_freeall.o lib_getch.o \
	lib_getstr.o lib_hline.o lib_immedok.o lib_inchstr.o lib_initscr.o \
	lib_insnstr.o lib_insch.o lib_insdel.o lib_instr.o \
	lib_isendwin.o lib_leaveok.o lib_mouse.o lib_move.o lib_mvwin.o \
	lib_newterm.o lib_newwin.o lib_nl.o lib_overlay.o lib_pad.o \
	lib_printw.o lib_redrawln.o lib_refresh.o lib_restart.o \
	lib_scanw.o lib_screen.o lib_scroll.o lib_scrollok.o \
	lib_scrreg.o lib_set_term.o lib_slk.o lib_slkatr_set.o \
	lib_slkatrof.o lib_slkatron.o lib_slkatrset.o lib_slkattr.o \
	lib_slkclear.o lib_slkcolor.o lib_slkinit.o lib_slklab.o \
	lib_slkrefr.o lib_slkset.o lib_slktouch.o lib_touch.o \
	lib_ungetch.o lib_vline.o lib_wattroff.o lib_wattron.o \
	lib_winch.o lib_window.o nc_panel.o resizeterm.o safe_sprintf.o \
	tries.o use_window.o version.o vsscanf.o wresize.o
# tinfo
OBJS+=	access.o add_tries.o alloc_entry.o alloc_ttype.o captoinfo.o \
	comp_hash.o comp_error.o comp_expand.o comp_parse.o comp_scan.o \
	db_iterator.o doalloc.o entries.o free_ttype.o getenv_num.o \
	hashed_db.o home_terminfo.o init_keytry.o lib_acs.o lib_baudrate.o \
	lib_cur_term.o lib_data.o lib_has_cap.o lib_kernel.o lib_longname.o \
	lib_napms.o lib_options.o lib_print.o lib_raw.o lib_setup.o \
	lib_termcap.o lib_termname.o lib_tgoto.o lib_ti.o lib_tparm.o \
	lib_tputs.o lib_ttyflags.o name_match.o parse_entry.o \
	read_entry.o read_termcap.o setbuf.o strings.o \
	trim_sgr0.o use_screen.o write_entry.o
# trace
OBJS+=	lib_trace.o lib_traceatr.o lib_tracebits.o lib_tracechr.o \
	lib_tracedmp.o lib_tracemse.o trace_buf.o trace_tries.o trace_xnames.o \
	varargs.o visbuf.o
# tty
OBJS+=	hardscroll.o hashmap.o lib_mvcur.o lib_tstp.o lib_twait.o \
	lib_vidattr.o tty_update.o
# widechar
OBJS+=  charable.o lib_add_wch.o lib_box_set.o lib_cchar.o lib_erasewchar.o \
	lib_get_wch.o lib_get_wstr.o lib_hline_set.o lib_in_wch.o \
	lib_in_wchnstr.o lib_ins_wch.o lib_inwstr.o lib_key_name.o \
	lib_pecho_wchar.o lib_slk_wset.o lib_unget_wch.o lib_vid_attr.o \
	lib_vline_set.o lib_wacs.o lib_wunctrl.o

HOSTCFLAGS?=	${CFLAGS}
HOSTLDFLAGS?=	${LDFLAGS}
HOSTCFLAGS+=	-I. 
CFLAGS+=	-I.

INCS 	= curses.h term.h termcap.h unctrl.h

GENFILES =  ncurses_cfg.h codes.c comp_captab.c expanded.c fallback.c \
	keys.list lib_gen.c lib_keyname.c names.c unctrl.c \
	make_hash make_keys init_keytry.h ncurses.pc

keys.list: tinfo/MKkeys_list.sh
	sh tinfo/MKkeys_list.sh Caps | sort > $@

fallback.c: tinfo/MKfallback.sh
	sh tinfo/MKfallback.sh $(FALLBACK_LIST) > $@

lib_gen.c: base/MKlib_gen.sh
	sh base/MKlib_gen.sh "${CC} -E -P -I${.CURDIR}" \
		"${AWK}" generated < curses.h > lib_gen.c

init_keytry.h: make_keys keys.list
	./make_keys keys.list > $@

make_keys: tinfo/make_keys.c curses.priv.h names.c
	${HOSTCC} ${LDSTATIC} ${HOSTCFLAGS} ${HOSTLDFLAGS} \
		-o $@ tinfo/make_keys.c ${LDADD}

make_hash: tinfo/comp_hash.c curses.priv.h \
		hashsize.h
	${HOSTCC} ${LDSTATIC} ${HOSTCFLAGS} -DMAIN_PROGRAM ${HOSTLDFLAGS} \
		-o $@ tinfo/comp_hash.c ${LDADD}

expanded.c: term.h curses.priv.h \
		ncurses_cfg.h tty/MKexpanded.sh
	sh tty/MKexpanded.sh "${CC} -E -P" ${CPPFLAGS} > $@

comp_captab.c: make_hash
	sh tinfo/MKcaptab.sh ${AWK} 1 \
		tinfo/MKcaptab.awk Caps > $@

lib_keyname.c: keys.list base/MKkeyname.awk
	${AWK} -f base/MKkeyname.awk bigstrings=1 \
		keys.list > $@

names.c: tinfo/MKnames.awk
	${AWK} -f tinfo/MKnames.awk \
		Caps > names.c
codes.c: tinfo/MKcodes.awk
	${AWK} -f tinfo/MKcodes.awk \
		bigstrings=1 Caps > codes.c

unctrl.c: base/MKunctrl.awk
	echo | ${AWK} -f base/MKunctrl.awk bigstrings=1 > $@

ncurses.pc: ../pc_gen
	LIB=${LIB} PREFIX=${PREFIX} LIBDIR=${LIBDIR} INCDIR=${INCDIR} \
		sh ../pc_gen > $@

.c.o:
	${CC} -fPIC -c ${CFLAGS} $<

build: libcurses

libcurses: ${GENFILES} ${LIBSO} ${LIBA}

${LIBSO}: ${OBJS}
	${CC} -shared -o $@ ${OBJS} -Wl,--soname="$@"

${LIBA}: ${OBJS}
	${AR} rc $@ ${OBJS}
	${RANLIB} $@

install: ${INCS} ${LIBSO} ${LIBA} ncurses.pc
	${INSTALL} -d ${LIBDIR}
	${INSTALL} -d ${PKGCONFDIR}
	${INSTALL} -d ${INCDIR}
	${INSTALL} -d ${MANDIR}/man3
	${INSTALL} -d ${MANDIR}/man5
	${INSTALL} -d ${MANDIR}/man7
	${INSTALL} -m 755 ${LIBSO} ${LIBDIR}/${LIBSO}
	${INSTALL} -m 644 ${LIBA}  ${LIBDIR}/${LIBA}
	for i in ${LIBSO} ${LIBA}; do \
		${LN} -sf $$i ${LIBDIR}/`echo $$i | sed 's/curses/ncurses/'`; \
		${LN} -sf $$i ${LIBDIR}/`echo $$i | sed 's/curses/termcap/'`; \
	done
	${INSTALL} -m 644 ncurses.pc ${PKGCONFDIR}/ncurses.pc
	for i in ${INCS}; do \
		${INSTALL} -m 644 $$i ${INCDIR}/$$o; \
	done
	${LN} -sf curses.h ${INCDIR}/ncurses.h
	for i in *.3; do \
		${INSTALL} -m 644 $$i ${MANDIR}/man3/$$i; \
	done
	for i in *.5; do \
		${INSTALL} -m 644 $$i ${MANDIR}/man5/$$i; \
	done
	${INSTALL} -m 644 term.7 ${MANDIR}/man7/term.7

uninstall:
	for i in ${LIBSO} ${LIBA} libncurses.so libncurses.a; do \
		${RM} -f ${LIBDIR}/$$i ; \
	done
	${RM} -f ${PKGCONFDIR}/ncurses.pc
	for i in ${INCS} ncurses.h; do \
		${RM} -f ${INCDIR}/$$i; \
	done
	for i in *.3; do \
		${RM} -f ${MANDIR}/man3/$$i; \
	done
	for i in *.5; do \
		${RM} -f ${MANDIR}/man5/$$i; \
	done
	${RM} -f ${MANDIR}/man7/term.7

clean: 
	rm -rf ${GENFILES}
	rm -rf ${OBJS}
	rm -rf ${LIBSO} ${LIBA}

.PHONY: install uninstall
