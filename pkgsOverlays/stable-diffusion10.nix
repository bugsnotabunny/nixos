{ fetchResource }:
fetchResource rec {
  name = baseNameOf url;
  url =
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors";
  sha256 = "sha256-MeNcgPxIKdFPkBU/THTNWckLd59q/gWnTNYSC4k/fls=";
  passthru = { comfyui.installPaths = [ "checkpoints" ]; };
}
