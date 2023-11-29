{
  description = "A best script!";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        my-name = "hello-world";
        my-buildInputs = with pkgs; [ cowsay ddate ];
        hello-world = (pkgs.writeScriptBin my-name (builtins.readFile ./hello-world.sh)).overrideAttrs(old: {
          buildCommand = "${old.buildCommand}\n patchShebangs $out";
        });
      in rec {
        defaultPackage = packages.hello-world;
        packages.hello-world = pkgs.symlinkJoin {
          name = my-name;
          paths = [ hello-world ] ++ my-buildInputs;
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = "wrapProgram $out/bin/${my-name} --prefix PATH : $out/bin";
        };
      }
    );
}