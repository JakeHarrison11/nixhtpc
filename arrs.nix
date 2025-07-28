{ config, pkgs, ... }:

{
  services = {
    prowlarr = {
      enable = true;
      openFirewall = true; # Port 9696
    };
    radarr = {
      enable = true;
      openFirewall = true; # Port 7878
      user = "user";
      group = "users";
      dataDir = "/home/user/arrs/radarr";
    };
    sonarr = {
      enable = true;
      openFirewall = true; # Port 8989
      user = "user";
      group = "users";
      dataDir = "/home/user/arrs/sonarr";
    };
  };
}
