{ config, pkgs, stable, lib, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "olek1305";
      userEmail = "olek1305@gmail.com";
    };

    k9s = {
      enable = true;
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/windows-95.yaml";
    image = ../wallpapers/wallpaper.jpg;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

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