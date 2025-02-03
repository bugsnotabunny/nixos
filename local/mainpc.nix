{ pkgs, ... }: {
  rootDevice = "/dev/sda";
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
  gpu = {
    nvidia = true;
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:8:0:0";
    };
  };

  username = "banan";
  isWorkstation = false;
  doGaming = true;
  time.timeZone = "Europe/Moscow";

  services.comfyui = {
    enable = true;
    acceleration = "cuda";
    models = with pkgs.myllms; [
      pokemon-trainer-sprite-pixelart
      stable-diffusion-xl-base
      pixel-art-xl

      sd-35-medium
      pixel-art-35-L

    ];
  };
}
