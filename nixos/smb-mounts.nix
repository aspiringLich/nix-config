{
  pkgs,
  ...
}:
{
  # # Required packages for CIFS/SMB mounting
  # environment.systemPackages = [ pkgs.cifs-utils ];

  # # Create mount point directory
  # systemd.tmpfiles.rules = [
  #   "d /mnt/Labs 0755 mainusr users -"
  # ];

  # # SMB mount configuration
  # fileSystems."/mnt/Labs" = {
  #   device = "//wertsrv.case.edu/Labs";
  #   fsType = "cifs";
  #   options = [
  #     "credentials=/etc/nixos/smb-credentials"
  #     "uid=1000"
  #     "gid=100"
  #     "x-systemd.automount"
  #     "noauto"
  #     "x-systemd.idle-timeout=60"
  #     "x-systemd.device-timeout=5s"
  #     "x-systemd.mount-timeout=5s"
  #   ];
  # };
}
