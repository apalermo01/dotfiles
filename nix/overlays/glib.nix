final: prev:

{
  glib = prev.glib.override {
    postInstall =  ''
      export TESTVAR="TEST"
    '';
  };
}
