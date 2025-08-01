{ pkgs, ... }:
{
  boot.kernelParams = [ "amd_pstate=passive" ];
  # powerManagement.enable = true;
  # powerManagement.cpuFreqGovernor = "schedutil";
  # firefox hardware acceleration
  #
  environment.systemPackages = [
    pkgs.unstable.radeontop
  ];

  powerManagement = {
    enable = true;
    #cpufreq.min = 800000;
    #cpufreq.max = 2200000;
    powertop.enable = true;
    #powerUpCommands =
    cpuFreqGovernor = "schedutil"; # power, performance, ondemand
  };

  hardware.system76.power-daemon.enable = true;
  services.power-profiles-daemon.enable = true;
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #       CPU_BOOST_ON_BAT = 0;
  #       CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
  #       START_CHARGE_THRESH_BAT0 = 90;
  #       STOP_CHARGE_THRESH_BAT0 = 97;
  #       RUNTIME_PM_ON_BAT = "auto";
  #   };
  # };
  # services.auto-cpufreq.enable = false;

  boot.initrd.systemd.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];
  # boot.resumeDevice makes the boot sequence hang on "a start job is running for /var/lib/swapfile"
  # boot.resumeDevice = "/var/lib/swapfile";
  # systemd.tpm2.enable = false;
  # boot.initrd.systemd.tpm2.enable = false;
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";

  # https://community.frame.work/t/troubleshooting-hibernate-amd-ryzen-7040/60876/9
  systemd.services.disable-wireless-hibernate = {
    description = "Disable WiFi and Bluetooth before hibernation";
    wantedBy = [
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    before = [
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    script = ''
      # Disable WiFi
      ${pkgs.networkmanager}/bin/nmcli radio wifi off || true

      # Disable Bluetooth
      ${pkgs.bluez}/bin/bluetoothctl power off || true
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false;
      User = "root";
    };
  };
  # Optional: Create a complementary service to re-enable on resume
  systemd.services.enable-wireless-resume = {
    description = "Re-enable WiFi and Bluetooth after resume";
    wantedBy = [ "post-resume.target" ];
    after = [ "post-resume.target" ];
    script = ''
      # Re-enable WiFi
      ${pkgs.networkmanager}/bin/nmcli radio wifi on || true

      # Re-enable Bluetooth
      ${pkgs.bluez}/bin/bluetoothctl power on || true
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false;
      User = "root";
    };
  };
}
