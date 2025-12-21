{ moduleWithSystem, ... }:
{
  flake.nixosModules.desktop-entry = moduleWithSystem (
    perSystem@{ config, pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      charm-term = (import ../charm-term { inherit pkgs; });
      backburnEntry = pkgs.makeDesktopItem {
        name = "backburn";
        desktopName = "backburn";
        exec = "${charm-term.bin}";
      };
    in
    {

      environment.systemPackages = [
        backburnEntry
      ];
    }
  );
}
