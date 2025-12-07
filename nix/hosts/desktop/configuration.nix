{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
  ];

  environment.systemPackages = with pkgs; [
    any-nix-shell
  ];

  i3wm.enable = true;
  tuigreet.enable = false;
  sddm.enable = true;
  kdePlasma.enable = false;
  programs.zsh.enable = true;

  # systemd.user.services.lid-switch-monitor = {
  #   description = "Monitor lid switch for display management";
  #   wantedBy = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     # ExecStart = "${pkgs.acpi}/bin/acpi_listen";
  #     Restart = "always";
  #   };
  #   script = ''
  #     echo "lib-switch-monitor running..."
  #     ${pkgs.acpi}/bin/acpi_listen | while read -r event; do
  #       if echo "$event" | ${pkgs.gnugrep}/bin/grep -q "button/lid"; then
  #         LID_STATE=$(cat /proc/acpi/button/lid/LID/state | ${pkgs.gawk}/bin/awk '{print $2}')
  #         EXTERNAL_MONITOR=$(${pkgs.xorg.xrandr}/bin/xrandr | ${pkgs.gnugrep}/bin/grep " connected" | ${pkgs.gnugrep}/bin/grep -v "eDP" | ${pkgs.gawk}/bin/awk '{print $1}')
  #
  #         if [ "$LID_STATE" = "closed" ] && [ -n "$EXTERNAL_MONITOR" ]; then
  #           ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --off --output $EXTERNAL_MONITOR --auto
  #         else 
  #           ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --auto --output $EXTERNAL_MONITOR --auto
  #         fi
  #       fi
  #     done
  #   '';
  # };

  # services.acpid.enable = true;
  # services.acpid = {
  #   enable = true;
  #   lidEventCommands = ''
  #     export DISPLAY=:0
  #     export PATH=$PATH:/run/current-system/sw/bin
  #     export XAUTHORITY=/var/run/sddm/xauth_edUlZp
  #
  #     LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
  #     EXTERNAL_MONITOR=$(xrandr | grep " connected" | grep -v "eDP" | awk '{print $1}')
  #
  #     if [ "$LID_STATE" = "closed" ] && [ -n "$EXTERNAL_MONITOR" ]; then
  #       xrandr --output eDP-1 --off --output $EXTERNAL_MONITOR --auto
  #     else
  #       xrandr --output $EXTERNAL_MONITOR --auto --left-of eDP-1
  #     fi
  #   '';
  # };
  services.usbmuxd.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "alex" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.hyprland.enable = false;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.nix-ld.enable = true;

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

  services.logind.settings.Login = {
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitch = "ignore";
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
