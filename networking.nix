{ hostname }:
{ config, pkgs, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    networkmanager-openvpn
  ];
}
