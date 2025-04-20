{ config, pkgs, inputs, ... }:

{
  
  # system packages
  environment.systemPackages = with pkgs; [
    neovim
    nodejs
    unzip
    nix-index
    git
    wget
    gcc
    cargo
    btop
    ncdu
    rclone
    postgresql
    devenv
    gnumake
    killall
    fortune
    cowsay
    pywal
    dunst
    rclone
    restic
    gnupg1
    pinentry-curses
    ripgrep
  ];
  
  programs.fish.enable = true;
  # programs.dunst.enable = true;

  # https://github.com/mcdonc/.nixconfig/blob/master/videos/pydev/script.rst
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = "curses";
    enableSSHSupport = true;
  };

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.initrd.luks.devices."luks-b465c8ed-5151-4e2e-b18c-fab741b2f46f".device = "/dev/disk/by-uuid/b465c8ed-5151-4e2e-b18c-fab741b2f46f";

  # networking
  networking.networkmanager.enable = true;

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

  # x-server. Can disable if only using wayland
  services.xserver = {
        enable = true;
        displayManager = {
            defaultSession = "none+i3";
        };
        windowManager.i3.enable = true;
    };

  # default KDE environment. Can use as a fallback 
  # if something happens to i3 or hyprland
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # default users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
