{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.bqls;
  version = "0.4.0";
  raw = pkgs.buildGoModule {
    pname = "bqls";
    version = version;
    src = pkgs.fetchFromGitHub {
      owner = "kitagry";
      repo = "bqls";
      rev = "v${version}";
      hash = "sha256-6BH5xxMSQ+YYZ7mCBXqaF7IaZIOcvs1jL5oYxM0js3k=";
    };
    vendorHash = "sha256-HgKdyYWKkVlDIhKbXF/H6cDaTXAUA6ROAHkuzTLkHoc=";
    # subPackages = [ "." ];
  };

  bqlsPkg = raw.overrideAttrs (old: rec {
        nativeBuildInputs = old.nativeBuildInputs ++ [
            pkgs.clang
            pkgs.pkg-config
            pkgs.icu4c
        ];

        CGO_ENABLED     = "1";
        CXX             = "${pkgs.clang}/bin/clang++";
        CGO_CSSFLAGS    = "-std=c++17 -I${pkgs.icu4c.dev}/include";
        CGO_LDFLAGS     = "-L${pkgs.icu4c.out}/lib -licuuc -licudata";

        NIX_BUILD_CORES = "1";
    });
in
{
  options.modules.bqls = {
    enable = lib.mkEnableOption "BigQuery Language Server (bqls)";
    package = lib.mkOption {
      type = lib.types.package;
      default = bqlsPkg;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
    # programs.go.enable = true;
    #
    # home.activation.installBqls = lib.hm.dag.entryAfter [ "installPackages" ] ''
    #     export GOPATH=${config.xdg.dataHome}/go
    #     if ! command -v bqls >/dev/null; then
    #         echo "Installing bqls@${version}..."
    #         GOPATH=$GOPATH go install github.com/kitagry/bqls@${version}
    #         mkdir -p $HOME/.local/bin
    #         ln -sf $GOPATH/bin/bqls $HOME/.local/bin/bqls
    #     fi
    # '';
    #
    # home.sessionVariables.PATH = "${config.home.homeDirectory}/.local/bin:$PATH";
}
