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
      rev = "66802d375b764355d1f41fa059f70cef97f708b3";
      sha256 = "Mdb/MjL2VckSFN7RpI7eYGl2SMq400lYBPyAwjV+0SE=";
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
