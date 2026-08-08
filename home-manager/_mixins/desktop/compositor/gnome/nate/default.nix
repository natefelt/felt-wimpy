{
  config,
  lib,
  noughtyLib,
  ...
}:
let
  host = config.noughty.host;
in
{
  config = lib.mkIf (noughtyLib.isUser [ "nate" ] && host.desktop == "gnome") {
    # User specific dconf settings; only intended as override for NixOS dconf profile user database
    dconf.settings =
      with lib.hm.gvariant;
      lib.mkIf host.is.linux {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>e";
          name = "File Manager";
          command = "nautilus -w ~/";
        };

        "org/gnome/desktop/background" = {
          picture-options = "zoom";
        }
        // lib.optionalAttrs (host.name == "kratos") {
          picture-uri = "file:///etc/backgrounds/Catppuccin-3440x1440.png";
          picture-uri-dark = "file:///etc/backgrounds/Catppuccin-3440x1440.png";
        }
        //
          lib.optionalAttrs (host.name == "echoleaf" || host.name == "mercury" || host.name == "thunderheart")
            {
              picture-uri = "file:///etc/backgrounds/Catppuccin-1920x1080.png";
              picture-uri-dark = "file:///etc/backgrounds/Catppuccin-1920x1080.png";
            };

        "org/gnome/desktop/screensaver" = {
          picture-uri = "file://etc/backgrounds/Catppuccin-3840x2160.png";
        };

        "org/gnome/desktop/input-sources" = {
          xkb-options = [
            "grp:alt_shift_toggle"
            "caps:none"
          ];
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = mkInt32 8;
          workspace-names = [
            "Web"
            "Work"
            "Chat"
            "Code"
            "Term"
            "Note"
            "Virt"
            "Fun"
          ];
        };

        "org/gnome/desktop/default/applications/terminal" = {
          exec = "kitty";
          exec-arg = "-e";
        };

        "org/gnome/mutter" = {
          # Disable Mutter edge-tiling because tiling-assistant extension handles it
          edge-tiling = false;
        };

        "org/gnome/mutter/keybindings" = {
          # Disable Mutter toggle-tiled because tiling-assistant extension handles it
          toggle-tiled-left = mkEmptyArray type.string;
          toggle-tiled-right = mkEmptyArray type.string;
        };

        "org/gnome/shell" = {
          disabled-extensions = mkEmptyArray type.string;
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
            #"dash-to-dock@micxgx.gmail.com"
            "emoji-copy@felipeftn"
            "freon@UshakovVasilii_Github.yahoo.com"
            "just-perfection-desktop@just-perfection"
            "logomenu@aryan_k"
            "start-overlay-in-application-view@Hex_cz"
            "tiling-assistant@leleat-on-github"
            "Vitals@CoreCoding.com"
            "wireless-hid@chlumskyvaclav.gmail.com"
            "wifiqrcode@glerro.pm.me"
            "workspace-switcher-manager@G-dH.github.com"
          ];
          favorite-apps = [
            "firefox.desktop"
            "org.telegram.desktop.desktop"
            "discord.desktop"
            "org.gnome.Fractal.desktop"
            "org.squidowl.halloy.desktop"
            "code.desktop"
          ];
        };

        "org/gnome/shell/extensions/auto-move-windows" = {
          application-list = [
            "firefox.desktop:1"
            "discord.desktop:3"
            "org.telegram.desktop.desktop:3"
            "org.squidowl.halloy.desktop:3"
            "org.gnome.Fractal.desktop:3"
            "code.desktop:4"
          ];
        };

        "org/gnome/shell/extensions/dash-to-dock" = {
          background-opacity = mkDouble 0.0;
          transparency-mode = "FIXED";
        };

        "org/gnome/shell/extensions/freon" = {
          hot-sensors = [ "__average__" ];
        };

        "org/gnome/shell/extensions/Logo-menu" = {
          menu-button-system-monitor = "gnome-usage";
          menu-button-terminal = "kitty";
        };

        "org/gnome/shell/extensions/tiling-assistant" = {
          enable-advanced-experimental-features = true;
          show-layout-panel-indicator = true;
          single-screen-gap = mkInt32 10;
          window-gap = mkInt32 10;
          maximize-with-gap = true;
        };

        "org/gnome/shell/extensions/vitals" = {
          alphabetize = false;
          fixed-widths = true;
          include-static-info = false;
          menu-centered = true;
          monitor-cmd = "gnome-usage";
          network-speed-format = mkInt32 1;
          show-fan = false;
          show-temperature = false;
          show-voltage = false;
          update-time = mkInt32 2;
          use-higher-precision = false;
        };

        "org/gnome/desktop/wm/keybindings" = {
          # Disable maximise/unmaximise because tiling-assistant extension handles it
          maximize = mkEmptyArray type.string;
          unmaximize = mkEmptyArray type.string;
        };
      };
  };
}
