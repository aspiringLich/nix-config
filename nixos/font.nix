{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    unstable.nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
}
