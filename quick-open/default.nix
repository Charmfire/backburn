{pkgs, lib}: 
let
  term-emulator = (import ../backbone/term-emulator { inherit pkgs; });
in
pkgs.writeShellScriptBin "backburn-quick"
''
  ${term-emulator.bin} ${lib.strings.join " " term-emulator.args}
''