{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [ pamixer pavucontrol playerctl ];
}
