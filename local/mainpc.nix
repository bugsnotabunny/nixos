{ pkgs, ... }: {
  rootDevice = "/dev/nvme0n1";
  storageDevices = [ "/dev/sda" ];

  networking.hostId = "8425e349";

  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  username = "banan";

  doGaming = true;
  cpuArch = "znver2";
  gpu = {
    manufacturer = "nvidia";
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:8:0:0";
    };
  };

  environment.systemPackages = with pkgs; [
    # gpt4all-cuda
    firefox
    optimized.comfyui
  ];

  time.timeZone = "Europe/Moscow";
}
