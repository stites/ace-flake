stdenv.mkDerivation rec {
  name = "ace-${version}";
  version = "3.0";
  src = requireFile rec {
    name = "ace_v3.0_linux86.tar.gz";
    sha256 = "62ed2985177f2bd4c702c6f7db48a5926c69580a1facea2ca2b943ab9a4a731c";
    message = "Download and run $ nix-store --add-fixed sha256 ~/Downloads/${name}.tar.gz";
  };

  nativeBuildInputs = [ openjdk8 ];

  buildPhase = ''
    mkdir -p $out/bin
    cp -r $src $out/bin
  '';
}
