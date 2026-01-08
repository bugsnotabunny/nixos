arch:
(self: super:
  let
    optimizedStdenv = stdenv:
      super.stdenvAdapters.withCFlags [ "-mtune=${arch}" "-march=${arch}" ]
      stdenv;

    withOptimized = stdenv: pkg:
      pkg.override { stdenv = optimizedStdenv stdenv; };
    optimized = pkg: withOptimized super.stdenv pkg;
  in {
    hyprland = optimized super.hyprland;
    unstable.hyprland = optimized super.unstable.hyprland;
    custom.comfyui = optimized super.custom.comfyui;
  })
