 { pkgs, ... }:

{

  env.LOCALE_ARCHIVE="$(nix profile list --json | jq -r '.elements.glibcLocales.storePaths[]')/lib/locale/locale-archive";
  env.LANG = "en_NZ.UTF-8";
  env.LANGUAGE = "en_NZ.UTF-8";
  env.LC_ALL = "en_NZ.UTF-8";

  dotenv = {
    enable = true;
    filename = [".env-phoenix-dev" ".env-phoenix-test" ];
  };

  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.nodejs_20 pkgs.postgresql pkgs.inotify-tools pkgs.glibcLocales ];

  enterTest = ''
    echo "Ensuring LC_ALL is set to en_NZ.UTF-8";
    test "$LC_ALL" = "en_NZ.UTF-8"
  '';

  enterShell = ''
    elixir --version
    echo "node version: `node --version`"
  '';

  languages = {
    elixir = {
      enable = true;
      package = pkgs.beam.packages.erlangR26.elixir_1_16;
    };
  };

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    listen_addresses = "0.0.0.0";
    # TODO: can this use env vars?
    initialScript = "DROP ROLE IF EXISTS phoenix_dev; CREATE ROLE phoenix_dev LOGIN PASSWORD 'phoenix_dev_pass' SUPERUSER; ; CREATE DATABASE phoenix_dev; DROP ROLE IF EXISTS phoenix_test; CREATE ROLE phoenix_test LOGIN PASSWORD 'phoenix_test_pass' SUPERUSER; CREATE DATABASE phoenix_test;";
    settings = {
      log_connections = true;
      log_statement = "all";
      logging_collector = true;
      log_disconnections = true;
      log_destination = "stderr";
    };
  };
}

