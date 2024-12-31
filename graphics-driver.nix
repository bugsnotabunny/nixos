{ graphicsDriver, pkgs, config, lib, ... }:
if graphicsDriver == "intel" then
{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
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
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
else if graphicsDriver == "nvidia" then
{
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    offload = {
      enable = lib.mkOverride 990 true;
      enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
    };
    # Hardware should specify the bus ID for intel/nvidia devices
  };
}
else
{
  a =  assert false; "should set graphicsDriver approptiately";
}
