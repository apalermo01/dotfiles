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
      rev = "568403beb40ccc5e23c642be194d46ced2136093";
      sha256 = "sha256-RFynfm8MHEX1qbAisNUglRqurRij4rpPGlE/jdNXHPQ=";
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
