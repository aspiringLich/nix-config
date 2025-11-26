{ pkgs, config, ... }:
let
  secrets = config.sops.secrets;
in
{
  environment.systemPackages = with pkgs; [
    unstable.zed-editor-fhs
    unstable.jetbrains.idea-community-bin
    unstable.jetbrains.rider
    unstable.alacritty

    unstable.obsidian
    unstable.vlc
    unstable.fluidsynth
    unstable.rpi-imager
    unstable.vesktop
    unstable.obs-studio
    unstable.qbittorrent
    unstable.ungoogled-chromium
    unstable.gparted

    aseprite
    unstable.audacity
    unstable.typora
    unstable.inkscape
    unstable.ardour
    unstable.spotify

    kdePackages.qtwayland
    kdePackages.kdialog
    kdePackages.korganizer
    kdePackages.kdepim-addons
    (unstable.prismlauncher.override {
      jdks = [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-bin-23
      ];
    })
    unstable.protonup-qt
    unstable.ckan

    unstable.quartus-prime-lite
    unstable.omnissa-horizon-client
    unstable.dbeaver-bin

    unstable.openfortivpn
  ];
  # environment.etc = {
  #   "openfortivpn/config" = {
  #     text = ''
  #       host = vpn2.case.edu
  #       port = 443
  #       username = $(cat ${secrets."openfortivpn-case/user".path})
  #       password = $(cat ${secrets."openfortivpn-case/pass".path})
  #     '';
  #   };
  # };

  services.mpd.fluidsynth.enable = true;
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
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true; # add `gamemoderun %command%` to game launch properties
}
