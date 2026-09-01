{ inputs, pkgs, ... }: {
  rootDevice = "/dev/nvme0n1";
  storageDevices = [ ];

  cpuArch = "lunarlake";
  gpu.manufacturer = "intel";
  doGaming = false;
  batteries.enable = true;
  username = "d.malakhov";
  userDescription = "Dmitry Malakhov";
  userEmail = "d.malakhov@yadro.com";

  boot.kernelPackages =
    inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-bore-lto-x86_64-v4;

  time.timeZone = "Europe/Moscow";
  networking.hostId = "13f0ff73";

  environment.systemPackages = with pkgs; [
    clamav
  ];
}
