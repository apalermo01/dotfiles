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
    via
    element-desktop
    ollama
    alpaca
    brightnessctl
    lm_sensors
    # libsForQt5.qtstyleplugin-kvantum
    pywalfox-native
    devcontainer
    docker
    qmk
    keymapviz
    xfce.thunar
  ];

  virtualisation.docker = {
    enable = true;
  };

  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;
  # programs.betterlockscreen.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  services.udev.packages = [ pkgs.via ];
  hardware.keyboard.qmk.enable = true;

  # default KDE environment. Can use as a fallback
  # if something happens to i3 or hyprland
  services.desktopManager.plasma6.enable = false;

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
  # security.pam.services.betterlockscreen = {
  #   enable = true;
  #
  # };

  services.logind = {
    lidSwitch = "lock";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };

  users.users.alex.extraGroups = [ "docker" ];
}
