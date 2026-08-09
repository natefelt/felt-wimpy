{
  config,
  lib,
  noughtyLib,
  pkgs,
  ...
}:
let
  host = config.noughty.host;
in
lib.mkIf (host.is.workstation && host.is.linux && noughtyLib.hostHasTag "gnucash") {

  home.packages =
    with pkgs; [ gnucash];
}
