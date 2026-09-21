{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    rustup
    verilator
    clang-tools
    gnumake
    gcc
    lz4
    zlib
    pkg-config
    git
  ];

  # Verilator's C++ headers live in share/, not include/, so the cc-wrapper does
  # not add them for us.
  VERILATOR_ROOT = "${pkgs.verilator}/share/verilator";
  CPATH = "${pkgs.verilator}/share/verilator/include:${pkgs.verilator}/share/verilator/include/vltstd";

  # clangd reads CPATH too, but obj_dir only exists once verilated and $PWD is not
  # known at evaluation time. Verilate, then point clangd at the generated model.
  shellHook = ''
    export CPATH="$PWD/obj_dir:$CPATH"
    make verilate
  '';
}
