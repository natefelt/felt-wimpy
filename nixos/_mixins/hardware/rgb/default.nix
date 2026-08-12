{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.noughty) host;
  username = config.noughty.user.name;
  hostRGB = {
    kratos = "amd";
    skrye = "amd";
    zannah = "amd";
  };
  ratbagMice = {
    "kratos" = [
      "g502"
    ];
    "skrye" = [
      "g305"
    ];
    "zannah" = [
      "g305"
    ];
  };
  razerPeripherals = {
    skrye-disable = [
      "keyboard"
      "mouse"
    ];
    zannah-disable = [
      "keyboard"
      "mouse"
    ];
  };
in
lib.mkIf (!host.is.iso) {
  boot = lib.mkIf (builtins.hasAttr host.name hostRGB) {
    # for Corsair Vengeance memory on a Gigabyte motherboard
    kernelParams = [
      "acpi_enforce_resources=lax"
    ];
  };
  
  environment = {
    systemPackages =
      with pkgs;
      lib.optionals (builtins.hasAttr host.name razerPeripherals && host.is.workstation) [
        polychromatic
      ]
      ++ lib.optionals (builtins.hasAttr host.name ratbagMice && host.is.workstation) [
        piper
      ];
  };
  hardware = {
    i2c = lib.mkIf (builtins.hasAttr host.name hostRGB) {
      enable = true;
    };
    
    openrazer = lib.mkIf (builtins.hasAttr host.name razerPeripherals) {
      enable = true;
      devicesOffOnScreensaver = false;
      keyStatistics = true;
      batteryNotifier.enable = true;
      syncEffectsEnabled = true;
      users = [ "${username}" ];
    };
  };
  
  networking.firewall= lib.mkIf (builtins.hasAttr host.name hostRGB) {
    allowedTCPPorts = [ 6742 ];
  };
  
  services = {
    ratbagd = lib.mkIf (builtins.hasAttr host.name ratbagMice) {
      enable = true;
    };

    hardware.openrgb = lib.mkIf (builtins.hasAttr host.name hostRGB) {
      enable = true;
      motherboard = if builtins.hasAttr host.name hostRGB then hostRGB.${host.name} else null;
      package = pkgs.openrgb-with-all-plugins;
      server.port = 6742;
    };

    udev = lib.mkIf (builtins.hasAttr host.name hostRGB) {
      extraRules = builtins.readFile
        "${pkgs.openrgb}/lib/udev/rules.d/60-openrgb.rules";
    };
  };
}
