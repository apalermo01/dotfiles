self: super: let
  version = "0.6.1";
  binary = super.fetchurl {
    # url = "https://github.com/supabase-community/postgres-language-server/releases/download/${version}/postgrestools_x86_64-unknown-linux-gnu";
    url = "https://github.com/supabase-community/postgres-language-server/releases/download/${version}/postgrestools_x86_64-unknown-linux-gnu";
    sha256 = "0w350wgvlxn1sv7002i3vy4r4li1bfhsf3zjm2kmjgv0nawflixq";
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
      chmod +x $out/bin/postgrestools
    '';
    meta = with super.lib; {
      description = "Supabase Postgres LSP (pgtools)";
      license = licenses.mit;
    };
  };
}
