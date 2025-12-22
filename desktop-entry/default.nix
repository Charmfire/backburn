{ moduleWithSystem, ... }:
{
  flake.nixosModules.desktop-entry = moduleWithSystem (
    perSystem@{ config, pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      term-emulator = (import ../backbone/term-emulator { inherit pkgs; });
      multiplexer = (import ../backbone/multiplexer {inherit pkgs;});

      quick-open = (import ../quick-open {inherit pkgs;});
      backburnEntry = pkgs.makeDesktopItem {
        name = "backburn";
        desktopName = "backburn";
        exec = "${quick-open}";
      };
    in
    {
      environment.systemPackages = [
        backburnEntry
        term-emulator.package
        multiplexer.package
      ];
    }
  );
}
