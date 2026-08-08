{
  catppuccinPalette,
  config,
  lib,
  noughtyLib,
  ...
}:
let
  inherit (config.noughty) host;
  isWorkspace = noughtyLib.hostHasTag "workspace";
in
lib.mkIf (host.is.workstation && !isWorkspace && noughtyLib.isUser [ "nate" ]) {
  programs = {
    chromium = {
      # - https://help.kagi.com/kagi/getting-started/setting-default.html
      extraOpts = {
        "DefaultSearchProviderAlternateURLs" = [ "https://www.startpage.com" ];
        # "DefaultSearchProviderImageURL" =
        #   "https://assets.kagi.com/v2/apple-touch-icon.png";
        "DefaultSearchProviderKeyword" = "startpage";
        "DefaultSearchProviderName" = "StartPage";
        "DefaultSearchProviderSearchURL" = "https://www.startpage.com/sp/search?query={searchTerms}";
        # "DefaultSearchProviderSuggestURL" =
        #   "https://kagi.com/api/autosuggest?q={searchTerms}";
        "HomePageLocation" = "https://www.startpage.com";
        "NewTabPageLocation" = "https://www.startpage.com";
        "PromptForDownloadLocation" = true;
      };
    };
    firefox = {
      policies = {
        # Check about:support for extension/add-on ID strings.
        ExtensionSettings = {
          "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/startpage-private-search/";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "gdpr@cavi.au.dk" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
            installation_mode = "force_installed";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
            installation_mode = "force_installed";
          };
          "easyscreenshot@mozillaonline.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/easyscreenshot/latest.xpi";
            installation_mode = "force_installed";
          };
          "newtaboverride@agenedia.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
            installation_mode = "force_installed";
          };
          "enterprise-policy-generator@agenedia.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/enterprise-policy-generator/latest.xpi";
            installation_mode = "force_installed";
          };
          "{2adf0361-e6d8-4b74-b3bc-3f450e8ebb69}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-${catppuccinPalette.flavor}-${catppuccinPalette.accent}-git/latest.xpi";
            installation_mode = "force_installed";
          };
          "{bbb880ce-43c9-47ae-b746-c3e0096c5b76}" = {
            install_url = "https://addons.mozilla.org/firefox/download/latest/catppuccin-web-file-icons/";
            installation_mode = "force_installed";
          };
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
            installation_mode = "force_installed";
          };
          "zotero@chnm.gmu.edu" = {
            install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.144";
            installation_mode = "force_installed";
          };
          "jordanlinkwarden@gmail.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/linkwarden/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@karakeep.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/karakeep/latest.xpi";
            installation_mode = "force_installed";
          };
          "materialdesignicons-picker@s-quent.in" = {
            install_url = "https://addons.mozilla.org/en-US/firefox/addon/materialdesignicons-picker/latest.xpi";
            installation_mode = "force_installed";
          };
          "harper@writewithharper.com" = {
            install_url = "https://addons.mozilla.org/en-US/firefox/addon/private-grammar-checker-harper/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        "Homepage" = {
          "StartPage" = lib.mkForce "previous-session";
          "URL" = "https://www.startpage.com";
        };
        "PromptForDownloadLocation" = true;
        "SearchEngines" = {
          "Add" = [
            {
              "Description" = "StartPage";
              "Method" = "GET";
              "Name" = "StartPage";
              "URLTemplate" = "https://www.startpage.com/sp/search?query={searchTerms}";
            }
            # {
            #   "Description" = "FeltPad";
            #   #"IconURL" = "https://assets.kagi.com/v2/apple-touch-icon.png";
            #   "Method" = "GET";
            #   "Name" = "FeltPad";
            #   # "SuggestURLTemplate" =
            #   #   "https://kagi.com/api/autosuggest?q={searchTerms}";
            #   "URLTemplate" = "https://search.feltpad.casa/search?q={searchTerms}";
            # }
          ];
          "Default" = "StartPage";
          "DefaultPrivate" = "StartPage";
          "Remove" = [
            "Bing"
            "Google"
          ];
        };
      };
    };
  };
}
