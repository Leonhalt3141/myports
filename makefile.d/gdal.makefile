gdal_ver = 1.11.1

gdal-$(gdal_ver).tar.gz:
	wget -q  http://download.osgeo.org/gdal/$(gdal_ver)/$@

gdal.installed: gdal-$(gdal_ver).tar.gz sqlite.installed expat.installed proj4.installed geos.installed openjpeg.installed python.installed libspatialite.installed curl.installed freexl.installed libkml.installed pcre.installed epsilon.installed postgresql.installed libgeotiff.installed tiff.installed libxml2.installed xz.installed hdf4.shared.installed hdf5.installed
	rm -rf $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogr_*.h $(INSTALL_DIR)/include/cpl_*.h $(INSTALL_DIR)/include/gdal*.h $(INSTALL_DIR)/include/ogrsf_frmts.h $(INSTALL_DIR)/lib/libgdal* 
	$(call compile,\
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
	--with-jpeg=internal \
	--with-gif=internal \
	--with-libz=internal \
	--with-png=internal \
	--with-libtiff=$(INSTALL_DIR) \
	--with-geotiff=$(INSTALL_DIR) \
	--with-spatialite=$(INSTALL_DIR) \
	--with-sqlite3=$(INSTALL_DIR) \
	--without-hdf4 \
	--with-hdf5 \
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
	CFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	CXXFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	CPPFLAGS="$(CFLAGS) -I$(INSTALL_DIR)/include/libxml2" \
	LIBS="-lxml2 -lsqlite3 -lspatialite" \
	) && \
	mkdir -p $(INSTALL_DIR)/include/gdal && \
	cd $(INSTALL_DIR)/include/gdal && \
	ls ../gdal*.h | xargs -n 1 ln -sf && \
	ls ../ogr*.h | xargs -n 1 ln -sf && \
	ls ../cpl*.h | xargs -n 1 ln -sf

#$(call compile,$(GDAL_OPT))
# CFLAGS="$(CFLAGS)" CXXFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"

# 