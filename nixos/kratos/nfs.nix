{
  # fileSystems."/mnt/nfs/backups" = {
  #   device = "10.1.226.2:/mnt/tank0/backups";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "x-systemd.idle-timeout=600"
  #     "noauto"
  #   ];
  # };

  fileSystems."/mnt/nfs/books" = {
    device = "10.1.226.2:/mnt/tank0/ebooks";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  # fileSystems."/mnt/nfs/downloads" = {
  #   device = "10.1.226.2:/mnt/tank0/downloads";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "x-systemd.idle-timeout=600"
  #     "noauto"
  #   ];
  # };

  # fileSystems."/mnt/nfs/paperless-old" = {
  #   device = "10.1.226.2:/mnt/tank0/paperless";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "x-systemd.idle-timeout=600"
  #     "noauto"
  #   ];
  # };

  # fileSystems."/mnt/nfs/paperless" = {
  #   device = "10.1.226.2:/mnt/tank0/documents/paperless";
  #   fsType = "nfs";
  #   options = [
  #     "x-systemd.automount"
  #     "x-systemd.idle-timeout=600"
  #     "noauto"
  #   ];
  # };

  fileSystems."/mnt/nfs/paperless" = {
    device = "10.1.226.2:/mnt/tank0/paperless";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/storage" = {
    device = "10.1.226.2:/mnt/storage";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/games" = {
    device = "10.1.33.16:/zfs-data/backups/games";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/music" = {
    device = "10.1.33.16:/zfs-data/music";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/cds" = {
    device = "10.1.33.16:/zfs-data/cds";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/usenet" = {
    device = "10.1.33.16:/zfs-data/usenet";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/home_video" = {
    device = "10.1.33.16:/zfs-data/home_video";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/document_scans" = {
    device = "10.1.226.2:/mnt/tank0/document_scans";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };

  fileSystems."/mnt/nfs/scans" = {
    device = "10.1.33.16:/zfs-data/scans";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noauto"
    ];
  };
}
