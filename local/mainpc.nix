{ pkgs, ... }: {
  rootDevice = "/dev/nvme0n1";
  storageDevices = [ "/dev/sda" ];

  networking.hostId = "8425e349";

  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  username = "banan";

  doGaming = true;
  gpu = {
    manufacturer = "nvidia";
    nvidiaPrime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:8:0:0";
    };
  };

  environment.systemPackages = let
    myComfyui = pkgs.comfyuiPackages.comfyui.override {
      extensions = [
        pkgs.comfyuiPackages.extensions.acly-inpaint
        pkgs.comfyuiPackages.extensions.acly-tooling
        pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
        pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
      ];

      commandLineArgs = [ "--preview-method" "auto" ];
    };
  in with pkgs; [
    # gpt4all-cuda
    firefox
    myComfyui
  ];

  time.timeZone = "Europe/Moscow";
}
