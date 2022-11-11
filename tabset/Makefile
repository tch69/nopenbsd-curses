
include ../mk.config

FILES =	std stdcrt vt100 vt300

all clean build:

install:
	${INSTALL} -d ${DATAROOTDIR}/tabset
	${INSTALL} -c -m 444 ${FILES} ${DATAROOTDIR}/tabset

uninstall:
	-cd ${DATAROOTDIR}/tabset; \
		${RM} -f ${FILES}; 
