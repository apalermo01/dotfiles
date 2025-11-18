{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.zsh;

in
{

  options.modules.zsh = {
    enable = mkEnableOption "zsh";
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
    };
  };
}
