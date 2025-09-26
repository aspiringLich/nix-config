{
  config,
  pkgs,
  ...
}:
{
  services.part-db = {
    enable = true;
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
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
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
