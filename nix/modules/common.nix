{

  pkgs,
  inputs,
  lib,
  ...
}:

{

  # system packages
  environment.systemPackages = with pkgs; [
    nix-index
    devenv
    gnupg1
    dbus
    gnome-keyring
    seahorse
    pavucontrol
    networkmanagerapplet
    libinput
    brightnessctl
    lm_sensors
    libimobiledevice
    usbmuxd
    pinentry-qt
    alsa-utils
    alsa-plugins
    pamixer
    via
    devcontainer
    docker
    qmk
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
  ];

  # fixes command-not-found error
  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # timezone / locale
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # enable gnome keyring
  # without this, we're getting prompted for the wifi password every time
  # we reboot into i3
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

}
