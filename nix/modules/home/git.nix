# https://www.youtube.com/watch?v=G3NJzFX6XhY
{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.git;

in
{
  options.modules.git = {
    enable = mkEnableOption "git";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Alex";
      userEmail = "alex.palermo.ai@gmail.com";
      includes = [
        { path = "~/.gitconfig_work"; }
      ];
      extraConfig = {
        delta = {
          navigate = true;
        };
        init = {
          defaultBranch = "main";
        };
        core = {
          editor = "nvim";
          pager = "delta";
        };
        diff = {
          context = 3;
          renames = "copies";
          interHunkContext = 10;
        };
        color = {
          diff = {
            meta = "yellow bold";
            frag = "magenta";
            context = "white";
            whitespace = "yellow reverse";
            old = "red";
            commit = "yellow bold";
          };
          decorate = {
            HEAD = "red";
            branch = "blue";
            tag = "yellow";
            remoteBranch = "magenta";
          };
        };
        interactive = {
          diffFilter = "delta --color-only";
          singlekey = true;
        };
        push = {
          autoSetupRemote = true;
          default = "current";
          # followTags = true;
        };
        pull = {
          default = "current";
        };
        log = {
          abbrevCommit = true;
          graphColors = "blue,yellow,cyan,magenta,green,red";
        };
      };
    };
  };
}
