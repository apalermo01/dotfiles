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


### Set up ssh key
#### Generate key

```bash 

ssh-keygen -t ed25519 -C "email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/<key name>

```

#### Add to github

```bash
cat ~/.ssh/<key name>.pub
```
Copy the output of ^^
Settings -> access -> New SSH Key -> enter title

#### Add to identity file

in `~/.ssh/config`:

```
Host github.com
  Hostname github.com
  IdentityFile ~/.ssh/<key name>
```

Run bootstrap script
```
bash <(curl -L https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/nix-bootstrap.sh)
```


**TODO**
- don't run wal when migrating a theme to dotfiles
