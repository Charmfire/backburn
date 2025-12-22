{pkgs} : {
  package = pkgs.zellij;
  bin = "${pkgs.zellij}/bin/zellij";
  args = [ "attach" "-c" "main" ];
}
