{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unbroken.zed-editor
    aseprite
    vscode
    alacritty
    obsidian
    vlc
    mullvad-vpn
  ];

  programs.firefox.enable = true;
}
