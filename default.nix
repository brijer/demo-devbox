with import <nixpkgs> {};

derivation {
  name = "hello-world";
  builder = "${bash}/bin/bash";
  version = "1.0";
  system = builtins.currentSystem;
  src = /Users/j.brisson/Documents/betclicGit/demo/demo-devbox/hello-world.sh;


  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/hello-world
    chmod +x $out/bin/hello-world
  '';
}
