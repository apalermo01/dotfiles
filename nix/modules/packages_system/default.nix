{ config, pkgs, inputs, ... }:

{
  # system-wide programs
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    gcc
    btop
    ncdu
    rclone
    postgresql
  ];

}
