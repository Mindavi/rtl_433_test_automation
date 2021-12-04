{ lib
, stdenv
, cmake
, pkg-config
, librtlsdr
, python3
, runCommand
}:

let
  rtl_433_tests = <rtl_433_tests>;
in
stdenv.mkDerivation {
  pname = "rtl_433";
  version = "unstable";

  src = <rtl433>;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    librtlsdr
  ];

  doCheck = true;

  passthru.tests = {
    binary = runCommand "rtl-433-binary-tests" {} ''
      make -C ${rtl_433_tests} test 
    '';
    falsepositives = runCommand "rtl-433-false-positives-tests" {} ''
      make -C ${rtl_433_tests}/test_false_positives
    '';
  };

  checkInputs = [
    (python3.withPackages (p: [ p.deepdiff ]))
  ];

  checkPhase = ''
    runHook preCheck

    make -C ${rtl_433_tests} test

    runHook postCheck
  '';
}
