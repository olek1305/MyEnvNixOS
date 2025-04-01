{ config, pkgs, stable, wallpaper, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "olek1305";
    userEmail = "olek1305@gmail.com";
  };

  stylix.enable = true;

  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
      ];
    };
    settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-dark";
  };

  home.stateVersion = "25.05";
}