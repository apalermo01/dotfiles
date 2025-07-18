{

  pkgs,
  inputs,
  lib,
  ...
}:

# This is the configuration that is common for ALL systems. More platform
# specific setups are in ./nix/roles
{

  # system packages
  environment.systemPackages = with pkgs; [
    tree
    neovim
    nodejs
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
    ripgrep
    fuse
    dbus
    networkmanagerapplet
    shutter
    any-nix-shell
    gnome-keyring
    seahorse
    zinit
    lua-language-server
    luajitPackages.luarocks_bootstrap
    libreoffice-qt6-fresh

    # cli utilities
    file
    pandoc
    unzip
    xsel
    wikiman 
    ctags
    # programming languages
    lua
    go

    evtest
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # https://github.com/mcdonc/.nixconfig/blob/master/videos/pydev/script.rst
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      xorg.libX11
      xorg.libXext
      xorg.libXi
      xorg.libXcursor
      xorg.libXrandr
      xorg.libxcb
      xorg.libXinerama
      xorg.libXrender
      libGL
      libGLU
    ];
  };

  # fixes command-not-found error
  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  environment.etc."xdg/menus/plasma-applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

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

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  ### sound
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.pulseaudio.enable = false;
  services.blueman.enable = true;

  security.rtkit.enable = true;

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
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
