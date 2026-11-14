{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gpu = with lib; {
    manufacturer = mkOption {
      type = types.enum [
        "intel"
        "nvidia"
        "amd"
      ];
    };
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

  }
  // (lib.mkIf (config.gpu.manufacturer == "intel") {
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.graphics.extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      libvdpau-va-gl
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };

  })
  // (lib.mkIf (config.gpu.manufacturer == "nvidia") {
    services.xserver.videoDrivers = [ "nvidia" ];
    nixpkgs.config.cudaSupport = true;

    boot = {
      initrd.kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];
      blacklistedKernelModules = [ "nouveau" ];
    };
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  });
}
