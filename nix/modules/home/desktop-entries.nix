{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.desktop-entries;

in
{
  options.modules.desktop-entries = {
    enable = mkEnableOption "desktop-entries";
  };
  config = mkIf cfg.enable {
    xdg.enable = true;
    xdg.mime = {
      enable = true;
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/obsidian" = "obsidian.desktop";
        "text/markdown" = "obsidian.desktop";
      };
    };
    # configure obsidian
    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      exec = "${pkgs.obsidian}/bin/obsidian %u";
      type = "Application";
      terminal = false;
      mimeType = [
        "x-scheme-handler/obsidian"
        "text/markdown"
      ];
    };

  };
}
