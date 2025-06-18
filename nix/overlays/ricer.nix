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
      rev = "161859746298d35150698ed9bd6c8ebd5caf674e";
      sha256 = "ymQ9lIWQPz1e0VGaDBShe2TaNj1qzeZOhBZqNOz67x4=";
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
