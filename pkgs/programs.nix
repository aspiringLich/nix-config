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
  programs.wireshark.enable = true;

  # https://nixos.wiki/wiki/Mullvad_VPN
  services.resolved.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.unstable.mullvad-vpn;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
  };

  # https://wiki.nixos.org/wiki/Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode.enable = true; # add `gamemoderun %command%` to game launch properties
}
