{ pkgs, ... }: {
  gpu.intel = true;

  isWorkstation = true;
  doGaming = false;
  time.timeZone = "Europe/Moscow";
  username = "dmalakhov";
  usernameFull = "Dmitry Malakhov";

  services.comfyui = {
    enable = true;
    acceleration = false;
    models = with pkgs.myllms; [
      pokemon-trainer-sprite-pixelart
      stable-diffusion-xl-base
    ];
  };
}
