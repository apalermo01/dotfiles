{
  inputs,
  pkgs,
  config,
  ...
}:

{
  home.stateVersion = "21.03";
  imports = [
    ./dev
    ./desktop
    ./packages.nix



    ./fonts.nix
    ./git.nix
    ./dbt.nix
    ./direnv.nix
    ./zoxide.nix
    ./datagrip.nix
    ./desktop-entries.nix
    ./obs.nix
    ./discord.nix
    ./vlc.nix
    ./pandoc.nix
    ./cursor.nix
    ./freetube.nix
    ./zsh.nix
  ];

}
