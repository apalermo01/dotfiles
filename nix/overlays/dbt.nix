final: prev: {
  # Use Python 3.13's dbt-core with pathspec version pinned for dbt-common compatibility
  python313Packages = prev.python313Packages.overrideScope (pyfinal: pyprev: {
    # Override pathspec to use version compatible with dbt-common (<1.1,>=0.9)
    pathspec = pyprev.pathspec.overridePythonAttrs (oldAttrs: rec {
      version = "0.12.1";
      src = prev.fetchPypi {
        pname = "pathspec";
        inherit version;
        hash = "sha256-efkfM8v1kkBruAzhO1OKbXbTPJXENtwN8gbHpgRlJ9g=";
      };
    });
  });

  # Expose dbt from Python 3.13 packages
  dbt = final.python313Packages.dbt-core;
}