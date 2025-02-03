{ fetchResource }: {
  pokemon-trainer-sprite-pixelart = fetchResource rec {
    name = baseNameOf url;
    url =
      "https://huggingface.co/sWizad/pokemon-trainer-sprite-pixelart/resolve/main/pk_trainer_xl_v1.safetensors";
    sha256 = "sha256-B44J2ioSOWS36zDbI+wk1Z+wgjQ/acf6+SXEwH6XAj4=";
    passthru = { comfyui.installPaths = [ "loras" ]; };
  };

  stable-diffusion-xl-base = fetchResource rec {
    name = baseNameOf url;
    url =
      "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors";
    sha256 = "sha256-MeNcgPxIKdFPkBU/THTNWckLd59q/gWnTNYSC4k/fls=";
    passthru = { comfyui.installPaths = [ "checkpoints" ]; };
  };

  pixel-art-xl = fetchResource rec {
    name = baseNameOf url;
    url =
      "https://huggingface.co/nerijs/pixel-art-xl/resolve/main/pixel-art-xl.safetensors";
    sha256 = "sha256-QjRjfLgMmY9B40jmpstrwg2NA4srDyVrYSmzteNT7vc=";
    passthru = { comfyui.installPaths = [ "loras" ]; };
  };

  stable-diffusion-35-large = fetchResource rec {
    name = baseNameOf url;
    url =
      "https://huggingface.co/stabilityai/stable-diffusion-3.5-large/resolve/main/sd3.5_large.safetensors";
    sha256 = "sha256-/+96J52RNGJubODUlPuoT8HH5yCzx98tGaCdw3ltj5M=";
    passthru = { comfyui.installPaths = [ "checkpoints" ]; };
  };

  pixel-art-35-L = fetchResource rec {
    name = baseNameOf url;
    url =
      "https://huggingface.co/nerijs/pixel-art-3.5L/resolve/main/pixel-art-3.5L-v2_000000300.safetensors";
    sha256 = "sha256-r90gyf/c0+AhtzugeSqpRGsfS49UE3xGunrNHbD6vY4=";
    passthru = { comfyui.installPaths = [ "loras" ]; };
  };
}
