{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    unstable.nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
  # https://discourse.nixos.org/t/firefox-doesnt-render-noto-color-emojis/51202
  fonts.fontconfig.useEmbeddedBitmaps = true;
}
