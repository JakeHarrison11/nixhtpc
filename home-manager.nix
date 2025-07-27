{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.backupFileExtension = "backup";

  home-manager.users.admin = {
    home.stateVersion = "25.05";

    programs.git = {
      enable = true;
      userName  = "Jake Harrison";
      userEmail = "jakebytes@gmail.com";
    };
  };

  home-manager.users.user = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "25.05";

    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
        };
      };
    };

    dconf.settings = {
      # no sleep (till brooklyn)
      "org/gnome/desktop/session" = {
        "idle-delay" = 28800;
      };
      # app shortcuts
      "org/gnome/shell" = {
        "favorite-apps" = [
          "org.gnome.Nautilus.desktop"
          "kodi.desktop"
          "firefox.desktop"
          "org.qbittorrent.qBittorrent.desktop"
          "mullvad-vpn.desktop"
          "org.gnome.Console.desktop"
        ];
      };
      # buttons make sense now
      "org/gnome/desktop/wm/preferences" = {
        "button-layout" = "appmenu:minimize,maximize,close";
      };
    };
  };
}
