{ pkgs, lib, config, ... }: {
  options.gpu = with lib; {
    intel = mkEnableOption { };
    nvidia = mkEnableOption { };
    nvidiaPrime = {
      sync.enable = mkEnableOption { };
      offload = {
        enable = mkEnableOption { };
        enableOffloadCmd = mkEnableOption { };
      };
      nvidiaBusId = mkOption { type = types.str; };
      intelBusId = mkOption { type = types.str; };
      amdgpuBusId = mkOption { type = types.str; };
    };
  };

  config = lib.mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      assertions = [{ assertion = config.gpu.intel != config.gpu.nvidia; }];
    }

    (lib.mkIf config.gpu.intel {
      services.xserver.videoDrivers = [ "intel" ];
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

    (lib.mkIf config.gpu.nvidia {

      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = config.gpu.nvidiaPrime;
      };
      environment.systemPackages = with pkgs; [ gpustat ];
    })
  ];
}
