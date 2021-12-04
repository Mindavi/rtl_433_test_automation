{ lib
, stdenv
, cmake
, pkg-config
, librtlsdr
, python3
, runCommand
, callPackage
}:

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
    binary = callPackage ./test-binary.nix {};
  };
}
