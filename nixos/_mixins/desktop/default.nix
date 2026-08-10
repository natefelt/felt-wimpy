{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.noughty) host;
in
{
  imports = [
    ./apps
    ./backgrounds
    ./gnome
    ./hyprland
    ./wayfire
  ];

  config = lib.mkMerge [
    {
      xdg = {
        icons.enable = lib.mkDefault host.is.workstation;
        mime.enable = lib.mkDefault host.is.workstation;
        sounds.enable = lib.mkDefault host.is.workstation;

      };
    }
    (lib.mkIf (host.is.workstation && !host.is.iso) {
      boot = {
        consoleLogLevel = 0;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "loglevel=3"
          "vt.global_cursor_default=0"
          "mitigations=off"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
        ];
        plymouth = {
          enable = true;
          extraConfig = "UseSimpledrm=0";
          logo = pkgs.runCommand "transparent-plymouth-logo.png" { } ''
            ${pkgs.imagemagick}/bin/magick -size 1x1 xc:transparent PNG32:$out
          '';
        };
      };

      catppuccin.plymouth.enable = config.boot.plymouth.enable;

      # ssh key on yubikey
      environment.shellInit = ''
        gpg-connect-agent /bye
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      '';

      programs = {
        # https://wiki.nixos.org/w/index.php?title=Appimage
        # https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-appimageTools
        appimage = {
          enable = true;
          binfmt = true;
        };
        dconf = {
          enable = true;
        };
      };

      services = {
        dbus = {
          enable = lib.mkDefault true;
          implementation = lib.mkDefault "broker";
        };
        flatpak = {
          enable = true;
          update.auto = {
            enable = true;
            onCalendar = "weekly";
          };
        };
        gvfs.enable = true;
        udisks2.enable = true;
        usbmuxd.enable = true;
        xserver = {
          # Disable xterm
          desktopManager.xterm.enable = false;
          excludePackages = [ pkgs.xterm ];
        };
      };

      security.polkit.enable = lib.mkDefault true;

      xdg.portal.enable = true;
    })
    (lib.mkIf (host.is.workstation && host.desktop == "gnome") {
      xdg.portal = {
        enable = true;
        config = {
          common = {
            default = [ "gtk" ];
            # For "Open With" dialogs. GTK portal provides the familiar GNOME-style app chooser.
            "org.freedesktop.impl.portal.AppChooser" = [ "gtk" ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
            # Inhibit is useful for preventing sleep during media playback
            "org.freedesktop.impl.portal.Inhibit" = [ "gtk" ];
            # GTK portal gives you proper print dialogs.
            "org.freedesktop.impl.portal.Print" = [ "gtk" ];
            # Security/credentials
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
            # GTK portal provides desktop settings that GTK apps query (fonts, themes, colour schemes).
            "org.freedesktop.impl.portal.Settings" = [ "gtk" ];
          };
        };
        # Add xset to satisfy xdg-screensaver requirements
        configPackages = [
          pkgs.xset
        ];
        extraPortals = [
          pkgs.xdg-desktop-portal
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
      };
    })
  ];
}
