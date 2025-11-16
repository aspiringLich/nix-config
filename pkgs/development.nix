{ pkgs, lib, ... }:
{
  # /bin/bash works now yay
  services.envfs.enable = true;
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
    cachix

    # wineWowPackages.stable
    # wineWowPackages.waylandFull

    unstable.rustc
    unstable.cargo
    unstable.rust-analyzer

    unstable.nodejs
    unstable.pnpm

    unstable.python312
    unstable.python312Packages.ipykernel
    unstable.python312Packages.python-lsp-server
    unstable.pyright

    unstable.avrdude
    unstable.arduino-ide

    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    llvmPackages_latest.clang-tools
    cmake
    gnumake

  ];
  users.extraGroups.dialout.members = [ "mainusr" ];
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
    glib
    libclang
    libffi
    libxkbcommon
    mold
    unstable.openssl
    pkg-config
    rustup
    stdenv
    vulkan-loader
    wayland
    xorg.libxcb
    zlib
    zstd
    stdenv.cc.cc
    libplist
    libGL
    fontconfig
    xwayland
    icu

    xorg.libXext
    xorg.libXtst
    xorg.libX11
    xorg.libXrender
    xorg.libXi
    xorg.libXft
    ncurses5
  ];

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
  };
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "mainusr" ];
}
