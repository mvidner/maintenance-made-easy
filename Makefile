BINDIR=$$HOME/bin
SCRIPTS=mme-all mme-env mme-getpac mme-makepac mme-chroot mme-getvcs
help:
	@echo usage: make install
install-links:
	PWD=`pwd` ;\
	for i in ${SCRIPTS}; do \
	    ln -sf  -v -t ${DEST} $$PWD/$$i ;\
	done
install:
	install -v -t ${DEST} ${SCRIPTS}
