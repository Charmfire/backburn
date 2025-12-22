{ moduleWithSystem, ... }:
{
  flake.nixosModules.desktop-entry = moduleWithSystem (
    perSystem@{ config, pkgs, lib, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      term-emulator = (import backbone/term-emulator { inherit pkgs; });
      quick-open = (import ../quick-open {inherit pkgs lib;});
      backburnEntry = pkgs.makeDesktopItem {
        name = "backburn";
        desktopName = "backburn";
        exec = "${term-emulator.bin}";
      };
    in
    {

      environment.systemPackages = [
        backburnEntry
        pkgs.zellij
        quick-open
      ];
    }
  );
}
