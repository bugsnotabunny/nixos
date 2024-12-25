{  pkgs ? import <nixpkgs> {} }:
  let
    overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
    libPath = with pkgs; lib.makeLibraryPath [
      libxkbcommon
      libGL
      wlroots
      wayland
      wayland-utils
    ];
in
  pkgs.mkShell rec {
    buildInputs = with pkgs; [
      fontconfig
      pkg-config
      clang
      llvmPackages.bintools
      rustup
    ];
    PKG_CONFIG_PATH = "${pkgs.alsa-lib}/lib/pkgconfig";
    RUSTC_VERSION = overrides.toolchain.channel;
    # https://github.com/rust-lang/rust-bindgen#environment-variables
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
    shellHook = ''
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
      '';
    RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
    ]);
    LD_LIBRARY_PATH = libPath;
    RUST_BACKTRACE="full";
    RUST_LOG = "debug";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    BINDGEN_EXTRA_CLANG_ARGS =
    (builtins.map (a: ''-I"${a}/include"'') [
      pkgs.glibc.dev
    ])

    ++ [
      ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
      ''-I"${pkgs.glib.dev}/include/glib-2.0"''
      ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
    ];
  }
