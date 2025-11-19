{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.modules.freetube;

in
{

  options.modules.freetube = {
    enable = mkEnableOption "freetube";
  };
  config = mkIf cfg.enable {
    programs.freetube = {
      enable = true;
    };
    xdg.desktopEntries = {
      freetube = {
        name = "freetube";
        # comment = "Open Source YouTube app for privacy";
        exec = "sh -c \"bash \\$HOME/Scripts/freetube.sh %U\"";
        terminal = false;
        type = "Application";
        # icon = "freetube";
        # startupWMClass = "FreeTube";
        mimeType = [ "x-scheme-handler/freetube" ];
        categories = [ "Network" ];
        noDisplay = false;
      };

    };
  };

}
