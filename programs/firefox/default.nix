{ inputs, system, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      blanktiger = {
        search = {
          default = "https://duckduckgo.com/?q={}";
          engines = {
            duckduckgo = {
              name = "DuckDuckGo";
              keyword = "d";
              search = "https://duckduckgo.com/?q={}";
            };
            google = {
              name = "Google";
              keyword = "g";
              search = "https://www.google.com/search?q={}";
            };
            youtube = {
              name = "YouTube";
              keyword = "yt";
              search = "https://www.youtube.com/results?search_query={}";
            };
            github = {
              name = "GitHub";
              keyword = "gh";
              search = "https://github.com/search?q={}";
            };
          };
        };
        extensions = with inputs.firefox-addons.packages.${system}; [
          ublock-origin
          privacy-badger
          #https-everywhere
          vimium
          darkreader
          tree-style-tab
          bitwarden
        ];
        settings = {
          "browser.toolbars.bookmarks.visibility" = "never";
        };
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        '';
        userChrome = ''
@-moz-document url(chrome://browser/content/browser.xhtml) {
  /* tabs on bottom of window */
  /* requires that you set
   * toolkit.legacyUserProfileCustomizations.stylesheets = true
   * in about:config
   */
  #main-window body { flex-direction: column-reverse !important; }
  #navigator-toolbox { flex-direction: column-reverse !important; }
  #urlbar {
    top: unset !important;
    bottom: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
    box-shadow: none !important;
    display: flex !important;
    flex-direction: column !important;
  }
  #urlbar-input-container {
    order: 2;
  }
  #urlbar > .urlbarView {
    border-bottom: 1px solid #666;
    order: 1;
  }
  #urlbar-results {
    display: flex;
    flex-direction: column-reverse;
  }
  .search-one-offs { display: none !important; }
  .tab-background { border-top: none !important; }
  #navigator-toolbox::after { border: none; }
  #TabsToolbar .tabbrowser-arrowscrollbox,
  #tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
  .tabbrowser-tab { font-size: 80%; }
  .tab-content { padding: 0 5px; }
  .tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
  toolbox[inFullscreen=true] { display: none; }
  /*
   * the following makes it so that the on-click panels in the nav-bar
   * extend upwards, not downwards. some of them are in the #mainPopupSet
   * (hamburger + unified extensions), and the rest are in
   * #navigator-toolbox. They all end up with an incorrectly-measured
   * max-height (based on the distance to the _bottom_ of the screen), so
   * we correct that. The ones in #navigator-toolbox then adjust their
   * positioning automatically, so we can just set max-height. The ones
   * in #mainPopupSet do _not_, and so we need to give them a
   * negative margin-top to offset them *and* a fixed height so their
   * bottoms align with the nav-bar. We also calc to ensure they don't
   * end up overlapping with the nav-bar itself. The last bit around
   * cui-widget-panelview is needed because "new"-style panels (those
   * using "unified" panels) don't get flex by default, which results in
   * them being the wrong height.
   *
   * Oh, yeah, and the popup-notification-panel (like biometrics prompts)
   * of course follows different rules again, and needs its own special
   * rule.
   */
  #mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
  #mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
  #mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }
  #navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
  panelview.cui-widget-panelview { flex: 1; }
  panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
}
        '';
      };
    };
  };
}