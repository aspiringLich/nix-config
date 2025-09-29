{
  config,
  pkgs,
  ...
}:
{
  services.part-db = {
    enable = true;
    enablePostgresql = true;
    settings = {
      DEFAULT_LANG = "en";
      DEFAULT_TIMEZONE = "America/New_York";
      BASE_CURRENCY = "USD";
      BANNER = ''
        Read [https://docs.part-db.de/concepts.html] to learn more about how to use Part-DB.

        This is running on a server maintained by me (Brandon Li). Yell at me if anything needs to be changed.
      '';
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."part-db.bcli.dev" = {
      enableACME = true;
      forceSSL = true;

      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/web-apps/part-db.nix
      root = "${config.services.part-db.package}/public";
      locations = {
        "/" = {
          tryFiles = "$uri $uri/ /index.php";
          index = "index.php";
          extraConfig = ''
            sendfile off;
          '';
        };
        "~ \.php$" = {
          extraConfig = ''
            include ${config.services.nginx.package}/conf/fastcgi_params ;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_param modHeadersAvailable true; #Avoid sending the security headers twice
            fastcgi_pass unix:${config.services.phpfpm.pools.part-db.socket};
          '';
        };
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "part-db" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser   auth-method optional_ident_map
      local sameuser  all      peer        map=superuser_map
      local all       root     trust
      local all       postgres trust

      host  all       postgres ::1/128    trust
    '';
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root      postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "brandonli@bcli.dev";
  };
}
