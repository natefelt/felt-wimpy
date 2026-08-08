{
  # config,
  lib,
  noughtyLib,
  pkgs,
  ...
}:
let
  # host = config.noughty.host;
  isZFS = noughtyLib.hostHasTag "zfs";
in
lib.mkIf isZFS {

  boot = {
    # (extraModulePackages = with config.boot.kernelPackages; [ zfs ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod;
    supportedFilesystems = [ "zfs" ];
  };
  environment.systemPackages = with pkgs; [
    zfs
  ];
}
