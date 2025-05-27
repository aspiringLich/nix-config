{ pkgs, ... }:
{
  imports = [
    ./development.nix
    ./programs.nix
    ./shell.nix
  ];
  environment.systemPackages = with pkgs; [
    unstable.neofetch
    unstable.nh
    unstable.vim
    unstable.git
    unstable.sudo
    unstable.lazygit
    unstable.htop
    unstable.kdePackages.yakuake
  ];
}
