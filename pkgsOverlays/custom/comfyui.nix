{ pkgs, stdenv }:
pkgs.comfyuiPackages.comfyui.override {
  inherit stdenv;
  extensions = [
    pkgs.comfyuiPackages.extensions.acly-inpaint
    pkgs.comfyuiPackages.extensions.acly-tooling
    pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
    pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
  ];

  commandLineArgs = [ "--preview-method" "auto" ];
}
