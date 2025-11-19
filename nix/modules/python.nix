{
  pkgs,
  lib,
  config,
  ...
}:

let 

  python = pkgs.python313.withPackages (ps: [
    ps.black
    ps.isort
    ps.ipython
    ps.pip
  ]);
in
{
  options = {
    python.enable = lib.mkEnableOption "Enables python";
  };

  config = lib.mkIf config.python.enable {
    environment.systemPackages = with pkgs; [
      pyright
      python
    ];
  };
}
