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
    # linux kernel uses cc from depsBuildBuild as well instead of just stdenv
    linux_xanmod_latest = super.linux_xanmod_latest.overrideAttrs (oldAttrs:
      let ccacheStdenv = optimizedStdenv super.ccacheStdenv;
      in { depsBuildBuild = [ ccacheStdenv.cc ]; });

    hyprland = optimized super.hyprland;
    comfyui = optimized super.custom.comfyui;
  })
