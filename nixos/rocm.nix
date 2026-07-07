{ pkgs, ... }:
{
    
  # Enable OpenGL/Vulkan with OpenCL and ROCm/HIP support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = with pkgs; [
      clinfo
  ];
  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "11.0.0";
  };
  systemd.tmpfiles.rules = [ "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}" ];


  # # Set up HIP and ROCm library paths so software (like PyTorch, Ollama, or Blender) can find them
  # systemd.tmpfiles.rules =
  #   let
  #     rocmEnv = pkgs.symlinkJoin {
  #       name = "rocm-combined";
  #       paths = with pkgs.rocmPackages; [
  #         rocblas
  #         hipblas
  #         clr
  #       ];
  #     };
  #   in
  #   [
  #     "L+ /opt/rocm - - - - ${rocmEnv}"
  #   ];

  users.users.mainusr.extraGroups = [ "video" "render" ];
}
