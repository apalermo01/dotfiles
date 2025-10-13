final: prev:
let
  py = prev.python313;
in
{
  python313 = prev.python313.override {
    packageOverrides = python-final: python-prev: {
      sioyek = python-prev.buildPythonPackage rec {
        pname = "sioyek";
        version = "0.31.11";
        format = "pyproject";

        src = prev.fetchPypi {
          inherit pname version;
          sha256 = "sha256-KzrwK21CU80rT2Stns3Iuly2+83w6MXPUdTLkqu9S+M=";
        };

        nativeBuildInputs = with python-prev; [
          hatchling
        ];

        propagatedBuildInputs = with python-prev; [
          requests
          appdirs
          numpy
          pymupdf
          pyperclip
          pyqt5
          python-slugify
          regex
        ];
        dontCheckRuntimeDeps = true;
        doCheck = false;

        pythonImportsCheck = [ "sioyek" ];

        meta = with prev.lib; {
          description = "Python tools and extensions for Sioyek PDF reader";
          homepage = "https://pypi.org/project/sioyek/";
          license = licenses.gpl3Plus;
          maintainers = [ ];
        };
      };
    };
  };
  # prev.pkgs.python313.withPackages = {
  #   sioyek = py.pkgs.buildPythonPackage rec {
  #     pname = "sioyek";
  #     version = "0.31.11";
  #     format = "pyproject";
  #
  #     src = prev.fetchPypi {
  #       inherit pname version;
  #       sha256 = "";
  #
  #     };
  #     doCheck = false;
  #   };
  # };
}
