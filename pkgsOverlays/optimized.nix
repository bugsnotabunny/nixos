arch:
(self: super:
  let
    optimized = pkg:
      pkg.override {
        stdenv =
          super.stdenvAdapters.withCFlags [ "-mtune=${arch}" "-march=${arch}" ]
          super.stdenv;
      };
  in {
    optimized = {
      linux_xanmod_latest = optimized super.linux_xanmod_latest;
      hyprland = optimized super.hyprland;
      custom.comfyui = optimized super.custom.comfyui;
    };
  })
