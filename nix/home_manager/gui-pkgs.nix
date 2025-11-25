{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.gui-packages = {
    enable = lib.mkEnableOption "Enables gui based packages";
  };

  config = lib.mkIf config.modules.gui-packages.enable {
    home.packages = with pkgs; [
      pywalfox-native
      libnotify
      xournalpp
      discord
      firefox
      brave
      zoom-us
      libreoffice-qt6-fresh
      signal-desktop
      flameshot
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.xp-pen-deco-01-v2-driver
      xfce.thunar
      xfce.thunar-volman
      rclone
      openvpn
      restic

      vlc
    ];
  };
}
