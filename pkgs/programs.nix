{ pkgs, unstable, ... }:
{
    environment.systemPackages = [
        unstable.zed-editor
        pkgs.aseprite
        pkgs.vscode
        pkgs.alacritty
        pkgs.obsidian
        pkgs.vlc
        pkgs.mullvad-vpn
    ];

    programs.firefox.enable = true;
}
