{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    rustup
    verilator
    gnumake
    gcc
    lz4
    zlib
    pkg-config
    git
  ];

  shellHook = ''
    echo "Verilator: $(verilator --version)"
  '';
}
