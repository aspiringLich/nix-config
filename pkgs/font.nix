{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains-mono
    unstable.nerd-fonts.jetbrains-mono
  ];
}
