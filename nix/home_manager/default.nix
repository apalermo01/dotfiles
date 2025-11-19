{
  inputs,
  pkgs,
  config,
  ...
}:

{
  home.stateVersion = "21.03";
  imports = [
    ./headless.nix
    ./ui.nix
    ./home_only.nix
    ./fonts.nix
    ./git.nix
    ./direnv.nix
    ./zoxide.nix
    ./datagrip.nix
    ./xss-lock-i3.nix
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
