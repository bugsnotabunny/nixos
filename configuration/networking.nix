{ pkgs, ... }: {
  networking = {
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
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
