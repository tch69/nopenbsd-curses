
all: build

SUBDIR = libcurses libform libmenu libpanel \
	 progs tabset termtypes

build install clean uninstall:
	for dir in ${SUBDIR}; do \
		${MAKE} -C $$dir $@; \
	done
