{ pkgs, ... }:
{
  imports = [
    ./development.nix
    ./font.nix
    ./programs.nix
    ./shell.nix
  ];
  environment.systemPackages = with pkgs; [
    neofetch
    nh
    vim
    git
    sudo
    lazygit
    htop

    kdePackages.yakuake
  ];
}
