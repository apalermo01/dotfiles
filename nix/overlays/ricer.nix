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
      rev = "d08dfe33e46de606912091bc4b88977d9640f6bc";
      sha256 = "joUtCYE0PuAHPAZAb82cMmtC7sihjLs/DHTQ+T96lFk=";
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
