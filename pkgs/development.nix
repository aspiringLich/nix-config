{ pkgs, lib, ... }:
{
  # /bin/bash works now yay
  services.envfs.enable = true;
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
    cachix
    unstable.nix-output-monitor

    # wineWowPackages.stable
    # wineWowPackages.waylandFull

    unstable.rustc
    unstable.cargo
    unstable.rust-analyzer

    unstable.nodejs
    unstable.pnpm

    unstable.python3
    unstable.python3Packages.ipykernel
    unstable.python3Packages.python-lsp-server
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

    unstable.claude-code
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
    mold
    unstable.openssl
    pkg-config
    rustup
    stdenv
    vulkan-loader
    wayland
    zlib
    zstd
    stdenv.cc.cc
    libplist
    libGL
    fontconfig
    xwayland
    icu
    libz
    ncurses5

    libxcursor
    libxkbcommon
    libxrandr
    libxxf86vm
    xorg.libxcb
    xorg.libXext
    xorg.libXtst
    xorg.libX11
    xorg.libXrender
    xorg.libXi
    xorg.libXft
    xorg.xrandr
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

  services.udev.extraRules = ''
      # UNO R4 https://github.com/arduino/ArduinoCore-renesas/blob/main/post_install.sh
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", MODE:="0666"

      # Udev rules for Raspberry Pi Pico in BOOTSEL mode (mass storage device)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"

      # Udev rules for Raspberry Pi Pico as a serial port (e.g., for MicroPython REPL or C/C++ debugging)
      SUBSYSTEM=="tty", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", MODE="0666"

      # Optional: Rules for the official Raspberry Pi Debug Probe (Vendor/Product IDs may differ for other probes)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0666"
  '';
}
