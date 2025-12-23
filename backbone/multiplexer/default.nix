{pkgs} :
let 
  config-file = ./zellij-config.kdl;
in {
  package = pkgs.zellij;
  bin = "${pkgs.zellij}/bin/zellij";
  args = [
    "--config" "${config-file}"
    "attach" "-c" "main" ];
}
