{ pkgs, ... }:
{
  # Configure power button and lid switch actions
  services = {
    logind.settings.Login = {
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "hibernate";
      HandleLidSwitch = "suspend";
      IdleAction = "suspend";
    };
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30M
    HibernateOnACPower=false
    IdleActionSec=30M
  '';

  boot.kernelParams = [
    "resume_offset=145268736"
    "acpi_osi=\"!Windows 2020\""
    "mem_sleep_default=s2idle"
    "amdgpu.dcdebugmask=0x400"
    "pcie_aspm=off"
    "amdgpu.dc=1"
    "amdgpu.abmlevel=0"
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/74ec4e80-5aa3-42b2-93cd-5200d342a0f9";
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  # Disable kernel image protection to fix hibernation resume
  security.protectKernelImage = false;
  boot.initrd.systemd.enable = false;

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    unstable.radeontop
  ];
}
