{
  pkgs,
  ...
}:
{
    services.xserver.enable = false;
  
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "kwin";
    };
    services.desktopManager.plasma6.enable = true;
  
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "alt-intl";
    };
    
    services.autorandr.enable = true;
    
    environment.systemPackages = with pkgs; [
        xorg.xrandr
    ];
}
