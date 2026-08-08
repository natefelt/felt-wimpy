# nvme-CT4000T500SSD3_24254A17AC2B                    4TB:    NixOS
# nvme-Samsung_SSD_990_EVO_Plus_4TB_S7U8NJ0XA13706V   4TB:    Home
# wwn-0x5000cca253f2fa42                              12TB:   BTRFS Raid
# wwn-0x5000cca253d68b9b                              12TB:   BTRFS Raid

_: {
  disko.devices = {
    disk = {
      nvme2 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_990_EVO_Plus_4TB_S7U8NJ0XA13706V";
        content = {
          type = "gpt";
          partitions = {
            home-luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypthome";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                passwordFile = "/tmp/data.passwordFile";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "home"
                    "-f"
                  ];
                  subvolumes = {
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "subvol=home"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
