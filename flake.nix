{
  description = "Un simple projet Hello World";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.hello-world = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "hello-world";
      src = ./hello-world.sh;  // Assurez-vous que ce script est dans le même dossier que flake.nix
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/hello-world
        chmod +x $out/bin/hello-world
      '';
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello-world;
  };
}
