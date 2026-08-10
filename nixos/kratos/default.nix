# Motherboard:       Gigabyte X870E Aorus Elite WiFi7
# CPU:               AMD Ryzen 7 9800X3D
# GPU:               AMD Radeon RX 7900 XT
# RAM:               96GB DDR5
# NVME0:             4TB Samsung EVO Plus
# NVME1:             4TB Crucial T500

{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./disks.nix
    ./disks-home.nix
    ./nfs.nix
  ];

  boot = {
    #initrd = {
    #  network = {
    #    enable = true;
    #    ssh = {
    #      enable = true;
    #      hostKeys = [ "/etc/ssh/initrd_ssh_host_ed25519_key" ];
    #      ignoreEmptyHostKeys = true;
    #      port = 2222;
    #    };
    #  };
    #  systemd.enable = true;
    #};

    # Ethernet card detected, but not initialized
    # https://github.com/NixOS/nixos-hardware/issues/1202
    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "r8169" # Realtek 2.5Gbe
      "sg" # MakeMKV
    ];

    # kernelParams = [
    #   "video=DP-1:3440x1440@60"
    #   "video=DP-2:3440x1440@60"
    #   "video=HDMI-1:1920x1080@60"
    # ];

    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_stable;
  };

  services.printing.drivers = [
    pkgs.hplip
    pkgs.gutenprint
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  # systemd.sleep.extraConfig = ''
  #   ExecPre=/run/current-system/sw/bin/openrgb --mode direct --color 000000
  #   ExecPost=/run/current-system/sw/bin/openrgb --mode direct --color FF0000
  # '';

  systemd.services = {
    openrgb-pre-sleep = {
      description = "Turn off RGB before sleep";
      wantedBy = [ "sleep.target" ];
      before = [ "sleep.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/openrgb --mode direct --color 000000";
      };
    };
    openrgb-post-resume = {
      description = "Restore RGB after resume";
      wantedBy = [ "suspend.target" ];
      after = [ "suspend.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          /run/current-system/sw/bin/sh -c "/run/current-system/sw/bin/sleep 5 && /run/current-system/sw/bin/openrgb --mode direct --color FF0000"
        '';
      };
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        2234 # soulseek
        9090 # calibre
      ];
      allowedUDPPorts = [
        9090 # calibre
      ];
    };
  };
}
