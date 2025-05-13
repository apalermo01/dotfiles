{

  pkgs,
  inputs,
  lib,
  ...
}:

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
    restic
    gnupg1
    pinentry-qt
    ripgrep
    fuse
    dbus
    libnotify
    dunst
    networkmanagerapplet
    shutter
    any-nix-shell
    pavucontrol
    alsa-utils
    alsa-plugins
    pamixer
    gnome-keyring
    seahorse
    zinit
    lua
    lua-language-server
    luajitPackages.luarocks_bootstrap
    # libsForQt5.xp-pen-deco-01-v2-driver
    # kdePackages.kde-cli-tools
    # libsForQt5.qt5ct
    # libsForQt5.qtstyleplugin-kvantum
    kdePackages.kscreenlocker
    xss-lock
    kdePackages.plasma-workspace
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;

  # https://github.com/mcdonc/.nixconfig/blob/master/videos/pydev/script.rst
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

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

  # enable gnome keyring
  # without this, we're getting prompted for the wifi password every time
  # we reboot into i3
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.i3lock.enable = true;

  # services.xserver.xautolock = {
  #   enable = true;
  #   time = 5;
  #   notifier = "${pkgs.libnotify}/bin/notify-send -u critical -t 5000 'Locking in 30 seconds'";
  #   notify = 30;
  #   locker = "${pkgs.i3lock}/bin/i3lock -c 000000";
  # }
  
  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.i3lock}/bin/i3lock -c 250000";
    extraOptions = [ "--transfer-sleep-lock" ];
  };

  services.xserver.displayManager.sessionCommands = ''
    xset s 600 600
    xset dpms 0 0 900
  '';

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # enable remaps
  # services.xremap = {
  #       enable = true;
  #       serviceMode = "system";
  #       withX11 = true;
  #       config = ./configs/xremap.yml;
  #
  # };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  ### sound
  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;

  # Enable sound with alsa
  # sound.enable = false;

  hardware.pulseaudio.enable = false;
  # hardware.alsa.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # default users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "alex" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
