{pkgs} :
let 
  config-file = import ./alacritty-config.nix {inherit pkgs;};
in
{
  package = pkgs.alacritty;
  bin = "${pkgs.alacritty}/bin/alacritty";
  args = [  
    "--config-file"
    "${config-file}"
    "--hold"
  ];
}
