{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.modules.musescore = {
    enable = lib.mkEnableOption "Enables musescore";
  };

  config = lib.mkIf config.modules.musescore.enable {
    home.packages = with pkgs; [
      musescore
    ];
  };
}
