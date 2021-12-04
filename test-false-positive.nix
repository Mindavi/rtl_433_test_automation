{ stdenv
, python3
, rtl_433
, tree
, bash
, jq
}:

let
  rtl_433_tests = <rtl_433_tests>;
in stdenv.mkDerivation {
  name = "rtl_433-false-positive-tests";

  #dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = true;

  src = rtl_433_tests;

  buildInputs = [
    bash
  ];
  nativeBuildInputs = [
    bash
  ];

  postPatch = ''
    patchShebangs test_false_positives/run_test.sh
  '';

  checkInputs = [
    rtl_433
    (python3.withPackages (p: [ p.deepdiff ]))
    jq
  ];

  checkPhase = ''
    #BUILD_DIR=${rtl_433}/bin
    cd test_false_positives && make run_test BUILD_DIR=${rtl_433}/bin
  '';

  installPhase = ''
    touch $out
  '';
}

