{
  config,
  lib,
  noughtyLib,
  pkgs,
  ...
}:
let
  inherit (config.noughty) host;
in
lib.mkIf (noughtyLib.isUser [ "nate" ] && host.is.linux && host.is.workstation) {
  home.packages = with pkgs; [
    yubikey-manager
  ];
}
