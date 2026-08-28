{ pkgs, ... }: {
  rootDevice = "/dev/disk/by-id/nvme-DGST4512GG33T_D1N610K8X00987";
  storageDevices = [ "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_250GB_S3Y9NB0K527527B" ];

  networking.hostId = "8425e349";

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  username = "banan";

  doGaming = true;
  minecraftServer = false;
  cpuArch = "znver2";

  gpu.manufacturer = "nvidia";
  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:8:0:0";
  };

  environment.systemPackages = with pkgs; [
    # gpt4all-cuda
    firefox-bin
    # discord
    # comfyui
  ];

  time.timeZone = "Europe/Moscow";
}
