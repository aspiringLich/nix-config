{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    unstable.nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];

  i18n = {
    # defaultLocale = "en_US.UTF-8";
    # supportedLocales = [ "en_US.UTF-8" "zh_CN.UTF-8" ];
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        # plasma6Support = true;
        addons = with pkgs; [
          # fcitx5-gtk
          fcitx5-chinese-addons
          fcitx5-mozc
          fcitx5-rime
          rime-data
          fcitx5-pinyin-zhwiki
        ];
      };
    };
  };
  environment.sessionVariables = {
      QT_IM_MODULE = "fcitx";
      QT4_IM_MODULE = "fcitx";
      GTK_IM_MODULE = "fcitx";
  };
}
