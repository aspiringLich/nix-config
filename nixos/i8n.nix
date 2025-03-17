{ pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
    # supportedLocales = [ "en_US.UTF-8" "zh_CN.UTF-8/UTF-8" ];
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
