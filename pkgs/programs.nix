{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.zed-editor
    aseprite
    unstable.alacritty
    unstable.obsidian
    # unstable.libvlc
    unstable.vlc
    unstable.fluidsynth

    unstable.webcord-vencord
    unstable.rpi-imager
    unstable.typora
    unstable.gparted
    unstable.obs-studio
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
