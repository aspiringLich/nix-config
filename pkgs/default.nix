{ pkgs, ... }:
{
  imports = [
    ./development.nix
    ./programs.nix
    ./shell.nix
  ];
  environment.systemPackages = with pkgs; [
    unstable.neofetch
    unstable.vim
    unstable.git
    unstable.sudo
    unstable.lazygit
    unstable.htop
    unstable.kdePackages.yakuake
    unstable.ffmpeg
    unstable.tldr
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mainusr/Documents/nix-config/"; # sets NH_OS_FLAKE variable for you
  };
}
