{
  description = "A simple script";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello-world;

    packages.x86_64-linux.hello-world =
      let
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
      in
      pkgs.writeShellScriptBin "hello-world" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '';
  };
}