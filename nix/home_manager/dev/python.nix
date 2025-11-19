
{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  pythonEnv = pkgs.python313.withPackages (ps: [
    ps.black
    ps.isort
    ps.ipython
    ps.numpy
    ps.pip
  ]);

  cfg = config.modules.python;
in
{
  options.modules.python.enable = mkEnableOption "Enables python";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pythonEnv
      pyright
    ];
  };
}


