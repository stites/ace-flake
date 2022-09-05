{ stdenv, requireFile, openjdk8, gnutar, mxM ? "4000M" }:

stdenv.mkDerivation rec {
  name = "ace-${version}";
  version = "3.0";
  src = requireFile rec {
    name = "ace_v3.0_linux86.tar.gz";
    sha256 = "62ed2985177f2bd4c702c6f7db48a5926c69580a1facea2ca2b943ab9a4a731c";
    message = "Download and run $ nix-store --add-fixed sha256 ~/Downloads/${name}.tar.gz";
  };

  buildInputs = [ gnutar openjdk8 ];
  #buildInputs = [ tar ];

  #unpackPhase = "tar $out";
  buildPhase = let
    mkSubstitution = bin: ''substituteInPlace ${bin} \
        --replace java ${openjdk8}/bin/java \
        --replace '`dirname $0`' $out/share \
        --replace Xmx1512m Xmx${mxM}'';
  in ''
    mkdir -p $out/bin
    mkdir -p $out/share
    ${mkSubstitution "compile"}
    ${mkSubstitution "evaluate"}
    ${mkSubstitution "preprocess_noisy"}
    ${mkSubstitution "uai08_pe"}
    ${mkSubstitution "uai08_marginals"}
    ${mkSubstitution "uai08_convert"}
  '';
  installPhase = let
    installBin = bin: "mv $out/share/${bin} $out/bin";
  in ''
    cp -r . $out/share
    ${installBin "compile"}
    ${installBin "evaluate"}
    ${installBin "preprocess_noisy"}
    ${installBin "uai08_pe"}
    ${installBin "uai08_marginals"}
    ${installBin "uai08_convert"}
  '';
}
