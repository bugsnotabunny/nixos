{ gpuSettings }:
{ pkgs, config, lib, ... }:
if gpuSettings.id == "intel" then {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
} else if gpuSettings.id == "nvidia" then {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Hardware should specify the bus ID for intel/nvidia devices
    prime = gpuSettings.nvidiaPrime;
  };
} else {
  a = assert false; "should set graphicsDriver approptiately";
}
