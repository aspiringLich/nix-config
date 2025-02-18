{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unbroken.zed-editor
    aseprite
    unstable.vscode
    unstable.alacritty
    unstable.obsidian
    unstable.vlc
    unstable.webcord-vencord
  ];

  # https://nixos.wiki/wiki/Mullvad_VPN
  services.resolved.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.unstable.mullvad-vpn;
  };

  programs.firefox.enable = true;
}
