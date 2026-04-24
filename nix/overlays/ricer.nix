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
      rev = "3e5b1b683576b5079c5bd776c9cf0c18bfd0b9fd";
      sha256 = "sha256-Qic/kXOmrMbIS6h3HRI3GbFszT9hiAVBdYXK7nylRbk=";
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
