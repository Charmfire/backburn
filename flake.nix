{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./wayland-session

      ];
      systems = [ 
        "x86_64-linux"
        "aarch64-linux" 
        "aarch64-darwin" 
        "x86_64-darwin" 
      ];
      perSystem = { config, self', inputs', pkgs, system, ... }: 
      let
        charm-term = (import ./charm-term { inherit pkgs; });
      in
      {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages = {
          inherit charm-term;
          default = pkgs.alacritty;
        };

      };
      flake = {
      };
    };
}
