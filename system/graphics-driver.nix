{ pkgs, lib, config, ... }: {
  options.gpu = with lib; {
    manufacturer = mkOption { type = types.enum [ "intel" "nvidia" ]; };
    nvidiaPrime = {
      sync.enable = mkEnableOption { };
      offload = {
        enable = mkEnableOption { };
        enableOffloadCmd = mkEnableOption { };
      };
      nvidiaBusId = mkOption {
        type = types.str;
        default = "";
      };
      intelBusId = mkOption {
        type = types.str;
        default = "";
      };
      amdgpuBusId = mkOption {
        type = types.str;
        default = "";
      };
    };
  };

  config = lib.mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      services.xserver.videoDrivers = [ config.gpu.manufacturer ];
    }

    (lib.mkIf (config.gpu.manufacturer == "intel") {
      hardware.graphics = {
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau-va-gl
        ];
      };

      environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
    })

    (lib.mkIf (config.gpu.manufacturer == "nvidia") {
      boot.initrd.kernelModules = [ "nvidia" ];
      boot.blacklistedKernelModules = [ "nouveau" ];

      hardware.nvidia = {
        open = false;
        dynamicBoost.enable = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        prime = config.gpu.nvidiaPrime;
      };
      environment.systemPackages = with pkgs; [ gpustat ];
    })
  ];
}
