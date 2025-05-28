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
    # kdePackages.plasma-workspace
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
  # services.displayManager.defaultSession = "plasmax11";
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+i3";


  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.pam.services.i3lock.enable = true;
  

  
  services.logind = {
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };
}
