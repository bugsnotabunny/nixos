{ pkgs, stdenv }:
pkgs.comfyui.override {
  inherit stdenv;
  withCustomNodes = with pkgs.comfyuiPackages; [
    comfyui-gguf
    comfyui-impact-pack
    comfyui-impact-subpack
    rgthree
    comfyui-crystools
  ];
  withModels = [ ];
}
