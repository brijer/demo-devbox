{
  description = "Un simple projet Hello World";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";  // Remplacez par la version de NixOS que vous souhaitez utiliser
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.hello-world = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "hello-world";
      src = ./hello-world.sh;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/hello-world
        chmod +x $out/bin/hello-world
      '';
    };
  };
}
