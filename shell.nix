{ pkgs ? import <nixpkgs> { } }:

let nvim-custom = import ./default.nix { inherit pkgs; };

in pkgs.mkShell {
  packages = [ nvim-custom ];
  buildInputs = [ nvim-custom.buildInputs ];
}
