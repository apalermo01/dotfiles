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
    # configure obsidian
    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      exec = "/etc/profiles/per-user/alex/bin/obsidian %u";
      type = "Application";
      mimeType = [
        "x-scheme-handler/obsidian"
        "text/markdown"
      ];
    };

  };
}
