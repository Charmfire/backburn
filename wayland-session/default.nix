{ moduleWithSystem, ... }:
{
  flake.nixosModules.wayland-session = moduleWithSystem (
    perSystem@{ config, pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      charm-term = (import ../charm-term { inherit pkgs; });
      backburnSession = pkgs.writeTextFile {
        text = ''
          [Desktop Entry]
          Name=Backburn (wayland)
          Comment=Wayland session with Cage, charm-term(alacritty), and Zellij
          Exec=cage ${charm-term}
          Type=Application
        '';
        name = "backburn-session";
        destination = "share/wayland-sessions/backburn.desktop";

      };
    in
    {
      services.displayManager.sessionPackages = [
        backburnSession
      ];

      environment.systemPackages = [
        pkgs.cage
        charm-term
      ];
    }
  );
}
