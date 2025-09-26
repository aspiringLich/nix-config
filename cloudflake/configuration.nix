# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ./server.nix
    ./pkgs.nix
  ];

  # boot.supportedFilesystems = [ "ntfs" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cloudflake"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  security.sudo.enable = true;

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTH0aVohUiTAQ+c54MgP4CQboKPMpCEbgVAqsOraz18 48413902+aspiringLich@users.noreply.github.com"
  ];

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];
  
  system.stateVersion = "25.11";
}
