{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];


  # python.enable = true;
  ricer.enable = true;

  # modules.sddmMonitorLayout.enable = true;
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


  services.desktopManager.plasma6.enable = false;
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

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "lock";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitch = "lock";
  };

  environment.etc."xdg/menus/plasma-applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services.power-profiles-daemon.enable = false;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  security.rtkit.enable = true;

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
