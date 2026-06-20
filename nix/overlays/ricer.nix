self: super:
let
  py = super.python313;

in
{
  ricer = py.pkgs.buildPythonPackage rec {
    pname = "ricer";
    format = "pyproject";
    version = "0.1";

    src = super.fetchFromGitHub {
      owner = "apalermo01";
      repo = "ricer";
      rev = "7a2ffe2cf7d59aa9a3a6d5c34990d7d51be723c1";
      sha256 = "sha256-hKgIute26F/uGGMb/XL3W+ZB8ar+aElMvktGP88/81o=";
    };

    propagatedBuildInputs = with py.pkgs; [
      pydantic
      pyyaml
      jinja2
      matplotlib
      numpy
      toml
    ];

    nativeBuildInputs = with py.pkgs; [
      setuptools
      wheel
    ];

    doCheck = false;

    # postInstall = ''
    #   mkdir -p $out/share/ricer 
    #   cp default_cfg_files/ricer*.yml $out/share/ricer
    # '';
  };
}
