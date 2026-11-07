arch:
(
  self: super:
  let
    optimizedStdenv =
      stdenv: super.stdenvAdapters.withCFlags [ "-mtune=${arch}" "-march=${arch}" ] stdenv;

    withOptimized = stdenv: pkg: pkg.override { stdenv = optimizedStdenv stdenv; };
    optimized = pkg: withOptimized super.stdenv pkg;
  in
  {
    niri = optimized super.niri;
    unstable.niri = optimized super.unstable.niri;
    custom.comfyui = optimized super.custom.comfyui;
  }
)
