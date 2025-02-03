{ pkgs, ... }: {
  rootDevice = "/dev/sda";
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
      stable-diffusion-35-large
      pixel-art-35-L
    ];
  };
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
}
