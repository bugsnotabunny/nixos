arch:
(self: super:
  let
    optimizedStdenv = stdenv:
      super.stdenvAdapters.withCFlags [ "-mtune=${arch}" "-march=${arch}" ]
      stdenv;

    withOptimized = stdenv: pkg:
      pkg.override { stdenv = optimizedStdenv stdenv; };
    optimized = pkg: withOptimized super.stdenv pkg;
    optimizedCcached = pkg: withOptimized super.ccacheStdenv pkg;
  in {
    hyprland = optimized super.hyprland;
    comfyui = optimizedCcached super.custom.comfyui;
  })
