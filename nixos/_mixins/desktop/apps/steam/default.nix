{
  config,
  lib,
  noughtyLib,
  pkgs,
  ...
}:
lib.mkIf
  (noughtyLib.isHost [
    "skrye"
    "zannah"
    "kratos"
    "mercury"
  ])
  {
    # Only include mangohud if Steam is enabled
    environment.systemPackages =
      with pkgs;
      lib.mkIf config.programs.steam.enable [
        mangohud
        dotnet-sdk_8 # dotnet-sdk_8 for tmodloader
        prismlauncher
        (lutris.override {
          extraLibraries = _p: [
            # extra libraries here
          ];
          extraPkgs = p: [
            p.wineWow64Packages.stable
            p.winetricks
            p.pixman
            p.libjpeg
            p.zenity
          ];
        })
      ];
    # https://nixos.wiki/wiki/Steam
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
  }
