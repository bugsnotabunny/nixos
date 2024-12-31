{ graphicsDriver }:
{ pkgs, config, lib, ... }:
if graphicsDriver == "intel" then
{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
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
  hardware.opengl.enable = true;
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Hardware should specify the bus ID for intel/nvidia devices
  };
}
else
{
  a =  assert false; "should set graphicsDriver approptiately";
}
