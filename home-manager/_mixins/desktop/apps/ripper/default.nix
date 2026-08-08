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
{
  home.packages =
    with pkgs;
    lib.optionals (host.is.workstation && noughtyLib.hostHasTag "ripper") [
      cuetools
      exactaudiocopy
      whipper
      flac
      unstable.makemkv
      unstable.mkvtoolnix
      picard
    ];
}
