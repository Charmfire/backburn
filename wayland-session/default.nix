{ moduleWithSystem, ... }:
{
  flake.nixosModules.wayland-session = moduleWithSystem (
    perSystem@{ config, pkgs, ... }:  # NOTE: only explicitly named parameters will be in perSystem; see below
    nixos@{ ... }:
    let
      charm-term = (import ../charm-term { inherit pkgs; });
      cageAlacrittySession = pkgs.writeTextDir
        "share/wayland-sessions/cage-alacritty-zellij.desktop"
        ''
          [Desktop Entry]
          Name=Backburn (wayland)
          Comment=Wayland session with Cage, charm-term(alacritty), and Zellij
          Exec=cage ${charm-term}
          Type=Application
        '';
    in
    {
      services.displayManager.sessionPackages = [
        cageAlacrittySession
      ];

      environment.systemPackages = [
        charm-term
      ];
    }
  );
}
