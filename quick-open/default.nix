{pkgs}: 
let
  term-emulator = (import ../backbone/term-emulator { inherit pkgs; });
  lib = pkgs.lib;
in
pkgs.writeShellScriptBin "backburn-quick"
''
  ${term-emulator.bin} ${lib.strings.join " " term-emulator.args}
''