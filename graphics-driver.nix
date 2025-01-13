{ gpuSettings }:
{ pkgs, config, lib, ... }:
if gpuSettings.id == "intel" then {
  services.xserver.videoDrivers = [ "intel" ];
  hardware.graphics.enable32Bit = true;
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiVdpau libvdpau-va-gl ];
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
