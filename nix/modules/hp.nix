{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hp.enable = lib.mkEnableOption "enable hp";
  };

  config = lib.mkIf config.hp.enable {
    environment.systemPackages = with pkgs; [
      hplip
    ];

  };
}
