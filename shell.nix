{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
	pkgs.gcc
	pkgs.stdenv.cc.cc.lib
	(pkgs.python311Full.withPackages (ps: with ps; [
		pip
		virtualenv
		numpy
		matplotlib
		toml
		pyyaml	
		isort	
		black	
		jinja2
	]))
    ];

    LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/";
}

