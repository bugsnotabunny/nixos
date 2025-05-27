{ pkgs, ... }: {
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  rootDevice = "/dev/nvme0n1";
  storageDevices = [ ];

  gpu.manufacturer = "intel";
  doGaming = false;
  batteries.enable = true;
  username = "d.malakhov";
  usernameFull = "Dmitry Malakhov";

  time.timeZone = "Europe/Moscow";
  networking.hostId = "13f0ff73";

  security.pki.certificateFiles = [ ./tel.yadro.com.crt ];

  virtualisation.docker.daemon.settings = {
    insecure-registries =
      [ "http://harbor.mfg.yadro.com:8888" "http://172.17.10.47:8000" ];
    "allow-nondistributable-artifacts" = [ "harbor.mfg.yadro.com:8888" ];
    bip = "10.75.0.1/24";
    default-address-pools = [
      {
        base = "10.75.11.1/24";
        size = 24;
      }
      {
        base = "10.75.0.0/24";
        size = 24;
      }
    ];
    dns = [ "172.17.240.173" "172.17.10.2" "172.17.100.2" ];
  };

  environment.systemPackages = with pkgs; [
    drawio
    ktalk
    mattermost-desktop
    vscode
  ];

  # programs.evolution = {
  #   enable = true;
  #   plugins = [ pkgs.evolution-ews pkgs.evolution-data-server-gtk4 ];
  # };
}
