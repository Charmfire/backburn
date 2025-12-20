{ pkgs, charm-term,... }:

let
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
