gdal_ver = 1.11.1

gdal-$(gdal_ver).tar.gz:
	wget -q  http://download.osgeo.org/gdal/$(gdal_ver)/$@

gdal.installed: gdal-$(gdal_ver).tar.gz sqlite.installed expat.installed proj4.installed geos.installed openjpeg.installed python.installed libspatialite.installed curl.installed freexl.installed libkml.installed pcre.installed hdf4.shared.installed epsilon.installed postgresql.installed libgeotiff.installed tiff.installed libxml2.installed xz.installed hdf5.installed
	rm -rf $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogr_*.h $(INSTALL_DIR)/include/cpl_*.h $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogrsf_frmts.h $(INSTALL_DIR)/lib/libgdal* 
	tar xaf $< && \
	cd $(basename $(basename $<)) && \
	export CC=gcc && export CXX=g++ && \
	export PKG_CONFIG_PATH=$(INSTALL_DIR)/lib/pkgconfig && \
	./configure -q -C --prefix=$(INSTALL_DIR) \
	--with-pg=$(INSTALL_DIR)/bin/pg_config \
	--with-sqlite3=$(INSTALL_DIR)/lib \
	--with-static-proj4=$(INSTALL_DIR)/lib \
	--with-geos=$(INSTALL_DIR)/bin/geos-config \
	--with-spatialite=$(INSTALL_DIR) \
	--with-python \
	--with-hdf4=$(INSTALL_DIR) \
	--with-expat=$(INSTALL_DIR) \
	--with-openjpeg=$(INSTALL_DIR) \
	--with-liblzma \
	--with-curl=$(INSTALL_DIR)/bin \
	--with-freexl=$(INSTALL_DIR) \
	--with-libkml=$(INSTALL_DIR) \
	--with-xml2=$(INSTALL_DIR)/bin/xml2-config \
	--with-hdf5 \
	--with-hdf4 \
	--with-jpeg=internal \
	--with-gif=internal \
	--with-libz=internal \
	--with-png=internal \
	--with-libtiff=$(INSTALL_DIR) \
	--with-geotiff=$(INSTALL_DIR) \
	--with-spatialite=$(INSTALL_DIR) \
	--with-sqlite3=$(INSTALL_DIR) \
	--without-jasper \
	--without-pcraster \
	--without-pcidsk \
	--without-libgrass \
	--without-epsilon \
	--without-grass \
	--without-ecw \
	--without-netcdf \
	--without-poppler \
	--without-podofo \
	CFLAGS="-I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/include/libxml2" \
	CXXFLAGS="-I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/include/libxml2" \
	CPPFLAGS="-I$(INSTALL_DIR)/include -I$(INSTALL_DIR)/include/libxml2" \
	LDFLAGS=-L$(INSTALL_DIR)/lib \
	LIBS="-lxml2 -lsqlite3 -lspatialite"\
	&& $(MAKE) &&  $(MAKE) install && cd .. && touch $@

#$(call compile,$(GDAL_OPT))
# CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
