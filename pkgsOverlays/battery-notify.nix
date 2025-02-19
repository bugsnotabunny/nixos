{ rustPlatform, fetchFromGitHub }:
let pname = "battery-notify";
in rustPlatform.buildRustPackage {
  inherit pname;
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cdown";
    repo = pname;
    rev = "c85f138f889d81aeffe4dd98c3c82a9bb45590e6";
    sha256 = "sha256-6/U6GyOn0xc1gzIyc6EUSLzgIsvGIgBmDlF2Y4rRfuc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-0RkHg8rbrs8Ksbr+wdjqWNrAjvsv9zrk5f7FucOuhow=";
}
