# { config, lib, pkgs, ... }:
with import <nixpkgs> { };
# Setup orbmapper for remapping
rustPlatform.buildRustPackage rec {
  name = "orbmapper";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "Gelbana";
    repo = "orbmapper";
    rev = "22ee8c5479924425539b6e6fcc585cc5733797da";
    sha256 = "BxKwcQY8YgiUZmIw1bSkIphzTFIGUpvpq+uU8G3EKZ4=";
  };

  cargoSha256 = "5yjUd5wFjHd7CYyLEiw7C6FCSlrbNavAhCNCgfjyaBc=";
}
