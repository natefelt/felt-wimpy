{
  lib,
  noughtyLib,
  pkgs,
  ...
}:
let
  enableZSA = noughtyLib.hostHasTag "zsa";
in
lib.mkIf enableZSA {
  # udev rules for ZSA keyboards i.e., moonlander, voyager, ergodox ez
  services.udev.packages = [ pkgs.zsa-udev-rules ];
  environment.systemPackages = [ pkgs.keymapp ];
}
