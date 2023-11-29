{
  description = "Un simple projet Hello World";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";  // Choisissez la version de Nixpkgs que vous souhaitez
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      mkPackage = pkgs: pkgs.callPackage ./default.nix {};
    in
    (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        packages.hello-world = mkPackage pkgs;
        defaultPackage = self.packages."${system}".hello-world;
        apps.hello-world = flake-utils.lib.mkApp {
          drv = self.packages."${system}".hello-world;
        };
        apps.default = self.apps."${system}".hello-world;
      })
    ) // {
      overlays.default = final: prev: {
        hello-world = mkPackage final;
      };
    };
}
