{ lib, config, pkgs, ... }: {
  options = with lib; { isWorkstation = mkEnableOption { }; };

  config = lib.mkIf (config.isWorkstation) {
    security.pki.certificateFiles =
      if config.isWorkstation then [ ./tel.yadro.com.crt ] else [ ];

    virtualisation.docker.daemon.settings = if config.isWorkstation then {
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
    } else
      { };

    environment.systemPackages = with pkgs; [
      ktalk
      evolution
      evolution-ews
      chromium
      mattermost-desktop
      vscode
    ];
  };
}
