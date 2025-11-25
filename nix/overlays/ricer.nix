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
      rev = "1a644958c44527bb9d451689e1d4d18219a3c23b";
      sha256 = "sha256-MJ6f5QHdSJwl9dFWFnvbDeSxoCL9ZqOwc0AIutAu2oA=";
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
