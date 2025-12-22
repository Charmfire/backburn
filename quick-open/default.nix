{pkgs, lib}: 
let
  charm-term = (import ../charm-term { inherit pkgs; });
in
pkgs.writeShellScriptBin "backburn-quick"
''
  ${charm-term.bin} ${lib.strings.join " " charm-term.args}
''