{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unbroken.zed-editor
    aseprite
    unstable.alacritty
    unstable.obsidian
    unstable.vlc
    unstable.webcord-vencord
    unstable.rpi-imager
    unstable.typora
  ];

  # https://nixos.wiki/wiki/Mullvad_VPN
  services.resolved.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.unstable.mullvad-vpn;
  };

  programs.firefox.enable = true;
  programs.wireshark.enable = true;
}
