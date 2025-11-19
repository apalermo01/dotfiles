{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    python.enable = lib.mkEnableOption "Enables python";
  };

  config = lib.mkIf config.python.enable {
    environment.systemPackages = with pkgs; [
      pyright
    ];
  };
}
