{ pkgs, ... }: {
  rootDevice = "/dev/nvme0n1";
  storageDevices = [ "/dev/sda" ];
  networking.hostId = "8425e349";

  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  username = "banan";

  doGaming = true;
  minecraftServer = true;
  cpuArch = "znver2";

  gpu.manufacturer = "nvidia";
  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:8:0:0";
  };

  environment.systemPackages = with pkgs;
    [
      # gpt4all-cuda
      firefox-bin
      # discord
      comfyui
    ];

  time.timeZone = "Europe/Moscow";
}
