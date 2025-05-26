{
  inputs,
  pkgs,
  config,
  ...
}:

{
  home.stateVersion = "21.03";
  imports = [
    ./packages/headless.nix
    ./packages/ui.nix
    ./packages/home_only.nix
    ./git.nix
    ./direnv.nix
    ./zoxide.nix
    ./datagrip.nix
    # ./xautolock-i3.nix
    ./xss-lock-i3.nix
    ./desktop-entries.nix
  ];

}
