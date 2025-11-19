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
        xorg.libX11
        xorg.libXext
        xorg.libXi
        xorg.libXcursor
        xorg.libXrandr
        xorg.libxcb
        xorg.libXinerama
        xorg.libXrender
        libGL
        libGLU
        # libtinfo
        # libgnt
        # ncurses
      ];
    };

  };
}
