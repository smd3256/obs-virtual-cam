# Once done these will be defined:
#
#  LIBX264_FOUND
#  LIBX264_INCLUDE_DIRS
#  LIBX264_LIBRARIES
#
# For use in OBS: 
#
#  X264_INCLUDE_DIR

find_package(PkgConfig QUIET)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(_X264 QUIET x264)
endif()

set(_lib_suffix 64)

find_path(X264_INCLUDE_DIR
	NAMES x264.h
	HINTS
		ENV x264Path${_lib_suffix}
		ENV x264Path
		ENV DepsPath${_lib_suffix}
		ENV DepsPath
		${x264Path${_lib_suffix}}
		${x264Path}
		${DepsPath${_lib_suffix}}
		${DepsPath}
		${_X264_INCLUDE_DIRS}
	PATHS
		/usr/include /usr/local/include /opt/local/include /sw/include
	PATH_SUFFIXES
		include)

find_library(X264_LIB
	NAMES ${_X264_LIBRARIES} x264 libx264
	HINTS
		ENV x264Path${_lib_suffix}
		ENV x264Path
		ENV DepsPath${_lib_suffix}
		ENV DepsPath
		${x264Path${_lib_suffix}}
		${x264Path}
		${DepsPath${_lib_suffix}}
		${DepsPath}
		${_X264_LIBRARY_DIRS}
	PATHS
		/usr/lib /usr/local/lib /opt/local/lib /sw/lib
	PATH_SUFFIXES
		lib${_lib_suffix} lib
		libs${_lib_suffix} libs
		bin${_lib_suffix} bin
		../lib${_lib_suffix} ../lib
		../libs${_lib_suffix} ../libs
		../bin${_lib_suffix} ../bin)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Libx264 DEFAULT_MSG X264_LIB X264_INCLUDE_DIR)
mark_as_advanced(X264_INCLUDE_DIR X264_LIB)

if(LIBX264_FOUND)
	set(LIBX264_INCLUDE_DIRS ${X264_INCLUDE_DIR})
	set(LIBX264_LIBRARIES ${X264_LIB})
endif()
