{

  pkgs,
  config,
  lib,
  ...
}:

{

  options = {
    tuigreet.enable = lib.mkEnableOption "tuigreet";
  };

  config = lib.mkIf config.tuigreet.enable {
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
    ];

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd i3";
          user = "greeter";
        };
      };
    };
  };
}
