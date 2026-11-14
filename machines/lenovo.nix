{ pkgs, ... }: {
  rootDevice = "/dev/disk/by-id/nvme-YMTC_YMSS2ED06B66MC_YMB6512JA25485096F";
  storageDevices = [ ];

  cpuArch = "x86-64-v3";
  gpu.manufacturer = "amd";
  doGaming = true;
  batteries.enable = true;
  username = "banan";

  boot.kernelPackages = pkgs.linuxPackages;

  time.timeZone = "Europe/Moscow";
  networking.hostId = "8425e349";

  environment.systemPackages = with pkgs; [
    firefox-bin
  ];
}
