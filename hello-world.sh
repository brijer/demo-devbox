{
  description = "Un simple projet Hello World";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  // ou une autre branche ou tag de votre choix

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "hello-world";
      src = ./hello-world.sh;
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/hello-world
        chmod +x $out/bin/hello-world
      '';
    };
  };
}
