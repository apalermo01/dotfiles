{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.services.xss-lock-i3;

  saverTimeout = cfg.notify;
  saverCycle = cfg.time * 60 - cfg.notify;

  xssWrapper = pkgs.writeShellScriptBin "xss-lock-i3" ''
    ${pkgs.xorg.xset}/bin/xset s ${toString saverTimeout} ${toString saverCycle}

    exec ${pkgs.xss-lock}/bin/xss-lock \
      --notifier '${cfg.notifierCmd}' \
      --transfer-sleep-lock \
      -- ${cfg.lockerCmd}
  '';
in
{
  options.services.xss-lock-i3 = {
    enable = mkEnableOption "xss-lock for i3 sessions";
    time = mkOption {
      type = types.int;
      default = 1;
      description = "Minutes of idle before lock";
    };
    notify = mkOption {
      type = types.int;
      default = 30;
      description = "Seconds before lock when notifier runs";
    };
    lockerCmd = mkOption {
      type = types.str;
      default = "${pkgs.i3lock}/bin/i3lock -c 250000";
    };
    notifierCmd = mkOption {
      type = types.str;
      default = "${pkgs.libnotify}/bin/notify-send -u critical 'Locking in 30 seconds'";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ xssWrapper ];

    systemd.user.services.xss-lock-i3 = {
      Unit.PartOf = [ "graphical-session.target" ];
      Unit.description = "xss-lock for i3";
      Service = {
        ExecStart = "${xssWrapper}/bin/xss-lock-i3";
        Restart = "on-failure";
      };

      Install.WantedBy = ["graphical-session.target"];
    };
  };

}
