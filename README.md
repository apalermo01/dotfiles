# Dotfiles repo


## NixOs Setup

**System-wide packages**
Defined in nix/modules/system/configuration.nix

**Home manager packages that are not configured by home manager**
nix/modules/home/packages/headless.nix for terminal utilities & applications

nix/modules/home/packages/ui.nix for UI applications


**Home manager packages that are also configured by home manager**
add module file to nix/modules/home/modulename.nix and add the import
to nix/modules/home/default.nix

Enable the package in nix/hosts/hostname/user.nix

**TODO**
- don't run wal when migrating a theme to dotfiles
