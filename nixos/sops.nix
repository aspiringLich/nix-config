{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    # defaultSopsFile = ./secrets/secrets.yml;
    defaultSopsFormat = "yaml";

    age = {
      sshKeyPaths = [ "~/.ssh/id_ed25519" ];
      keyFile = "~/.config/sops/age/keys.txt";
      generateKey = true;
    };
  };
}
