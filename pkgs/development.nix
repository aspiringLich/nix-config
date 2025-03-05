{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
    cachix

    wineWowPackages.stable
    wineWowPackages.waylandFull

    unstable.rustc
    unstable.cargo
    unstable.rust-analyzer

    unstable.nodejs
    unstable.python3
  ];
  environment.sessionVariables = {
    LIBCLANG_PATH = lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
    LIBRARY_PATH = "${pkgs.lib.getLib pkgs.stdenv.cc.libc}/lib";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  # Create a library path that only applies to unpackaged programs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    alsa-lib
    clang
    glibc
    libclang
    libffi
    libxkbcommon
    mold
    openssl.dev
    pkg-config
    rustup
    stdenv
    vulkan-loader
    wayland
    xorg.libxcb
    zlib
    zstd
    stdenv.cc.cc
  ];
}
