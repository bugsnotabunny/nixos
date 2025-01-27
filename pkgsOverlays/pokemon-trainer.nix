{ fetchResource }:
fetchResource rec {
  name = baseNameOf url;
  url =
    "https://huggingface.co/sWizad/pokemon-trainer-sprite-pixelart/resolve/main/pk_trainer_xl_v1.safetensors";
  sha256 = "sha256-B44J2ioSOWS36zDbI+wk1Z+wgjQ/acf6+SXEwH6XAj4=";
  passthru = { comfyui.installPaths = [ "loras" ]; };
}
