# Configuration for desktop setup
{ lib, pkgs, ... }:

let
  stable = import (builtins.fetchTarball {
    name = "nix-stable";
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz";
    sha256 = "1915r28xc4znrh2vf4rrjnxldw2imysz819gzhk9qlrkqanmfsxd";
  }) { system = "x86_64-linux"; };
in
{
  environment.systemPackages = with pkgs; [

    # gui
    pavucontrol
    pywalfox-native
    xfce.thunar
    xfce.thunar-volman
    kdePackages.dolphin
    libreoffice-qt6-fresh
    networkmanagerapplet
    kdePackages.okular
    kdePackages.plasma-workspace
    tor-browser
    anytype
    standardnotes
    signal-desktop

    pinentry-qt
    libnotify
    dunst
    alsa-utils
    alsa-plugins
    pamixer
    xss-lock
    via
    alpaca
    brightnessctl
    lm_sensors
    devcontainer
    docker
    qmk
    keymapviz
    libimobiledevice
    usbmuxd
    ifuse
    jellyfin-ffmpeg
    newsboat
    networkmanagerapplet
    openvpn
    puddletag
    id3v2
    cargo
    rclone
    fortune
    cowsay
    pywal
    restic
    tmux
    neovim
    sioyek
    stow

    # cli utils
    fzf
    yazi
    cbonsai
    fastfetch
    bat
    eza
    gitui
    delta
    man-pages
    man-pages-posix
    oh-my-posh
    tealdeer
    starship
    lsof
    postgresql
    sqitchPg
    deno
    nest-cli

    # language servers
    pyright
    nil
    lua-language-server
    markdown-oxide
    sqls
    postgrestools
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    clang-tools
    clang

    # formatters
    stylua
    nixfmt-rfc-style
    shfmt
    mdformat
    yamlfix
    pgformatter
  ];

  services.usbmuxd.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "alex" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;

  # networking
  networking = {
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
    ];
  };

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

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitch = "lock";
  };
  # services.logind = {
  #   lidSwitch = "lock";
  #   lidSwitchExternalPower = "lock";
  #   lidSwitchDocked = "ignore";
  # };

  environment.etc."xdg/menus/plasma-applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  security.rtkit.enable = true;

  # fonts
  # fonts.packages = with pkgs; [
    # nerd-fonts.fira-code
    # nerd-fonts.jetbrains-mono
    # nerd-fonts.iosevka
  # ];

  # users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"

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
}
