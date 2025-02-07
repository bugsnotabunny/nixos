{ ... }: {
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
  gpu = {
    manufacturer = "nvidia";
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:2:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  rootDevice = "/dev/nvme0n1";
  username = "banan";
  doGaming = true;
  time.timeZone = "Europe/Moscow";
}
