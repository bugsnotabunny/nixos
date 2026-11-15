{ pkgs, ... }: {
  cpuArch = "x86-64-v3";
  gpu.manufacturer = "intel";
  doGaming = false;
  batteries.enable = true;
  username = "banan";

  boot.kernelPackages = pkgs.linuxPackages;

  time.timeZone = "Europe/Moscow";
  networking.hostId = "8425e349";

  environment.systemPackages = with pkgs; [
    firefox-bin
  ];
}
