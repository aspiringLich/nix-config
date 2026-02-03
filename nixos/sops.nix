{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      sshKeyPaths = [ "/home/mainusr/.ssh/id_ed25519" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets."smb_username" = {};
    secrets."smb_password" = {};

    templates."smb-credentials" = {
      content = ''
        username=${"\${config.sops.placeholder.smb_username}"}
        password=${"\${config.sops.placeholder.smb_password}"}
      '';
      path = "/etc/nixos/smb-credentials";
      mode = "0600";
    };
    
    # secrets."s3_access_key" = {};
    # secrets."s3_secret_key" = {};
  };
}
