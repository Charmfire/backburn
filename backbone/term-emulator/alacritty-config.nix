{pkgs}: 
let 
  multiplexer = (import ../multiplexer {inherit pkgs;});
in
pkgs.writers.writeTOML "backburn-alacritty-config"
{
  terminal = {
    shell = {
      program = "${multiplexer.bin}";
      args = multiplexer.args;
    };
  }; 

  window = {
    opacity = 0.3;
  };
}
