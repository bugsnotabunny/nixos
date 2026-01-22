{ pkgs, ... }: {
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };

    firewall = { enable = true; };
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
