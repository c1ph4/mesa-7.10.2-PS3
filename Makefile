# Top-level Mesa makefile

TOP = .

SUBDIRS = src


default: $(TOP)/configs/current
	@for dir in $(SUBDIRS) ; do \
		if [ -d $$dir ] ; then \
			(cd $$dir && $(MAKE)) || exit 1 ; \
		fi \
	done

all: default


doxygen:
	cd doxygen && $(MAKE)

clean:
	-@touch $(TOP)/configs/current
	-@for dir in $(SUBDIRS) ; do \
		if [ -d $$dir ] ; then \
			(cd $$dir && $(MAKE) clean) ; \
		fi \
	done
	-@test -s $(TOP)/configs/current || rm -f $(TOP)/configs/current


realclean: clean
	-rm -rf lib*
	-rm -f $(TOP)/configs/current
	-rm -f $(TOP)/configs/autoconf
	-rm -rf autom4te.cache
	-find . '(' -name '*.o' -o -name '*.a' -o -name '*.so' -o \
	  -name depend -o -name depend.bak ')' -exec rm -f '{}' ';'


distclean: realclean


install:
	@for dir in $(SUBDIRS) ; do \
		if [ -d $$dir ] ; then \
			(cd $$dir && $(MAKE) install) || exit 1 ; \
		fi \
	done


.PHONY: default doxygen clean realclean distclean install

# If there's no current configuration file
$(TOP)/configs/current:
	@echo
	@echo
	@echo "Please choose a configuration from the following list:"
	@ls -1 $(TOP)/configs | grep -v "current\|default\|CVS\|autoconf.*"
	@echo
	@echo "Then type 'make <config>' (ex: 'make linux-x86')"
	@echo
	@echo "Or, run './configure' then 'make'"
	@echo "See './configure --help' for details"
	@echo
	@echo "(ignore the following error message)"
	@exit 1


# Rules to set/install a specific build configuration
aix \
aix-64 \
aix-64-static \
aix-gcc \
aix-static \
autoconf \
bluegene-osmesa \
bluegene-xlc-osmesa \
beos \
catamount-osmesa-pgi \
darwin \
darwin-fat-32bit \
darwin-fat-all \
freebsd \
freebsd-dri \
freebsd-dri-amd64 \
freebsd-dri-x86 \
hpux10 \
hpux10-gcc \
hpux10-static \
hpux11-32 \
hpux11-32-static \
hpux11-32-static-nothreads \
hpux11-64 \
hpux11-64-static \
hpux11-ia64 \
hpux11-ia64-static \
hpux9 \
hpux9-gcc \
irix6-64 \
irix6-64-static \
irix6-n32 \
irix6-n32-static \
irix6-o32 \
irix6-o32-static \
linux \
linux-i965 \
linux-alpha \
linux-alpha-static \
linux-cell \
linux-cell-debug \
linux-debug \
linux-dri \
linux-dri-debug \
linux-dri-x86 \
linux-dri-x86-64 \
linux-dri-ppc \
linux-dri-xcb \
linux-egl \
linux-indirect \
linux-fbdev \
linux-ia64-icc \
linux-ia64-icc-static \
linux-icc \
linux-icc-static \
linux-llvm \
linux-llvm-debug \
linux-opengl-es \
linux-osmesa \
linux-osmesa-static \
linux-osmesa16 \
linux-osmesa16-static \
linux-osmesa32 \
linux-ppc \
linux-ppc-static \
linux-profile \
linux-sparc \
linux-sparc5 \
linux-static \
linux-ultrasparc \
linux-tcc \
linux-x86 \
linux-x86-debug \
linux-x86-32 \
linux-x86-64 \
linux-x86-64-debug \
linux-x86-64-profile \
linux-x86-64-static \
linux-x86-profile \
linux-x86-static \
netbsd \
openbsd \
osf1 \
osf1-static \
ps3-osmesa \
psl1ght-rsx \
solaris-x86 \
solaris-x86-gcc \
solaris-x86-gcc-static \
sunos4 \
sunos4-gcc \
sunos4-static \
sunos5 \
sunos5-gcc \
sunos5-64-gcc \
sunos5-smp \
sunos5-v8 \
sunos5-v8-static \
sunos5-v9 \
sunos5-v9-static \
sunos5-v9-cc-g++ \
ultrix-gcc:
	@ if test -f configs/current -o -L configs/current; then \
		if ! cmp configs/$@ configs/current > /dev/null; then \
			echo "Please run 'make realclean' before changing configs" ; \
			exit 1 ; \
		fi ; \
	else \
		cd configs && rm -f current && ln -s $@ current ; \
	fi
	$(MAKE) default


# Rules for making release tarballs

VERSION=7.10.2
DIRECTORY = Mesa-$(VERSION)
LIB_NAME = MesaLib-$(VERSION)
GLUT_NAME = MesaGLUT-$(VERSION)

# This is part of MAIN_FILES
MAIN_ES_FILES = \
	$(DIRECTORY)/src/mesa/main/*.xml				\
	$(DIRECTORY)/src/mesa/main/*.py					\
	$(DIRECTORY)/src/mesa/main/*.dtd

MAIN_FILES = \
	$(DIRECTORY)/Makefile*						\
	$(DIRECTORY)/configure						\
	$(DIRECTORY)/configure.ac					\
	$(DIRECTORY)/acinclude.m4					\
	$(DIRECTORY)/aclocal.m4						\
	$(DIRECTORY)/bin/config.guess					\
	$(DIRECTORY)/bin/config.sub					\
	$(DIRECTORY)/bin/install-sh					\
	$(DIRECTORY)/bin/mklib						\
	$(DIRECTORY)/bin/minstall					\
	$(DIRECTORY)/bin/version.mk					\
	$(DIRECTORY)/configs/[a-z]*					\
	$(DIRECTORY)/docs/*.html					\
	$(DIRECTORY)/docs/COPYING					\
	$(DIRECTORY)/docs/README.*					\
	$(DIRECTORY)/docs/RELNOTES*					\
	$(DIRECTORY)/docs/*.spec					\
	$(DIRECTORY)/include/GL/gl.h					\
	$(DIRECTORY)/include/GL/glext.h					\
	$(DIRECTORY)/include/GL/gl_mangle.h				\
	$(DIRECTORY)/include/GL/glu.h					\
	$(DIRECTORY)/include/GL/glu_mangle.h				\
	$(DIRECTORY)/include/GL/glx.h					\
	$(DIRECTORY)/include/GL/glxext.h				\
	$(DIRECTORY)/include/GL/glx_mangle.h				\
	$(DIRECTORY)/include/GL/glfbdev.h				\
	$(DIRECTORY)/include/GL/mesa_wgl.h				\
	$(DIRECTORY)/include/GL/osmesa.h				\
	$(DIRECTORY)/include/GL/vms_x_fix.h				\
	$(DIRECTORY)/include/GL/wglext.h				\
	$(DIRECTORY)/include/GL/wmesa.h					\
	$(DIRECTORY)/src/glsl/Makefile					\
	$(DIRECTORY)/src/glsl/Makefile.template				\
	$(DIRECTORY)/src/glsl/SConscript				\
	$(DIRECTORY)/src/glsl/*.[ch]					\
	$(DIRECTORY)/src/glsl/*.[cly]pp					\
	$(DIRECTORY)/src/glsl/README					\
	$(DIRECTORY)/src/glsl/glcpp/*.[chly]				\
	$(DIRECTORY)/src/glsl/glcpp/README				\
	$(DIRECTORY)/src/Makefile					\
	$(DIRECTORY)/src/mesa/Makefile*					\
	$(DIRECTORY)/src/mesa/sources.mak				\
	$(DIRECTORY)/src/mesa/descrip.mms				\
	$(DIRECTORY)/src/mesa/gl.pc.in					\
	$(DIRECTORY)/src/mesa/osmesa.pc.in				\
	$(DIRECTORY)/src/mesa/depend					\
	$(MAIN_ES_FILES)						\
	$(DIRECTORY)/src/mesa/main/*.[chS]				\
	$(DIRECTORY)/src/mesa/main/descrip.mms				\
	$(DIRECTORY)/src/mesa/math/*.[ch]				\
	$(DIRECTORY)/src/mesa/math/descrip.mms				\
	$(DIRECTORY)/src/mesa/program/*.[chly]				\
	$(DIRECTORY)/src/mesa/program/*.cpp				\
	$(DIRECTORY)/src/mesa/program/Makefile				\
	$(DIRECTORY)/src/mesa/program/descrip.mms			\
	$(DIRECTORY)/src/mesa/swrast/*.[ch]				\
	$(DIRECTORY)/src/mesa/swrast/descrip.mms			\
	$(DIRECTORY)/src/mesa/swrast_setup/*.[ch]			\
	$(DIRECTORY)/src/mesa/swrast_setup/descrip.mms			\
	$(DIRECTORY)/src/mesa/vbo/*.[chS]				\
	$(DIRECTORY)/src/mesa/vbo/descrip.mms				\
	$(DIRECTORY)/src/mesa/tnl/*.[chS]				\
	$(DIRECTORY)/src/mesa/tnl/descrip.mms				\
	$(DIRECTORY)/src/mesa/tnl_dd/*.[ch]				\
	$(DIRECTORY)/src/mesa/tnl_dd/imm/*.[ch]				\
	$(DIRECTORY)/src/mesa/tnl_dd/imm/NOTES.imm			\
	$(DIRECTORY)/src/mesa/drivers/Makefile				\
	$(DIRECTORY)/src/mesa/drivers/beos/*.cpp			\
	$(DIRECTORY)/src/mesa/drivers/beos/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/common/*.[ch]			\
	$(DIRECTORY)/src/mesa/drivers/common/descrip.mms		\
	$(DIRECTORY)/src/mesa/drivers/fbdev/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/fbdev/glfbdev.c			\
	$(DIRECTORY)/src/mesa/drivers/osmesa/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/osmesa/Makefile.win		\
	$(DIRECTORY)/src/mesa/drivers/osmesa/descrip.mms		\
	$(DIRECTORY)/src/mesa/drivers/osmesa/osmesa.def			\
	$(DIRECTORY)/src/mesa/drivers/osmesa/*.[ch]			\
	$(DIRECTORY)/src/mesa/drivers/windows/*/*.[ch]			\
	$(DIRECTORY)/src/mesa/drivers/windows/*/*.def			\
	$(DIRECTORY)/src/mesa/drivers/x11/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/x11/descrip.mms			\
	$(DIRECTORY)/src/mesa/drivers/x11/*.[ch]			\
	$(DIRECTORY)/src/mesa/ppc/*.[ch]				\
	$(DIRECTORY)/src/mesa/sparc/*.[chS]				\
	$(DIRECTORY)/src/mesa/x86/Makefile				\
	$(DIRECTORY)/src/mesa/x86/*.[ch]				\
	$(DIRECTORY)/src/mesa/x86/*.S					\
	$(DIRECTORY)/src/mesa/x86/rtasm/*.[ch]				\
	$(DIRECTORY)/src/mesa/x86-64/*.[chS]				\
	$(DIRECTORY)/src/mesa/x86-64/Makefile				\
	$(DIRECTORY)/windows/VC8/

MAPI_FILES = \
	$(DIRECTORY)/include/GLES/*.h					\
	$(DIRECTORY)/include/GLES2/*.h					\
	$(DIRECTORY)/include/VG/*.h					\
	$(DIRECTORY)/src/mapi/es?api/Makefile				\
	$(DIRECTORY)/src/mapi/es?api/*.pc.in				\
	$(DIRECTORY)/src/mapi/glapi/gen/Makefile			\
	$(DIRECTORY)/src/mapi/glapi/gen/*.xml				\
	$(DIRECTORY)/src/mapi/glapi/gen/*.py				\
	$(DIRECTORY)/src/mapi/glapi/gen/*.dtd				\
	$(DIRECTORY)/src/mapi/glapi/gen-es/Makefile			\
	$(DIRECTORY)/src/mapi/glapi/gen-es/*.xml			\
	$(DIRECTORY)/src/mapi/glapi/gen-es/*.py				\
	$(DIRECTORY)/src/mapi/glapi/Makefile				\
	$(DIRECTORY)/src/mapi/glapi/SConscript				\
	$(DIRECTORY)/src/mapi/glapi/sources.mak				\
	$(DIRECTORY)/src/mapi/glapi/*.[chS]				\
	$(DIRECTORY)/src/mapi/mapi/mapi_abi.py				\
	$(DIRECTORY)/src/mapi/mapi/sources.mak				\
	$(DIRECTORY)/src/mapi/mapi/*.[ch]				\
	$(DIRECTORY)/src/mapi/vgapi/Makefile				\
	$(DIRECTORY)/src/mapi/vgapi/vgapi.csv				\
	$(DIRECTORY)/src/mapi/vgapi/vg.pc.in

EGL_FILES = \
	$(DIRECTORY)/include/KHR/*.h					\
	$(DIRECTORY)/include/EGL/*.h					\
	$(DIRECTORY)/src/egl/Makefile					\
	$(DIRECTORY)/src/egl/*/Makefile					\
	$(DIRECTORY)/src/egl/*/Makefile.template			\
	$(DIRECTORY)/src/egl/*/*.[ch]					\
	$(DIRECTORY)/src/egl/*/*/Makefile				\
	$(DIRECTORY)/src/egl/*/*/*.[ch]					\
	$(DIRECTORY)/src/egl/main/*.pc.in				\
	$(DIRECTORY)/src/egl/main/*.def

GALLIUM_FILES = \
	$(DIRECTORY)/src/mesa/state_tracker/*[ch]			\
	$(DIRECTORY)/src/gallium/Makefile				\
	$(DIRECTORY)/src/gallium/Makefile.template			\
	$(DIRECTORY)/src/gallium/SConscript				\
	$(DIRECTORY)/src/gallium/targets/Makefile.dri			\
	$(DIRECTORY)/src/gallium/targets/Makefile.xorg			\
	$(DIRECTORY)/src/gallium/targets/SConscript.dri			\
	$(DIRECTORY)/src/gallium/*/Makefile				\
	$(DIRECTORY)/src/gallium/*/SConscript				\
	$(DIRECTORY)/src/gallium/*/*/Makefile				\
	$(DIRECTORY)/src/gallium/*/*/SConscript				\
	$(DIRECTORY)/src/gallium/*/*/*.[ch]				\
	$(DIRECTORY)/src/gallium/auxiliary/gallivm/*.cpp		\
	$(DIRECTORY)/src/gallium/*/*/*.py				\
	$(DIRECTORY)/src/gallium/*/*/*.csv				\
	$(DIRECTORY)/src/gallium/*/*/*/Makefile				\
	$(DIRECTORY)/src/gallium/*/*/*/SConscript			\
	$(DIRECTORY)/src/gallium/*/*/*/*.[ch]				\
	$(DIRECTORY)/src/gallium/*/*/*/*.py


DRI_FILES = \
	$(DIRECTORY)/include/GL/internal/dri_interface.h		\
	$(DIRECTORY)/include/GL/internal/sarea.h			\
	$(DIRECTORY)/src/glx/Makefile					\
	$(DIRECTORY)/src/glx/*.[ch]					\
	$(DIRECTORY)/src/mesa/drivers/dri/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/dri/Makefile.template		\
	$(DIRECTORY)/src/mesa/drivers/dri/dri.pc.in			\
	$(DIRECTORY)/src/mesa/drivers/dri/common/xmlpool/*.po		\
	$(DIRECTORY)/src/mesa/drivers/dri/*/*.[chS]			\
	$(DIRECTORY)/src/mesa/drivers/dri/*/*.cpp			\
	$(DIRECTORY)/src/mesa/drivers/dri/*/*/*.[chS]			\
	$(DIRECTORY)/src/mesa/drivers/dri/*/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/dri/*/*/Makefile			\
	$(DIRECTORY)/src/mesa/drivers/dri/*/Doxyfile

SGI_GLU_FILES = \
	$(DIRECTORY)/src/glu/Makefile					\
	$(DIRECTORY)/src/glu/glu.pc.in					\
	$(DIRECTORY)/src/glu/sgi/Makefile				\
	$(DIRECTORY)/src/glu/sgi/Makefile.mgw				\
	$(DIRECTORY)/src/glu/sgi/Makefile.win				\
	$(DIRECTORY)/src/glu/sgi/glu.def				\
	$(DIRECTORY)/src/glu/sgi/dummy.cc				\
	$(DIRECTORY)/src/glu/sgi/glu.exports				\
	$(DIRECTORY)/src/glu/sgi/glu.exports.darwin			\
	$(DIRECTORY)/src/glu/sgi/mesaglu.opt				\
	$(DIRECTORY)/src/glu/sgi/include/gluos.h			\
	$(DIRECTORY)/src/glu/sgi/libnurbs/interface/*.h			\
	$(DIRECTORY)/src/glu/sgi/libnurbs/interface/*.cc		\
	$(DIRECTORY)/src/glu/sgi/libnurbs/internals/*.h			\
	$(DIRECTORY)/src/glu/sgi/libnurbs/internals/*.cc		\
	$(DIRECTORY)/src/glu/sgi/libnurbs/nurbtess/*.h			\
	$(DIRECTORY)/src/glu/sgi/libnurbs/nurbtess/*.cc			\
	$(DIRECTORY)/src/glu/sgi/libtess/README				\
	$(DIRECTORY)/src/glu/sgi/libtess/alg-outline			\
	$(DIRECTORY)/src/glu/sgi/libtess/*.[ch]				\
	$(DIRECTORY)/src/glu/sgi/libutil/*.[ch]

GLW_FILES = \
	$(DIRECTORY)/src/glw/*.[ch]			\
	$(DIRECTORY)/src/glw/Makefile*			\
	$(DIRECTORY)/src/glw/README			\
	$(DIRECTORY)/src/glw/glw.pc.in			\
	$(DIRECTORY)/src/glw/depend

GLUT_FILES = \
	$(DIRECTORY)/include/GL/glut.h			\
	$(DIRECTORY)/include/GL/glutf90.h		\
	$(DIRECTORY)/src/glut/glx/Makefile*		\
	$(DIRECTORY)/src/glut/glx/depend		\
	$(DIRECTORY)/src/glut/glx/glut.pc.in		\
	$(DIRECTORY)/src/glut/glx/*def			\
	$(DIRECTORY)/src/glut/glx/*.[ch]		\
	$(DIRECTORY)/src/glut/beos/*.[ch]		\
	$(DIRECTORY)/src/glut/beos/*.cpp		\
	$(DIRECTORY)/src/glut/beos/Makefile

DEPEND_FILES = \
	$(TOP)/src/mesa/depend		\
	$(TOP)/src/glx/depend		\
	$(TOP)/src/glw/depend		\
	$(TOP)/src/glut/glx/depend	\
	$(TOP)/src/glu/sgi/depend


LIB_FILES = \
	$(MAIN_FILES)		\
	$(MAPI_FILES)		\
	$(ES_FILES)		\
	$(EGL_FILES)		\
	$(GALLIUM_FILES)	\
	$(DRI_FILES)		\
	$(SGI_GLU_FILES)	\
	$(GLW_FILES)


# Everything for new a Mesa release:
tarballs: rm_depend configure aclocal.m4 lib_gz glut_gz \
	lib_bz2 glut_bz2 lib_zip glut_zip md5


# Helper for autoconf builds
ACLOCAL = aclocal
ACLOCAL_FLAGS =
AUTOCONF = autoconf
AC_FLAGS =
aclocal.m4: configure.ac acinclude.m4
	$(ACLOCAL) $(ACLOCAL_FLAGS)
configure: configure.ac aclocal.m4 acinclude.m4
	$(AUTOCONF) $(AC_FLAGS)

rm_depend:
	@for dep in $(DEPEND_FILES) ; do \
		rm -f $$dep ; \
		touch $$dep ; \
	done

rm_config:
	rm -f configs/current
	rm -f configs/autoconf

lib_gz: rm_config
	cd .. ; \
	tar -cf $(LIB_NAME).tar $(LIB_FILES) ; \
	gzip $(LIB_NAME).tar ; \
	mv $(LIB_NAME).tar.gz $(DIRECTORY)

glut_gz:
	cd .. ; \
	tar -cf $(GLUT_NAME).tar $(GLUT_FILES) ; \
	gzip $(GLUT_NAME).tar ; \
	mv $(GLUT_NAME).tar.gz $(DIRECTORY)

lib_bz2: rm_config
	cd .. ; \
	tar -cf $(LIB_NAME).tar $(LIB_FILES) ; \
	bzip2 $(LIB_NAME).tar ; \
	mv $(LIB_NAME).tar.bz2 $(DIRECTORY)

glut_bz2:
	cd .. ; \
	tar -cf $(GLUT_NAME).tar $(GLUT_FILES) ; \
	bzip2 $(GLUT_NAME).tar ; \
	mv $(GLUT_NAME).tar.bz2 $(DIRECTORY)

lib_zip: rm_config
	rm -f $(LIB_NAME).zip ; \
	cd .. ; \
	zip -qr $(LIB_NAME).zip $(LIB_FILES) ; \
	mv $(LIB_NAME).zip $(DIRECTORY)

glut_zip:
	rm -f $(GLUT_NAME).zip ; \
	cd .. ; \
	zip -qr $(GLUT_NAME).zip $(GLUT_FILES) ; \
	mv $(GLUT_NAME).zip $(DIRECTORY)

md5:
	@-md5sum $(LIB_NAME).tar.gz
	@-md5sum $(LIB_NAME).tar.bz2
	@-md5sum $(LIB_NAME).zip
	@-md5sum $(GLUT_NAME).tar.gz
	@-md5sum $(GLUT_NAME).tar.bz2
	@-md5sum $(GLUT_NAME).zip

.PHONY: tarballs rm_depend rm_config md5 \
	lib_gz glut_gz \
	lib_bz2 glut_bz2 \
	lib_zip glut_zip
