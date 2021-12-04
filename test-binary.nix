{ stdenv
, python3
, rtl_433
}:

let
  rtl_433_tests = <rtl_433_tests>;
in stdenv.mkDerivation {
  name = "rtl_433-binary-tests";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = true;

  checkInputs = [
    rtl_433
    (python3.withPackages (p: [ p.deepdiff ]))
  ];

  checkPhase = ''
    make -C ${rtl_433_tests} test
  '';

  installPhase = ''
    touch $out
  '';
}

