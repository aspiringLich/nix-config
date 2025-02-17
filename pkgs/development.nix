{ pkgs, unstable, ... }: {
    environment.systemPackages = [
        pkgs.nixd
        pkgs.nil
        pkgs.nixfmt-rfc-style
        
        unstable.cargo
        unstable.rustc
    ];
}