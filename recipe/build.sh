mkdir build
cd ./build

if [[ "${target_platform}" == linux-* ]]; then
	cmake .. -LAH -G "Ninja" \
	-Wno-dev \
	-DCMAKE_BUILD_TYPE:STRING="Release" \
	-DUSE_SYSTEM_VTK:BOOL=ON \
	-DUSE_SYSTEM_ITK:BOOL=ON \
	-DVMTK_BUILD_TESTING:BOOL=ON \
	-DSUPERBUILD_INSTALL_PREFIX:STRING=${PREFIX} \
	-DPython3_FIND_STRATEGY=LOCATION \
	-DPython3_ROOT_DIR=${PREFIX} \
	-DPython3_EXECUTABLE=${PREFIX}/bin/python \
	-DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
	-DCMAKE_CXX_STANDARD=11 \
	-DCMAKE_CXX_STANDARD_REQUIRED=ON \
	-DCMAKE_CXX_EXTENSIONS=OFF \
	-DVMTK_MODULE_INSTALL_LIB_DIR:STRING="${PREFIX}/vmtk" \
	-DINSTALL_PKGCONFIG_DIR:STRING="${PREFIX}/lib/pkgconfig" \
	-DGIT_PROTOCOL_HTTPS:BOOL=ON \
	-DVMTK_USE_RENDERING:BOOL=ON \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DVMTK_MINIMAL_INSTALL:BOOL=OFF \
	-DVMTK_USE_VTK9:BOOL:BOOL=ON \
	-DVMTK_CONTRIB_SCRIPTS:BOOL=ON \
	-DVTK_VMTK_CONTRIB:BOOL=ON \
	-DVMTK_SCRIPTS_ENABLED:BOOL=ON \
	-DVMTK_ENABLE_DISTRIBUTION:BOOL=OFF \
	-DVMTK_WITH_LIBRARY_VERSION:BOOL=OFF \
	-DVMTK_USE_SUPERBUILD:BOOL=OFF \
	-DVTK_VMTK_WRAP_PYTHON:BOOL=ON \
	-DVMTK_PYTHON_VERSION:STRING="python${PY_VER}" \
	-DITK_LEGACY_SILENT:BOOL=ON \
	-DVTK_LEGACY_SILENT:BOOL=ON \
	-DCMAKE_CXX_STANDARD=11 \
	-DCMAKE_CXX_STANDARD_REQUIRED=ON \
	-DVMTK_TEST_DATA_SOURCE="in-place" \
	-DBUILD_DOCUMENTATION:BOOL=OFF 
fi

if [[ "${target_platform}" == osx-* ]]; then
	cmake .. -LAH -G "Ninja" \
	-Wno-dev \
	-DCMAKE_BUILD_TYPE:STRING="Release" \
	-DUSE_SYSTEM_VTK:BOOL=ON \
	-DUSE_SYSTEM_ITK:BOOL=ON \
	-DVMTK_BUILD_TESTING:BOOL=ON \
	-DPython3_FIND_STRATEGY=LOCATION \
	-DPython3_ROOT_DIR=${PREFIX} \
	-DPython3_EXECUTABLE=${PREFIX}/bin/python \
	-DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
	-DCMAKE_CXX_STANDARD=11 \
	-DCMAKE_CXX_STANDARD_REQUIRED=ON \
	-DCMAKE_CXX_EXTENSIONS=OFF \
	-DVMTK_MODULE_INSTALL_LIB_DIR:STRING="${PREFIX}/vmtk" \
	-DINSTALL_PKGCONFIG_DIR:STRING="${PREFIX}/lib/pkgconfig" \
	-DVMTK_USE_RENDERING:BOOL=ON \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DVMTK_MINIMAL_INSTALL:BOOL=OFF \
	-DVMTK_USE_VTK9:BOOL:BOOL=ON \
	-DVMTK_CONTRIB_SCRIPTS:BOOL=ON \
	-DVMTK_SCRIPTS_ENABLED:BOOL=ON \
	-DVMTK_ENABLE_DISTRIBUTION:BOOL=OFF \
	-DVMTK_WITH_LIBRARY_VERSION:BOOL=OFF \
	-DVMTK_USE_SUPERBUILD:BOOL=OFF \
	-DVTK_VMTK_WRAP_PYTHON:BOOL=ON \
	-DVMTK_PYTHON_VERSION:STRING="python${PY_VER}" \
	-DITK_LEGACY_SILENT:BOOL=ON \
	-DVTK_LEGACY_SILENT:BOOL=ON \
	-DCMAKE_CXX_STANDARD=11 \
	-DCMAKE_CXX_STANDARD_REQUIRED=ON \
	-DVMTK_TEST_DATA_SOURCE="in-place" \
    -DCMAKE_OSX_SYSROOT:PATH=${CONDA_BUILD_SYSROOT} \
	-DVTK_VMTK_USE_COCOA:BOOL=OFF \
    -DVMTK_RENDERING_BACKEND:STRING="OpenGL2" \
	-DVMTK_BREW_PYTHON:BOOL=OFF \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="10.9" \
	-DBUILD_DOCUMENTATION:BOOL=OFF \
	-DVTK_VMTK_CONTRIB:BOOL=ON \
	-DCMAKE_MACOSX_RPATH:BOOL=ON
fi
ninja install

cat > $SP_DIR/vmtk-$PKG_VERSION.egg-info <<FAKE_EGG
Metadata-Version: 2.1
Name: vmtk
Version: $PKG_VERSION
Summary: vmtk is a collection of libraries and tools for 3D reconstruction, geometric analysis, mesh generation and surface data analysis for image-based modeling of blood vessels. 
Platform: UNKNOWN
FAKE_EGG
