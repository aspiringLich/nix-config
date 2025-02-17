{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style
    cachix

    unstable.cargo
    unstable.rustc
  ];
}
