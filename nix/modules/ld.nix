{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    ld.enable = lib.mkEnableOption "Enable nix-ld";
  };

  config = lib.mkIf config.ld.enable {
    # https://github.com/mcdonc/.nixconfig/blob/master/videos/pydev/script.rst
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        libX11
        libXext
        libXi
        libXcursor
        libXrandr
        libxcb
        libXinerama
        libXrender
        libGL
        libGLU
        libclang
        # libtinfo
        # libgnt
        # ncurses
      ];
    };

  };
}
