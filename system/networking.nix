{ pkgs, ... }: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        # SSH
        22
      ];
      allowedUDPPorts = [
        # DHCP
        68
        546
      ];
    };
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn
  ];
}
