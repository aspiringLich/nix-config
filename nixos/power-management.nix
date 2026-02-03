{ pkgs, ... }:
{
  # Configure power button and lid switch actions
  services = {
    logind.settings.Login = {
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "hibernate";
      HandleLidSwitch = "suspend-then-hibernate";
    };
  };

  boot.kernelParams = [ "amd_pstate=passive" "amdgpu.abmlevel=0" "resume_offset=145268736"];
  boot.resumeDevice = "/dev/disk/by-uuid/74ec4e80-5aa3-42b2-93cd-5200d342a0f9";
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 32 * 1024;
      }
    ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30M
    HibernateOnACPower=false
  '';

  # Disable kernel image protection to fix hibernation resume
  security.protectKernelImage = false;
  boot.initrd.systemd.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  services = {
    tlp.enable = false;
    power-profiles-daemon.enable = false;
    tuned = {
      enable = true;
      settings.dynamic_tuning = true;
    };
    thermald.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
      unstable.radeontop
  ];
}
