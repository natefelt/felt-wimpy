{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad

    ./disks.nix
    ./nfs.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "thunderbolt"
        "rtsx_pci_sdmmc"
      ];
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_zen;
  };

  services.kmscon.extraConfig = lib.mkForce ''
    xkb-layout=us
  '';
}
