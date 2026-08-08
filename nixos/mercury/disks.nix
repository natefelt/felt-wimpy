_: {
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_2TB_24113T807001";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              end = "1024MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                passwordFile = "/tmp/data.passwordFile";
                content = {
                  extraArgs = [ "-f" ];
                  format = "xfs";
                  mountOptions = [
                    "defaults"
                    "relatime"
                    "nodiratime"
                  ];
                  mountpoint = "/";
                  type = "filesystem";
                };
              };
            };
          };
        };
      };
    };
  };
}
