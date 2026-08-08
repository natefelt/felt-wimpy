{
  config,
  lib,
  noughtyLib,
  ...
}:
let
  inherit (config.noughty) host;
  name = "Nate Felt";
  common = rec {
    realName = "${name}";
    imap = {
      host = "moose.mxrouting.net";
      port = 993;
    };
    smtp = {
      host = "moose.mxrouting.net";
      port = 465;
    };
  };
in
lib.mkIf (noughtyLib.isUser [ "nate" ] && host.is.workstation) {
  accounts.email = {
    accounts = {
      "nate@neetfelt.com" = rec {
        primary = true;
        address = "nate@neetfelt.com";
        userName = address;
        aliases = [ "admin@neetfelt.com" ];
        thunderbird.enable = true;
        gpg = {
          key = "F1C694230456B9BB";
          signByDefault = true;
        };
        signature = {
          showSignature = "append";
          text = ''
            Regards,
            ${name}
            PGP: C912 4CA0 DEE8 3839 A4EB 6D1F F1C6 9423 0456 B9BB
          '';
        };
      }
      // common;
      "amazon@neetfelt.com" = rec {
        address = "amazon@neetfelt.com";
        userName = address;
        aliases = [ "orders@neetfelt.com" ];
        thunderbird.enable = true;
      }
      // common;
      "me@nathanielfelt.com" = rec {
        address = "me@nathanielfelt.com";
        userName = address;
        aliases = [ "admin@nathanielfelt.com" ];
        thunderbird.enable = true;
      }
      // common;
      "nate@feltpad.casa" = rec {
        address = "nate@feltpad.casa";
        userName = address;
        aliases = [ "admin@feltpad.casa" ];
        thunderbird.enable = true;
      }
      // common;
    };
  };

  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        nate = {
          isDefault = true;
          withExternalGnupg = true;
        };
      };
    };
  };
}
