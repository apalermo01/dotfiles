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
        "text/html" = "firefox.desktop";
        "application/pdf" = "okularApplication_pdf.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
