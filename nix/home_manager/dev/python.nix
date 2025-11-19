
{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  python = pkgs.python313.withPackages (ps: [
    ps.black
    ps.isort
    ps.ipython
    ps.pip
  ]);

  cfg = config.modules.python;
in
{
  options.python.enable = mkEnableOption "Enables python";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python
      pyright
    ];
  };
}


