{
  description = "A simple script";

  outputs = { self, nixpkgs }: {
    # Définition du package pour aarch64-linux
    defaultPackage.aarch64-apple-darwin = self.packages.aarch64-apple-darwin.hello-world;

    # Définition du package pour x86_64-linux
    packages.x86_64-linux.hello-world =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.writeShellScriptBin "hello-world" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '';

    # Ajouter ici la définition pour aarch64-darwin
    packages.aarch64-apple-darwin.hello-world =
      let
        pkgs = nixpkgs.legacyPackages.aarch64-apple-darwin;
      in
      pkgs.writeShellScriptBin "hello-world" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '';
  };
}
