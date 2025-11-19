{

  pkgs,
  inputs,
  lib,
  ...
}:

{

  # system packages
  environment.systemPackages = with pkgs; [
    tree
    nix-index
    devenv
    gnupg1
    dbus
    any-nix-shell
    gnome-keyring
    seahorse

    # zinit

    # cli utilities
    # file
    # pandoc
    # unzip
    # xsel
    # fnm

    # programming languages
    # lua
    # go

    # gui
    pavucontrol
    # pywalfox-native
    # xfce.thunar
    # xfce.thunar-volman
    # kdePackages.dolphin
    # libreoffice-qt6-fresh
    networkmanagerapplet
    kdePackages.okular
    kdePackages.qtsvg
    kdePackages.plasma-workspace

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
    keymapviz
    cargo
    rclone
    restic


    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang

  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # fixes command-not-found error
  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
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
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
