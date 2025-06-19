self: super:
let
  py = super.python311;

in
{
  ricer = py.pkgs.buildPythonPackage rec {
    pname = "ricer";
    format = "pyproject";
    version = "0.1";

    src = super.fetchFromGitHub {
      owner = "apalermo01";
      repo = "ricer";
      rev = "3d707b2c33e148127ad2c69e1e79c04ea7867bc2";
      sha256 = "i94Rw44nwY0N2PUCZD9+eRmlvDkZBqRY2gCLU5+fpE0=";
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

    postInstall = ''
      mkdir -p $out/share/ricer 
      cp config/ricer*.yml $out/share/ricer
    '';
  };
}
