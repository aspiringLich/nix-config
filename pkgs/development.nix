{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
    cachix

    unstable.rustup
  ];
  environment.variables = {
    LIBCLANG_PATH = lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  };

  # Create a library path that only applies to unpackaged programs
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    glibc
    alsa-lib
    libxkbcommon
    wayland
    xorg.libxcb
    vulkan-loader
    clang
  ];
}
