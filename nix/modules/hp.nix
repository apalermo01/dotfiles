{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ld.enable = lib.mkEnableOption "enable hp";
  };

  config = lib.mkIf config.hp.enable {
    environment.systemPackages = with pkgs; [
      hplip
    ];

  };
}
