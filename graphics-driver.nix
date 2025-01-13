{ gpuSettings }:
{ pkgs, config, lib, ... }:
if gpuSettings.id == "intel" then {
  services.xserver.videoDrivers = [ "intel" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
} else if gpuSettings.id == "nvidia" then {
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Hardware should specify the bus ID for intel/nvidia devices
    prime = gpuSettings.nvidiaPrime;
  };
  environment.systemPackages = with pkgs; [ gpustat ];
} else {
  a = assert false; "should set graphicsDriver approptiately";
}
