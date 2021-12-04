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
  pname = "rtl_433_latest";
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
    binary = callPackage ./test-binary.nix {
      # Circular dependencies? This feels hacky...
      rtl_433_latest = callPackage ./package.nix {};
    };
    false-positive = callPackage ./test-false-positive.nix {
      # Circular dependencies? This feels hacky...
      rtl_433_latest = callPackage ./package.nix {};
    };
  };
}

