
all: build

SUBDIR = libcurses libform libmenu libpanel \
	 progs tabset termtypes

build install clean uninstall:
	make -C libcurses $@
	make -C libform $@
	make -C libmenu $@
	make -C libpanel $@
	make -C progs $@
	make -C tabset $@
	make -C termtypes $@
