let
    pkgs = import <nixpkgs> {};
in pkgs.mkShell {
    packages = [
        (pkgs.python3.withPackages (ps: with ps; [ virtualenv ]))
    ];
}

