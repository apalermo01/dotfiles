{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.desktop-entries;

in {
    options.modules.desktop-entries = { enable = mkEnableOption "desktop-entries"; };
    config = mkIf cfg.enable {
      # configure obsidian
      xdg.desktopEntries.obisidan = {
        exec = "executable %u";
        name = "/etc/profiles/per-user/alex/bin/obsidian %u";
        type = "Application";
        mimeType = ["ASCII text"];
      };

  };
}
