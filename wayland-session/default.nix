{ moduleWithSystem, ... }:
{
  flake.nixosModules.wayland-session = moduleWithSystem (
    perSystem@{ config, self', pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      cageAlacrittySession = pkgs.writeTextDir
        "share/wayland-sessions/cage-alacritty-zellij.desktop"
        ''
          [Desktop Entry]
          Name=Backburn (wayland)
          Comment=Wayland session with Cage, charm-term(alacritty), and Zellij
          Exec=cage ${self'.charm-term}
          Type=Application
        '';
    in
    {
      services.displayManager.sessionPackages = [
        cageAlacrittySession
      ];

      environment.systemPackages = [
        self'.charm-term
      ];
    }
  );
}
