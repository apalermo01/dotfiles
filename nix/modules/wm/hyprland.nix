{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  programs.hyprland.enable = true;
  config = lib.mkIf config.hyprland.enable {
    environment.systemPackages = with pkgs; [
      wofi
      wofi-emoji
      # xss-lock
      # rofi
      # i3
      # feh
      # (polybar.override { pulseSupport = true; })
      # picom
      # i3lock
      # blueman
    ];

    services.xserver = {
      enable = true;
      # windowManager.i3.enable = true;
      # xautolock = {
      #   enable = true;
      #   enableNotifier = true;
      #   notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds'";
      #   locker = "${pkgs.i3lock}/bin/i3lock";
      #   notify = 30;
      #   time = 1;
      # };
    };

    # security.pam.services.i3lock.enable = true;
    # services.displayManager.defaultSession = "none+i3";

    # programs.xss-lock = {
      # enable = true;
      # lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    # };
  };
}
