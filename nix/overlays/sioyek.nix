self: super:
let 
  py = super.python313;

in 
{
  sioyek = py.pkgs.buildPythonPackage rec {
    pname = "sioyek";
    format = "pyproject";
    version = "0.31.11";

    src = fetchPypi {
      inherit pname version;
      hash = "";
    };

    doCheck = false;

    pyproject = true;
    build-system = [
      setuptools
      wheel
    ];
  };
}
