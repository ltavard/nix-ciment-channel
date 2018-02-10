{stdenv, lib, fetchurl, gfortran, blas, openmpi, liblapack}:

stdenv.mkDerivation rec {
  version = "2.0.2";
  name = "scalapack";
  
  src = fetchurl {
    url = "http://www.netlib.org/scalapack/${name}.tgz";
    sha256 = "0p1r61ss1fq0bs8ynnx7xq4wwsdvs32ljvwjnx6yxr8gd6pawx0c";
  };
  
  buildInputs = [ gfortran blas openmpi liblapack ];
  BLAS_LIB = "-L${blas}/lib -lblas";
  LAPACK_LIB = "-L${liblapack}/lib -llapack";
  
  preBuild = "
    cp SLmake.inc.example SLmake.inc
    sed -i -e 's:-lblas:-L${blas}/lib -lblas:' SLmake.inc
    sed -i -e 's:-llapack:-L${liblapack}/lib -llapack:' SLmake.inc
  "; 
  installPhase = ''
    mkdir $out/lib
    cp libscalapack.a $out/lib/'';
  meta = {
    homepage = "http://www.netlib.org/scalapack/";
    description = "ScaLAPACK is the parallel version of LAPACK";    
    longDescription = " ";
    maintainers = [ stdenv.lib.maintainers.ltavard ];
    platforms = stdenv.lib.platforms.unix;
  };
}
