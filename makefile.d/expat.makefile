expat-$(expat_ver).tar.gz:
	wget -q  http://sourceforge.net/projects/expat/files/expat/$(expat_ver)/expat-$(expat_ver).tar.gz
expat.installed: expat-$(expat_ver).tar.gz cmake.installed
	tar xaf $< && \
	cd expat-$(expat_ver) && \
	$(call cmake,\
	-DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) \
	-DCMAKE_C_COMPILER=gcc \
	-DCMAKE_CXX_COMPILER=g++ \
	-DBUILD_shared=ON)
#	$(call compile,--enable-shared)
