{ config, pkgs, ... }:

{
  home-manager.users.xaxa = {
    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
        ];
      };
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
