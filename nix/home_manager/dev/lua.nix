{
  pkgs,
  lib,
  config,
  ...
}:

with lib;
let 
  cfg = config.modules.lua;
in
{
  options.modules.lua.enable = mkEnableOption "Enables Lua";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lua
      lua-language-server
      stylua
    ];
  };
}
