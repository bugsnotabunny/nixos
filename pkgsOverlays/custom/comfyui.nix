{ pkgs, stdenv }:
pkgs.comfyuiPackages.comfyui.override {
  inherit stdenv;
  extensions = with pkgs.comfyuiPackages.extensions; [
    acly-inpaint
    acly-tooling
    badcafecode-execution-inversion-demo
    city96-gguf
    cubiq-essentials
    cubiq-instantid
    cubiq-ipadapter-plus
    ellangok-post-processing
    extraltodeus-skimmed-cfg
    fannovel16-controlnet-aux
    fannovel16-frame-interpolation
    fizzledorf-fizz
    florestefano1975-portrait-master
    gourieff-reactor
    huchenlei-layerdiffuse
    kijai-ic-light
    kijai-supir
    kosinkadink-advanced-controlnet
    kosinkadink-animatediff-evolved
    kosinkadink-video-helper-suite
    lev145-images-grid
    ssitu-ultimate-sd-upscale
  ];

  commandLineArgs = [ "--preview-method" "auto" ];
}
