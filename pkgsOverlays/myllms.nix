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
}
