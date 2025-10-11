# Configuration for home server

{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
  ];
  virtualisation.docker = {
    enable = true;
  };

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkManager"
      "docker"
    ];
    shell = pkgs.zsh;
  };
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "alex-server" ];
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
