{ pkgs, ... }: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn
  ];
}
