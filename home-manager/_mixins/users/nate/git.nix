{
  lib,
  noughtyLib,
  ...
}:
lib.mkIf (noughtyLib.isUser [ "nate" ]) {
  home = {
    sessionVariables = {
      GITSIGN_CONNECTOR_ID = "https://accounts.google.com";
    };
  };

  programs = {
    git = {
      settings = {
        user = {
          email = "nate@neetfelt.com";
          name = "Nate Felt";
        };
      };
      signing = {
        key = "nate@neetfelt.com";
        signByDefault = true;
      };
    };
    lazygit.settings.git.commit = {
      # Add Signed-off-by trailer to commits (DCO compliance)
      signOff = true;
    };
  };
}
