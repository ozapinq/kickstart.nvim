{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "nvim-env";

  srcs = ./.;

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  
  buildInputs = [
    pkgs.neovim
    pkgs.which
    pkgs.git
    pkgs.ripgrep
    pkgs.fd
    pkgs.lazygit
    pkgs.python311
    pkgs.niv
    pkgs.neovim
    pkgs.lua
    pkgs.luaformatter
    pkgs.black
    pkgs.nixfmt
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/nvim
    cp -r lua/ init.lua lazy-lock.json .stylua.toml $out/share/nvim/
    makeWrapper ${pkgs.neovim}/bin/nvim $out/bin/nvim \
      --add-flags "--clean -u $out/share/nvim/init.lua"
  '';

  buildPhase = installPhase;
}

