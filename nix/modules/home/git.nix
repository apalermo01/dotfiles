# https://www.youtube.com/watch?v=G3NJzFX6XhY
{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = "Alex";
            userEmail = "alex.palermo.ai@gmail.com";
            includes = [
                { path = "~/.gitconfig_work"; }
            ];
            extraConfig = {
                init = { defaultBranch = "main"; };
                core = {
                    editor = "nvim"; 
                };
                diff = {
                    context = 3;
                    renames = "copies";
                    interHunkContext = 10;
                };
                pager = {
                    diff = "diff-so-fancy | $PAGER";
                    branch = false;
                    tag = false;
                };
                "diff-so-fancy" = {
                    markEmptyLines = false;
                };
                color = {
                    diff = {
                        meta        = "black bold";
                        frag        = "magenta";
                        context     = "white";
                        whitespace  = "yellow reverse";
                        old         = "red";
                    };
                    decorate = {
                        HEAD            = "red";
                        branch          = "blue";
                        tag             = "yellow";
                        remoteBranch    = "magenta";
                    };
                };
                interactive = {
                    diffFilter = "diff-so-fancy --patch";
                    singlekey = true;
                };
                push = {
                    autoSetupRemote = true;
                    default = "current";
                    # followTags = true;
                };
                pull = {
                    default = "current";
                };
                log = {
                    abbrevCommit = true;
                    graphColors = "blue,yellow,cyan,magenta,green,red";
                };
            };
        };
    };
}
