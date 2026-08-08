{
  fileSystems."/mnt/nfs/backups" = {
    device = "10.1.226.2:/mnt/tank0/backups";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/books" = {
    device = "10.1.226.34:/srv/ebooks";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/downloads" = {
    device = "10.1.226.2:/mnt/tank0/downloads";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/paperless" = {
    device = "10.1.226.2:/mnt/tank0/documents/paperless";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/storage" = {
    device = "10.1.226.34:/srv/storage";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };
}
