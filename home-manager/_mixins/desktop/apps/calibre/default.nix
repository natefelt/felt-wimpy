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
    with pkgs;
    [
      unstable.libation
      calibre
      # for use with acsm-calibre-plugin
      # https://github.com/Leseratte10/acsm-calibre-plugin/issues/68
      # (calibre.overrideAttrs (old: {
      #   postInstall = ''
      #     wrapProgram $out/bin/calibre \
      #         --set-default ACSM_LIBCRYPTO ${openssl.out}/lib/libcrypto.so \
      #         --set-default ACSM_LIBSSL ${openssl.out}/lib/libssl.so
      #   '';
      # }))
    ];
}
