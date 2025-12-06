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
      rev = "148dfe2af6b93355a03e478c517236feef9b22aa";
      sha256 = "sha256-vwCboKz2VWk7MXUTxh4xv+B2cPASmZtP/lM0BJLe2x0=";
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
