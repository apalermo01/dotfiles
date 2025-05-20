self: super: let
  version = "0.6.1";
  binary = super.fetchurl {
    url = "https://github.com/supabase-community/postgres-language-server/releases/download/${version}/postgrestools_aarch64-unknown-linux-gnu";
    sha256 = "1pg8xc6vb1hg9qg6yiqqs19dks3w7qbmmkkxavxy8f21rw2395hr";
  };

in {
  postgrestools = super.stdenv.mkDerivation {
    pname = "postgrestools";
    inherit version;
    src = binary;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/postgrestools
    '';
    meta = with super.lib; {
      description = "Supabase Postgres LSP (pgtools)";
      license = licenses.mit;
    };
  };
}
