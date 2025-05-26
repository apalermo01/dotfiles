{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
    options.modules.xdg = { enable = mkEnableOption "xdg"; };
    config = mkIf cfg.enable {
      # configure obsidian
      programs.xdg.desktopEntries.obisidan = {
        exec = "executable %u";
        name = "/etc/profiles/per-user/alex/bin/obsidian %u";
        type = "application";
        mimeType = ["ASCII text"];
      };

  };
}
