{ pkgs, ... }: {
  rootDevice = "/dev/nvme0n1";
  storageDevices = [ "/dev/sda" ];
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
  networking.hostId = "8425e349";
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  gpu = {
    manufacturer = "nvidia";
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:8:0:0";
    };
  };

  # environment.systemPackages = with pkgs; [ gpt4all-cuda ];

  username = "banan";
  doGaming = true;
  time.timeZone = "Europe/Moscow";
}
