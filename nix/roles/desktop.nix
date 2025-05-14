{ lib, pkgs, ... }:

# System configuration for desktop setup
{
  environment.systemPackages = with pkgs; [

    pinentry-qt
    libnotify
    dunst
    pavucontrol
    alsa-utils
    alsa-plugins
    pamixer
    kdePackages.kscreenlocker
    xss-lock
    kdePackages.plasma-workspace
    via
  ];

  programs.kdeconnect.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  services.udev.packages = [ pkgs.via ];
  hardware.keyboard.qmk.enable = true;

  # default KDE environment. Can use as a fallback
  # if something happens to i3 or hyprland
  services.desktopManager.plasma6.enable = true;

  # x-server. Can disable if only using wayland
  # services.displayManager.defaultSession = "none+i3";
  services.displayManager.defaultSession = "plasmax11";
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.sddm.enable = true;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock}/bin/i3lock -c 250000";
    extraOptions = [ "--transfer-sleep-lock" ];
  };

  services.xserver.displayManager.sessionCommands = ''
    # xset s 600 600
    xset s 60 60
    xset dpms 0 0 900
  '';

  security.pam.services.i3lock.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

}
