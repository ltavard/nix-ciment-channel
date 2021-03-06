{ stdenv, fetchurl, bash, python }:

stdenv.mkDerivation rec {

    version = "0.2.2";
    name = "charliecloud-${version}";
    bats_version = "0.4.0";

   srcs = 
      [ (fetchurl {
           url = "https://github.com/hpc/charliecloud/archive/v${version}.tar.gz";
           sha256 = "0djq3j6q7zj4ignf1b87k64bg4h5aw8l0mxnshagsaskwvmhakpi";
         })
        (fetchurl {
           url = "https://github.com/sstephenson/bats/archive/v${bats_version}.tar.gz";
           sha256 = "1myqq56kzwqc7p3inxiv2wgc06kfy3rjf980s5wfw7k8y5j8s3a8";
         })
      ];

    patches = [ ./CONDUCT.md_not_present_into_bats_release.patch ];

    buildInputs = [ bash python ];

    sourceRoot = "${name}";

    preBuild = ''
      patchShebangs test/make-auto     
      cp VERSION VERSION.full
      export PREFIX=$out
      cp -a ../bats-${bats_version}/* test/bats.src/
    '';

 

}
