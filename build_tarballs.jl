using BinaryBuilder

# Collection of sources required to build NLopt
sources = [
    "https://github.com/stevengj/nlopt.git" =>
    "bcb27e07767451744d34beddf915418037527d57", # v2.5 alpha
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/nlopt

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DNLOPT_CXX=On -DNLOPT_PYTHON=Off -DNLOPT_OCTAVE=Off -DNLOPT_MATLAB=Off -DNLOPT_GUILE=Off -DNLOPT_SWIG=Off -DNLOPT_LINK_PYTHON=Off ..
make && make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms() # build on all supported platforms

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libnlopt_cxx", :libnlopt),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "NLopt", sources, script, platforms, products, dependencies)

