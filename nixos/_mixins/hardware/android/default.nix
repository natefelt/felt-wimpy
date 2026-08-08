{
  config,
  lib,
  pkgs,
  ...
}:
let
  host = config.noughty.host;
  username = config.noughty.user.name;
in
lib.mkIf (!host.is.iso && host.is.workstation) {
  environment.systemPackages = with pkgs; [
    android-tools
  ];

  users.users.${username} = {
    extraGroups = [ "adbusers" ];
  };
}
