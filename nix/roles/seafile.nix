{
  ...
}:
{
  services.seafile = {
    enable = true;
    adminEmail = "alex.palermo.42@protonmail.com";
    initialAdminPassord = "changeme";
    ccnetSettingsGeneral.SERVICE_URL = "https://seafile.example.com";

    seafileSettings = {
      fileserver = {
        host = "unix:/run/seafile/seafile.sock";
      };
    };
  };
}
