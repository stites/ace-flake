{
  description = "ace";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        {
          packages.default = pkgs.callPackage ./default.nix { };
          #devShells.default = import ./shell.nix { inherit pkgs; };
        }
      );
}
