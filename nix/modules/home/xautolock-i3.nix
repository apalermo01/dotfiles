{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.xautolock-i3;

  xautolockScript = pkgs.writeShellScriptBin "xautolock-i3" ''
    exec ${pkgs.xautolock}/bin/xautolock \
      -time ${toString cfg.time} \
      -locker "${cfg.lockerCmd}" \
      -notify ${toString cfg.notify} \
      -notifier "${cfg.notifierCmd}"
  '';

in
{
  options.services.xautolock-i3 = {
    enable = mkEnableOption "xautolock for i3 sessions";
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
    home.packages = [ xautolockScript ];

    systemd.user.services.xautolock-i3 = {
      Unit = {
        Description = "xautolock (i3)";
        PartOf = [ "graphical-session.target" ];

      };
      Service = {
        ExecStart = "${xautolockScript}/bin/xautolock-i3";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
