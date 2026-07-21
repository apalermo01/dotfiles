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
        libxcb-util
        libxcb-cursor
        libXinerama
        libXrender
        libGL
        libGLU
        libclang
        libspiro
        freetype
        curlWithGnuTls
        glibmm
        glib
        libsigcxx
        fftwFloat
        libsndfile
        lilv
        alsa-lib
        fontconfig

        # libtinfo
        # libgnt
        # ncurses
      ];
    };

  };
}
