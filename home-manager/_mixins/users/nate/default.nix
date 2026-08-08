{
  config,
  lib,
  noughtyLib,
  pkgs,
  ...
}:
let
  username = config.noughty.user.name;
  host = config.noughty.host;
in
{
  imports = [
    ./atuin.nix
    ./git.nix
    ./mail.nix
    ./yubikey.nix
  ];

  config = lib.mkIf (noughtyLib.isUser [ "nate" ]) {
    sops.secrets = {

    };

    home = {
      file.".face".source = ./face.png;
      file."/projects/.keep" = {
        text = "";
      };
      file."/Games/.keep" = {
        text = "";
      };
      file."/Scripts/.keep" = {
        text = "";
      };
      file."/Zero/.keep".text = "";
      packages = lib.optionals (!(noughtyLib.hostHasTag "lima")) [
        pkgs.gocryptfs # Terminal encrypted filesystem
      ];
    };

    programs = {
      bash.shellAliases = lib.mkIf (host.is.linux && !(noughtyLib.hostHasTag "lima")) {
        lock-secrets = "fusermount -u ~/Vaults/Secrets";
        unlock-secrets = "${pkgs.gocryptfs}/bin/gocryptfs ~/Crypt/Secrets ~/Vaults/Secrets";
      };
      fish.loginShellInit = ''
        ${pkgs.figurine}/bin/figurine -f "DOS Rebel.flf" $hostname
      '';
      fish.shellAliases = lib.mkIf (host.is.linux && !(noughtyLib.hostHasTag "lima")) {
        lock-secrets = "fusermount -u ~/Vaults/Secrets";
        unlock-secrets = "${pkgs.gocryptfs}/bin/gocryptfs ~/Crypt/Secrets ~/Vaults/Secrets";
      };

      gpg = {
        scdaemonSettings.disable-ccid = true;
        settings = {
          trust-model = "tofu+pgp";
          # No version in signature
          no-emit-version = true;
          # Disable banner
          no-greeting = true;
          # Long hexidecimal key format
          keyid-format = "0xlong";
          # Display UID validity
          list-options = "show-uid-validity";
          verify-options = "show-uid-validity";
          # Display all keys and their fingerprints
          with-fingerprint = true;
          # Enable smartcard
          use-agent = true;
          # Disable recipient key ID in messages
          throw-keyids = true;
        };
        publicKeys = [
          {
            source = ./pgp.asc;
            trust = 5;
          }
        ];
      };
    };

    systemd.user.tmpfiles = lib.mkIf (host.is.linux && !(noughtyLib.hostHasTag "lima")) {
      rules = [
        "d ${config.home.homeDirectory}/Vaults/Secrets 0755 ${username} users - -"
      ];
    };
  };
}
