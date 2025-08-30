{ ... }: {
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];
  boot.kernel.sysctl = { "vm.swappiness" = 100; };
  batteries.enable = true;
  networking.hostId = "99f1f7ff";
  cpuArch = "x86-64";
  gpu = {
    manufacturer = "nvidia";
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:2:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  rootDevice = "/dev/nvme0n1";
  storageDevices = [ ];
  username = "banan";
  doGaming = true;
  time.timeZone = "Europe/Moscow";
}
