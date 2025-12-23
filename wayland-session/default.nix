{ moduleWithSystem, ... }:
{
  flake.nixosModules.wayland-session = moduleWithSystem (
    perSystem@{ config, pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      term-emulator = (import ../backbone/term-emulator { inherit pkgs; });
      backburnSession = pkgs.writeTextFile {
        text = ''
          [Desktop Entry]
          Name=Backburn (wayland)
          Comment=Wayland session with Cage, term-emulator(alacritty), and Zellij
          Exec=cage ${term-emulator.bin}
          Type=Application
        '';
        name = "backburn-session";
        destination = "/share/wayland-sessions/backburn.desktop";
        passthru.providedSessions = [ "backburn" ];

      };
    in
    {
      services.displayManager.sessionPackages = [
        # all sessions available in XDG_DATA_DIRS/share
        backburnSession
      ];

      environment.systemPackages = [
        pkgs.cage
        term-emulator.package
      ];
    }
  );
}
